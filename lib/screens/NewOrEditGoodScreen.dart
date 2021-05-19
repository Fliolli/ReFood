import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/FoodItem.dart';
import 'package:flutter_test_app/models/persistant/FoodModel.dart';
import 'package:flutter_test_app/screens/GoodsScreen.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/screens/AddressSearchScreen.dart';
import 'package:flutter_test_app/services/PlaceApiProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import '../utils/PlatformUtils.dart';
import 'package:flutter_test_app/widgets/CustomTextField.dart';
import 'package:flutter_test_app/widgets/PropertyTitleItem.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart' as strings;
import 'package:flutter_test_app/data/GlobalData.dart' as global;
import 'package:flutter_progress_button/flutter_progress_button.dart';
import "package:google_maps_webservice/geocoding.dart";
import 'package:flutter_test_app/services/Authentication.dart';

import 'dart:async';

// ignore: must_be_immutable
class NewOrEditGoodScreen extends StatefulWidget {
  NewOrEditGoodScreen({
    Key key,
    this.screenType,
    this.id,
    this.name,
    this.description,
    this.image,
    this.expirationDate,
    this.price,
    this.unit,
    this.whenToPickUp,
    this.whereToPickUp,
    this.isFree,
  });

  NewOrEditGoodScreen.newGood({Key key, this.screenType});

  global.ScreenType screenType;
  int id;
  String name;
  String description;
  String image;
  DateTime expirationDate;
  double price;
  String unit;
  String whenToPickUp;
  String whereToPickUp;
  bool isFree;

  @override
  _NewOrEditGoodScreenState createState() => _NewOrEditGoodScreenState();
}

class _NewOrEditGoodScreenState extends State<NewOrEditGoodScreen> {
  final _nameTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _expirationDateTextController = TextEditingController();
  final _priceTextController = TextEditingController();
  final _whenToPickUpTextController = TextEditingController();
  final _whereToPickUpTextController = TextEditingController();
  final _massTextController = TextEditingController();

  @override
  void dispose() {
    _nameTextController.dispose();
    _descriptionTextController.dispose();
    _expirationDateTextController.dispose();
    _priceTextController.dispose();
    _whenToPickUpTextController.dispose();
    _massTextController.dispose();
    super.dispose();
  }

  final _nameKey = GlobalKey<FormState>();
  final _descriptionKey = GlobalKey<FormState>();
  final _photoKey = GlobalKey<FormState>();
  final _expirationDateKey = GlobalKey<FormState>();
  final _priceKey = GlobalKey<FormState>();
  final _whenToPickUpKey = GlobalKey<FormState>();
  final _whereToPickUpKey = GlobalKey<FormState>();
  final _massKey = GlobalKey<FormState>();

  List<UnitDropDownItem> units = <UnitDropDownItem>[
    UnitDropDownItem(strings.thingUnit),
    UnitDropDownItem(strings.kgUnit),
    UnitDropDownItem(strings.literUnit),
    UnitDropDownItem(strings.gr100Unit),
    UnitDropDownItem(strings.packetUnit)
  ];

  UnitDropDownItem selectedUnit;

  TextEditingController queryController = TextEditingController();
  static List<String> response = <String>[];

  File imageFile;

  String addressID;

  DateTime selectedExpirationDate;

  final geocoding = GoogleMapsGeocoding(
      apiKey: Platform.isIOS
          ? 'AIzaSyCRZguDFpDMVrlPy-tqJR6YSePT237eHyc'
          : "AIzaSyDeWEmtAR98Oxm19lCOu1eEdwtDUKrHGjk");

  CollectionReference foods = FirebaseFirestore.instance
      .collection('foods')
      .withConverter(
          fromFirestore: (snapshot, _) => FoodModel.fromJson(snapshot.data()),
          toFirestore: (food, _) => (food as FoodModel).toJson());

