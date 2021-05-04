import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/widgets/InteractiveLabelItem.dart';
import '../utils/PlatformUtils.dart';
import 'package:flutter_test_app/widgets/OrderCardBookmarkItem.dart';
import 'package:flutter_test_app/widgets/CustomTextField.dart';
import 'package:flutter_test_app/widgets/TitleGoodPropertyItem.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart' as strings;
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class NewGoodScreen extends StatefulWidget {
  @override
  _NewGoodScreenState createState() => _NewGoodScreenState();
}

class _NewGoodScreenState extends State<NewGoodScreen> {
  final _nameTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _expirationDateTextController = TextEditingController();
  final _priceTextController = TextEditingController();
  final _whenToPickUpTextController = TextEditingController();

  @override
  void dispose() {
    _nameTextController.dispose();
    _descriptionTextController.dispose();
    _expirationDateTextController.dispose();
    _priceTextController.dispose();
    _whenToPickUpTextController.dispose();
    super.dispose();
  }

  final _nameKey = GlobalKey<FormState>();
  final _sellerKey = GlobalKey<FormState>();
  final _descriptionKey = GlobalKey<FormState>();
  final _expirationDateKey = GlobalKey<FormState>();
  final _priceKey = GlobalKey<FormState>();
  final _whenToPickUpKey = GlobalKey<FormState>();
  final _whereToPickUpKey = GlobalKey<FormState>();

  List<UnitDropDownItem> units = <UnitDropDownItem>[
    UnitDropDownItem('за кг.'),
    UnitDropDownItem('за литр'),
    UnitDropDownItem('за 100гр.'),
    UnitDropDownItem('за штуку'),
    UnitDropDownItem('за пакет')
  ];

  UnitDropDownItem selectedUnit;

  List<OwnerDropDownItem> owners = <OwnerDropDownItem>[
    OwnerDropDownItem('CookiesHome',
        'https://i.pinimg.com/originals/c7/df/12/c7df122cffc23fea28b0ec1c9874534d.jpg'),
    OwnerDropDownItem('Мария',
        'https://uhd.name/uploads/posts/2020-09/1600723784_22-p-mariya-kozakova-85.jpg'),
  ];

  OwnerDropDownItem selectedOwner;

  TextEditingController queryController = TextEditingController();
  String response = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsLibrary.whiteColor,
        elevation: 0,
        title: Text(createGood,
            style: StylesLibrary.strongBlackTextStyle
                .merge(const TextStyle(fontSize: 16))),
        leading: CloseButton(
          color: ColorsLibrary.primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(children: [
        Column(children: <Widget>[
          buildTitleGoodPropertyItem(nameOfGood, context),
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
          buildTitleGoodPropertyItem(seller, context),
          Form(
            key: _sellerKey,
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 6),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(
                    color: ColorsLibrary.neutralGray, // set border color
                    width: 1.0), // set border width
                borderRadius: BorderRadius.all(
                    Radius.circular(30)), // set rounded corner radius
              ),
              child: DropdownButtonFormField<OwnerDropDownItem>(
                icon: Icon(
                  CupertinoIcons.chevron_down,
                  color: ColorsLibrary.primaryColor,
                  size: 18,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                hint: Text(
                  "Выберите продавца",
                  style: selectByPlatform(
                          StylesLibrary.IOSPrimaryBlackTextStyle,
                          StylesLibrary.AndroidPrimaryBlackTextStyle)
                      .merge(const TextStyle(
                          fontSize: 15, color: ColorsLibrary.middleBlack)),
                ),
                value: selectedOwner,
                onChanged: (value) {
                  setState(() {
                    selectedOwner = value;
                  });
                },
                items: owners.map((OwnerDropDownItem owner) {
                  return DropdownMenuItem<OwnerDropDownItem>(
                    value: owner,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                                owner.ownerProfileImage.toString(),
                                height: 45,
                                width: 45,
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          width: 220,
                          child: Text(
                            owner.ownerName,
                            style: selectByPlatform(
                                    StylesLibrary.IOSPrimaryBlackTextStyle,
                                    StylesLibrary.AndroidPrimaryBlackTextStyle)
                                .merge(const TextStyle(
                                    fontSize: 15,
                                    color: ColorsLibrary.middleBlack)),
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          buildTitleGoodPropertyItem(descriptionOfGood, context),
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
          buildTitleGoodPropertyItem(expirationDate, context),
          Form(
            key: _expirationDateKey,
            child: buildCustomTextField(
                CustomTextField(
                    50,
                    MediaQuery.of(context).size.width,
                    30,
                    TextInputType.datetime,
                    TextInputAction.newline,
                    1,
                    1,
                    'дд.мм.гггг или дд-мм-гггг', (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите срок годности';
                  }
                  RegExp regExp = new RegExp(
                      r"^(0[1-9]|[12][0-9]|3[01])[-|.](0[1-9]|1[012])[-|.](19|20)\d\d$");
                  if (regExp.hasMatch(value.toString())) {
                    return null;
                  } else {
                    return 'Неверный формат даты';
                  }
                }, _expirationDateTextController),
                context),
          ),
          buildTitleGoodPropertyItem(priceAndFree, context),
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
                          RegExp regExp = new RegExp(r'^[0-9]+$');
                          if (regExp.hasMatch(value.toString())) {
                            return null;
                          } else {
                            return 'Используйте только цифры';
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
                          value: selectedUnit,
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
          buildTitleGoodPropertyItem(whenToPickUp, context),
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
          buildTitleGoodPropertyItem(whereToPickUp, context),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: ProgressButton(
                progressWidget: CircularProgressIndicator(
                    backgroundColor: ColorsLibrary.whiteColor),
                color: ColorsLibrary.primaryColor,
                width: MediaQuery.of(context).size.width,
                height: 45,
                borderRadius: 30,
                onPressed: () async {
                  int score = await Future.delayed(
                      const Duration(milliseconds: 3000), () => 42);
                  return () {};
                },
                defaultWidget: Text(strings.create,
                    style: selectByPlatform(
                            StylesLibrary.IOSPrimaryWhiteTextStyle,
                            StylesLibrary.AndroidPrimaryWhiteTextStyle)
                        .merge(const TextStyle(
                            color: ColorsLibrary.whiteColor, fontSize: 17))),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: queryController,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  querySuggestions(queryController.text);
                },
                child: Text('Query'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Response:'),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(child: Text(response)),
            ],
          ),
        ])
      ]),
    );
  }

  Future<void> querySuggestions(String query) async {
    final cancelListening = await YandexSearch.getSuggestions(
        query,
        const Point(latitude: 55.5143, longitude: 37.24841),
        const Point(latitude: 56.0421, longitude: 38.0284),
        "SuggestType.geo",
        true, (List<SuggestItem> suggestItems) {
      setState(() {
        response =
            suggestItems.map((SuggestItem item) => item.title).join('\n');
      });
    });
    await Future<dynamic>.delayed(
        const Duration(seconds: 3), () => cancelListening());
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
