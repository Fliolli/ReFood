import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/GlobalData.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/screens/NewOrEditGoodScreen.dart';
import '../utils/PlatformUtils.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:intl/intl.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;
import 'package:flutter_test_app/resources/StringsLibrary.dart' as strings;
import 'package:flutter_test_app/widgets/InfoPropertyItem.dart';

class GoodItemInfoScreen extends StatefulWidget {
  GoodItemInfoScreen(
      {Key key,
      this.goodType,
      this.id,
      this.image,
      this.name,
      this.price,
      this.unit,
      this.expirationDate,
      this.isFree});

  final global.GoodType goodType;
  final String id;
  final String image;
  final String name;
  final double price;
  final String unit;
  final DateTime expirationDate;
  final bool isFree;

  @override
  _GoodItemInfoScreenState createState() => _GoodItemInfoScreenState();
}

class _GoodItemInfoScreenState extends State<GoodItemInfoScreen> {
  final List<String> popUpMenuItems = [
    "Редактировать",
    "Удалить",
  ];

  final List<String> popUpMenuItemsTrimmed = [
    "Удалить",
  ];
  //поиск позиции по id, а пока берется из GlobalData

  @override
  Widget build(BuildContext context) {
    InfoPropertyItem expirationDateItem = InfoPropertyItem(
        strings.expirationDate,
        DateFormat("dd-MM-yy hh:mm")
            .format(global.foodItem.expirationDate)
            .toString());
    InfoPropertyItem priceUnitItem = InfoPropertyItem(
      strings.price,
      widget.isFree
          ? 'бесплатно'
          : '${widget.price.toString()} р. ${widget.unit}',
    );
    InfoPropertyItem pickUpItem = InfoPropertyItem(
      strings.whenToPickUp,
      global.foodItem.whenToPickUp,
    );
    InfoPropertyItem massItem = InfoPropertyItem(
      strings.mass,
      'Масса товара: ${global.foodItem.mass.toString()} кг.',
    );
    InfoPropertyItem markItem = InfoPropertyItem(
      strings.mark,
      'Оценка покупателя: ${global.foodItem.mark.toString()}',
    );

    File imageFile = File(widget.image);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorsLibrary.whiteColor,
          elevation: 0,
          title: Text(strings.good,
              style: StylesLibrary.strongBlackTextStyle
                  .merge(const TextStyle(fontSize: 16))),
          leading: CloseButton(
            color: ColorsLibrary.primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: PopupMenuButton<String>(
                child: selectByPlatform(
                    Icon(
                      Icons.more_horiz,
                      color: ColorsLibrary.middleBlack,
                    ),
                    Icon(
                      Icons.more_vert,
                      color: ColorsLibrary.middleBlack,
                    )),
                elevation: 3.2,
                onSelected: _selectMenuItem,
                itemBuilder: (BuildContext context) {
                  return widget.goodType == global.GoodType.full
                      ? popUpMenuItems.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList()
                      : popUpMenuItemsTrimmed.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                },
              ),
            ),
          ]),
      body: ListView(children: [
        Column(
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(130),
                  child: Image.file(imageFile,
                      height: 255, width: 255, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 24, left: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.59,
                    child: Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: selectByPlatform(
                              StylesLibrary.IOSPrimaryBlackTextStyle,
                              StylesLibrary.AndroidPrimaryBlackTextStyle)
                          .merge(const TextStyle(fontSize: 24)),
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            widget.goodType != GoodType.trimmed
                ? Container(
                    padding:
                        const EdgeInsets.only(right: 36, left: 36, bottom: 16),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      formatTimeDifference(global.foodItem.addMoment),
                      textAlign: TextAlign.center,
                      style: selectByPlatform(
                              StylesLibrary.optionalBlackTextStyle,
                              StylesLibrary.optionalBlackTextStyle)
                          .merge(const TextStyle(
                        fontSize: 11,
                      )),
                    ),
                  )
                : Container(),
            widget.goodType != GoodType.trimmed
                ? Card(
                    color: ColorsLibrary.lightGray,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    elevation: 0,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.network(
                                        global.foodItem.ownerProfileImage
                                            .toString(),
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Text(
                                    global.foodItem.ownerName,
                                    style: selectByPlatform(
                                            StylesLibrary.strongBlackTextStyle,
                                            StylesLibrary.strongBlackTextStyle)
                                        .merge(const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: ColorsLibrary.blackColor)),
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Icon(
                                    Icons.star_border_rounded,
                                    color: ColorsLibrary.lightOrange,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                  child: Text(
                                    global.foodItem.ownerRating.toString(),
                                    style: selectByPlatform(
                                            StylesLibrary.strongBlackTextStyle,
                                            StylesLibrary.strongBlackTextStyle)
                                        .merge(const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: ColorsLibrary.blackColor)),
                                  ),
                                ),
                              ]),
                          Container(
                            padding: const EdgeInsets.only(top: 8, left: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              'Товар в закладках у ${global.foodItem.bookmarksCount} пользователей(я)',
                              style: selectByPlatform(
                                      StylesLibrary.optionalBlackTextStyle,
                                      StylesLibrary.optionalBlackTextStyle)
                                  .merge(const TextStyle(
                                fontSize: 12,
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(top: 16, right: 24, left: 24),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
            global.foodItem.description,
            textAlign: TextAlign.justify,
            style: selectByPlatform(StylesLibrary.optionalBlackTextStyle,
                    StylesLibrary.optionalBlackTextStyle)
                .merge(const TextStyle(fontSize: 16, wordSpacing: -6)),
          ),
        ),
        Card(
          color: ColorsLibrary.lightGray,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          elevation: 0,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                widget.goodType != GoodType.trimmed
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child:
                            buildInfoPropertyItem(expirationDateItem, context),
                      )
                    : Container(
                        height: 16,
                      ),
                buildInfoPropertyItem(priceUnitItem, context),
                widget.goodType != GoodType.trimmed
                    ? buildInfoPropertyItem(pickUpItem, context)
                    : Container(),
                buildInfoPropertyItem(massItem, context),
                widget.goodType == GoodType.trimmed
                    ? buildInfoPropertyItem(markItem, context)
                    : Container(),
              ],
            ),
          ),
        ),
        widget.goodType != GoodType.trimmed
            ? Container(
                margin: const EdgeInsets.only(
                    top: 4, bottom: 24, left: 24, right: 24),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: const YandexMap()),
              )
            : Container(),
      ]),
    );
  }

  void _selectMenuItem(String choice) {
    if (choice == "Редактировать") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewOrEditGoodScreen(
              screenType: ScreenType.editGood,
              id: widget.id,
              name: widget.name,
              description: global.foodItem.description,
              image: widget.image,
              expirationDate: global.foodItem.expirationDate,
              price: widget.price,
              unit: widget.unit,
              whenToPickUp: global.foodItem.whenToPickUp,
              whereToPickUp: global.foodItem.whereToPickUp,
              isFree: widget.isFree,
            ),
          ));
    } else if (choice == "Удалить") {}
  }
}