  @override
  Widget build(BuildContext context) {
    if (widget.screenType == global.ScreenType.editGood) {
      selectedUnit = UnitDropDownItem(widget.unit);
      _nameTextController.text = widget.name;
      _descriptionTextController.text = widget.description;
      _expirationDateTextController.text =
          DateFormat("dd-MM-yyyy").format(widget.expirationDate);
      _priceTextController.text = widget.price.toString();
      _whenToPickUpTextController.text = widget.whenToPickUp;
      _whereToPickUpTextController.text = widget.whereToPickUp;
      _massTextController.text = global.foodItem.mass.toString();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsLibrary.whiteColor,
        elevation: 0,
        title: Text(
            widget.screenType == global.ScreenType.newGood ? createGood : edit,
            style: StylesLibrary.strongBlackTextStyle
                .merge(const TextStyle(fontSize: 16))),
        leading: CloseButton(
          color: ColorsLibrary.primaryColor,
          onPressed: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(children: [
        Column(children: <Widget>[
          buildPropertyTitleItem(nameOfGood, context),
          Form(
            key: _nameKey,
            child: buildCustomTextField(
                CustomTextField(
                    50,
                    MediaQuery.of(context).size.width,
                    30,
                    TextInputType.name,
                    TextInputAction.next,
                    1,
                    1,
                    'Что выставить на витрину?', (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название товара';
                  }
                  return null;
                }, _nameTextController),
                context),
          ),
          buildPropertyTitleItem(descriptionOfGood, context),
          Form(
            key: _descriptionKey,
            child: buildCustomTextField(
                CustomTextField(
                    130,
                    MediaQuery.of(context).size.width,
                    30,
                    TextInputType.multiline,
                    TextInputAction.newline,
                    6,
                    1,
                    'Опишите товар, обозначьте его доступное количество..',
                    (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите описание товара';
                  }
                  return null;
                }, _descriptionTextController),
                context),
          ),
          buildPropertyTitleItem(massOfGood, context),
          Form(
            key: _massKey,
            child: buildCustomTextField(
                CustomTextField(
                    50,
                    MediaQuery.of(context).size.width,
                    30,
                    TextInputType.number,
                    TextInputAction.done,
                    1,
                    1,
                    'Обозначьте массу товара в килограммах..', (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите массу товара';
                  }
                  RegExp regExp = new RegExp(r'^[0-9]+.[0-9]+$');
                  if (regExp.hasMatch(value.toString())) {
                    return null;
                  } else {
                    return 'Некоректный формат. Пример: 3.0';
                  }
                }, _massTextController),
                context),
          ),
          buildPropertyTitleItem(photoOfGood, context),
          Form(
              key: _photoKey,
              child: Container(
                margin: EdgeInsets.only(top: 6, left: 32),
                alignment: Alignment.centerLeft,
                child: InkWell(
                  child: imageFile == null
                      ? Image.asset(
                          "assets/images/addImage.png",
                          fit: BoxFit.cover,
                          height: 90,
                          width: 90,
                        )
                      : Image.memory(imageFile.readAsBytesSync(),
                          gaplessPlayback: true),
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext builder) {
                          return Container(
                              height: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height /
                                  5,
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        _getFromGallery();
                                      },
                                      child: Text(
                                        "Галерея",
                                        style: selectByPlatform(
                                                StylesLibrary
                                                    .IOSPrimaryBlackTextStyle,
                                                StylesLibrary
                                                    .AndroidPrimaryBlackTextStyle)
                                            .merge(const TextStyle(
                                                fontSize: 18,
                                                color:
                                                    ColorsLibrary.middleBlack)),
                                      ),
                                    ),
                                    Divider(),
                                    TextButton(
                                      onPressed: () {
                                        _getFromCamera();
                                      },
                                      child: Text(
                                        "Камера",
                                        style: selectByPlatform(
                                                StylesLibrary
                                                    .IOSPrimaryBlackTextStyle,
                                                StylesLibrary
                                                    .AndroidPrimaryBlackTextStyle)
                                            .merge(const TextStyle(
                                                fontSize: 18,
                                                color:
                                                    ColorsLibrary.middleBlack)),
                                      ),
                                    )
                                  ],
                                ),
                              ));
                        });
                  },
                ),
              )),
          buildPropertyTitleItem(expirationDate, context),
          Form(
            key: _expirationDateKey,
            child: Container(
                margin: EdgeInsets.only(top: 6, right: 16, left: 16),
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorsLibrary.neutralGray, // set border color
                        width: 1.0), // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(30)), // set rounded corner radius
                  ),
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                                height: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height /
                                    3,
                                child: CupertinoDatePicker(
                                  initialDateTime: DateTime.now(),
                                  onDateTimeChanged: (DateTime date) {
                                    setState(() {
                                      _expirationDateTextController.text =
                                          DateFormat("dd-MM-yyyy").format(date);
                                      selectedExpirationDate = date;
                                    });
                                  },
                                  use24hFormat: true,
                                  minimumYear: DateTime.now().year,
                                  maximumYear: DateTime.now().year + 30,
                                  minuteInterval: 1,
                                  mode: CupertinoDatePickerMode.date,
                                ));
                          });
                    },
                    style: selectByPlatform(
                            StylesLibrary.IOSPrimaryBlackTextStyle,
                            StylesLibrary.AndroidPrimaryBlackTextStyle)
                        .merge(const TextStyle(
                            fontSize: 15, color: ColorsLibrary.middleBlack)),
                    cursorColor: ColorsLibrary.primaryColor,
                    controller: _expirationDateTextController,
                    cursorHeight: 24,
                    cursorWidth: 1,
                    maxLines: 1,
                    minLines: 1,
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecoration(
                      errorStyle: selectByPlatform(
                              StylesLibrary.IOSPrimaryBlackTextStyle,
                              StylesLibrary.AndroidPrimaryBlackTextStyle)
                          .merge(const TextStyle(
                              fontSize: 12, color: ColorsLibrary.primaryColor)),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                      hintText: 'дд-мм-гггг',
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                )),
          ),
          buildPropertyTitleItem(priceAndFree, context),
          Form(
              key: _priceKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    buildCustomTextField(
                        CustomTextField(
                            50,
                            160,
                            30,
                            TextInputType.number,
                            TextInputAction.done,
                            1,
                            1,
                            'Обозначьте цену..', (String value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите цену товара';
                          }
                          RegExp regExp = new RegExp(r'^[0-9]+.[0-9]+$');
                          if (regExp.hasMatch(value.toString())) {
                            return null;
                          } else {
                            return 'Пример: 15.0';
                          }
                        }, _priceTextController),
                        context),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Container(
                        padding: EdgeInsets.only(left: 24, right: 12),
                        width: 148,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  ColorsLibrary.neutralGray, // set border color
                              width: 1.0), // set border width
                          borderRadius: BorderRadius.all(
                              Radius.circular(30)), // set rounded corner radius
                        ),
                        child: DropdownButtonFormField<UnitDropDownItem>(
                          icon: Icon(
                            CupertinoIcons.chevron_down,
                            color: ColorsLibrary.primaryColor,
                            size: 18,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          hint: Text(
                            "Измерение",
                            style: selectByPlatform(
                                    StylesLibrary.IOSPrimaryBlackTextStyle,
                                    StylesLibrary.AndroidPrimaryBlackTextStyle)
                                .merge(const TextStyle(
                                    fontSize: 15,
                                    color: ColorsLibrary.middleBlack)),
                          ),
                          value: widget.unit != null
                              ? units
                                  .where(
                                      (element) => element.title == widget.unit)
                                  .first
                              : selectedUnit,
                          onChanged: (UnitDropDownItem value) {
                            setState(() {
                              selectedUnit = value;
                            });
                          },
                          items: units.map((UnitDropDownItem unit) {
                            return DropdownMenuItem<UnitDropDownItem>(
                              value: unit,
                              child: Text(
                                unit.title,
                                style: selectByPlatform(
                                        StylesLibrary.IOSPrimaryBlackTextStyle,
                                        StylesLibrary
                                            .AndroidPrimaryBlackTextStyle)
                                    .merge(const TextStyle(
                                        fontSize: 15,
                                        color: ColorsLibrary.middleBlack)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          buildPropertyTitleItem(whenToPickUp, context),
          Form(
            key: _whenToPickUpKey,
            child: buildCustomTextField(
                CustomTextField(
                    75,
                    MediaQuery.of(context).size.width,
                    30,
                    TextInputType.multiline,
                    TextInputAction.newline,
                    3,
                    1,
                    'Обозначьте время, когда вам удобно передать товар..',
                    (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите удобное время';
                  }
                  return null;
                }, _whenToPickUpTextController),
                context),
          ),
          buildPropertyTitleItem(whereToPickUp, context),
          Form(
            key: _whereToPickUpKey,
            child: Container(
                margin: EdgeInsets.only(top: 6, right: 16, left: 16),
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorsLibrary.neutralGray, // set border color
                        width: 1.0), // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(30)), // set rounded corner radius
                  ),
                  child: TextFormField(
                    readOnly: true,
                    onTap: () async {
                      final sessionToken = Uuid().v4();
                      final PlaceSuggestion result = await showSearch(
                        context: context,
                        delegate: AddressSearch(sessionToken),
                      );
                      if (result != null) {
                        addressID = result.placeId;
                        setState(() {
                          _whereToPickUpTextController.text =
                              result.description;
                        });
                      }
                    },
                    style: selectByPlatform(
                            StylesLibrary.IOSPrimaryBlackTextStyle,
                            StylesLibrary.AndroidPrimaryBlackTextStyle)
                        .merge(const TextStyle(
                            fontSize: 15, color: ColorsLibrary.middleBlack)),
                    cursorColor: ColorsLibrary.primaryColor,
                    controller: _whereToPickUpTextController,
                    cursorHeight: 24,
                    cursorWidth: 1,
                    maxLines: 1,
                    minLines: 1,
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecoration(
                      errorStyle: selectByPlatform(
                              StylesLibrary.IOSPrimaryBlackTextStyle,
                              StylesLibrary.AndroidPrimaryBlackTextStyle)
                          .merge(const TextStyle(
                              fontSize: 12, color: ColorsLibrary.primaryColor)),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                      hintText: 'Обозначьте адрес, где можно получить товар..',
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                )),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: ProgressButton(
                progressWidget: CircularProgressIndicator(
                    backgroundColor: ColorsLibrary.whiteColor),
                color: ColorsLibrary.primaryColor,
                width: MediaQuery.of(context).size.width,
                height: 50,
                borderRadius: 30,
                onPressed: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  await createFoodItem();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GoodsScreen()));
                },
                defaultWidget: Text(strings.create,
                    style: selectByPlatform(
                            StylesLibrary.IOSPrimaryWhiteTextStyle,
                            StylesLibrary.AndroidPrimaryWhiteTextStyle)
                        .merge(const TextStyle(
                            color: ColorsLibrary.whiteColor, fontSize: 17))),
              )),
        ])
      ]),
    );
  }

  _getFromGallery() async {
    if (await Permission.mediaLibrary.isGranted) {
      PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 90,
        maxHeight: 90,
      );
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      }
    } else {
      openAppSettings();
    }
  }

  _getFromCamera() async {
    if (await Permission.mediaLibrary.isGranted) {
      PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 90,
        maxHeight: 90,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
        });
      }
    } else {
      openAppSettings();
    }
  }

  Future<void> createFoodItem() async {
    var foodItem = FoodModel(
        image: imageFile.toString(),
        name: _nameTextController.text,
        price: double.parse(_priceTextController.text),
        unit: selectedUnit.title,
        ownerID: (await Authentication().getCurrentUser()).uid,
        bookmarksCount: 0,
        addMoment: DateTime.now(),
        description: _descriptionTextController.text,
        whereToPickUp: addressID,
        whenToPickUp: _whenToPickUpTextController.text,
        expirationDate: selectedExpirationDate,
        mass: double.parse(_massTextController.text));
    var id = foodItem.hashCode.toString();
    foodItem.id = id;
    return foods
        .doc(id)
        .set(foodItem)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}

class NewGood {
  String image;
  String name;
  int price;
  String unit;
  String ownerName;
  String ownerProfileImage;
  String description;
  String location;
  String pickUpTimes;
  DateTime expirationDate;
  bool isFree;

  NewGood(
      this.image,
      this.name,
      this.price,
      this.unit,
      this.ownerName,
      this.ownerProfileImage,
      this.description,
      this.location,
      this.pickUpTimes,
      this.expirationDate,
      this.isFree);
}

class UnitDropDownItem {
  String title;

  UnitDropDownItem(this.title);
}

class OwnerDropDownItem {
  String ownerName;
  String ownerProfileImage;

  OwnerDropDownItem(this.ownerName, this.ownerProfileImage);
}
