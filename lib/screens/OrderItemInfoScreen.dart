import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart' as strings;
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/screens/UserInfoScreen.dart';
import 'package:flutter_test_app/widgets/InfoPropertyItem.dart';
import 'package:intl/intl.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../utils/PlatformUtils.dart';

class OrderItemInfoScreen extends StatefulWidget {
  final global.OrderType orderType;
  final int id;
  final String image;
  final String name;
  final int price;
  final String unit;
  final String ownerName;
  final String ownerProfileImage;
  final bool isFree;
  final double ownerRating;
  OrderItemInfoScreen(
      {Key key,
      this.orderType,
      this.id,
      this.image,
      this.name,
      this.price,
      this.unit,
      this.ownerName,
      this.ownerProfileImage,
      this.isFree,
      this.ownerRating});

  @override
  _OrderItemInfoScreenState createState() => _OrderItemInfoScreenState();
}

class _OrderItemInfoScreenState extends State<OrderItemInfoScreen> {
  final List<String> bookmarkedPopUpMenuItems = [
    "Забронировать",
    "Удалить из закладок",
  ];

  final List<String> bookedPopUpMenuItems = [
    "Подтвердить получение",
    "Отменить бронь",
  ];

  final List<String> archivePopUpMenuItems = [
    "Удалить",
  ];

  @override
  Widget build(BuildContext context) {
    InfoPropertyItem expirationDateItem = InfoPropertyItem(
        strings.expirationDate,
        DateFormat("dd-MM-yy hh:mm")
            .format(global.foodItem.expirationDate)
            .toString());
    InfoPropertyItem priceDateItem = InfoPropertyItem(
      strings.price,
      widget.isFree
          ? 'бесплатно'
          : '${widget.price.toString()} р. ${widget.unit}',
    );
    InfoPropertyItem pickUpItem = InfoPropertyItem(
      strings.whenToPickUp,
      global.foodItem.whenToPickUp,
    );
    InfoPropertyItem distanceItem = InfoPropertyItem(
      strings.distance,
      '${global.foodItem.distance.toString()} км. от Вас',
    );

    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorsLibrary.whiteColor,
          elevation: 0,
          title: Text(
              widget.orderType == global.OrderType.bookmarked
                  ? bookingTitle
                  : widget.orderType == global.OrderType.booked
                      ? bookedTitle
                      : archivedTitle,
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
                  return widget.orderType == global.OrderType.bookmarked
                      ? bookmarkedPopUpMenuItems.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList()
                      : widget.orderType == global.OrderType.booked
                          ? bookedPopUpMenuItems.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList()
                          : archivePopUpMenuItems.map((String choice) {
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
            Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(130),
                      child: Image.network(widget.image.toString(),
                          height: 255, width: 255, fit: BoxFit.cover),
                    ),
                  ),
                ),
                widget.orderType == global.OrderType.bookmarked
                    ? Positioned(
                        top: 15,
                        left: 65,
                        child: InkWell(
                          splashColor: ColorsLibrary.whiteTransparentColor,
                          onTap: () {
                            try {
                              setState(() {
                                global.foodItem.isInBookmarks =
                                    !global.foodItem.isInBookmarks;
                                final snackBar = SnackBar(
                                  content: Text(
                                    global.foodItem.isInBookmarks
                                        ? strings.orderAddedToBookmarks
                                        : strings.orderDeletedFromBookmarks,
                                    style: StylesLibrary.optionalWhiteTextStyle,
                                  ),
                                  backgroundColor: global.foodItem.isInBookmarks
                                      ? ColorsLibrary.lightGreen
                                      : ColorsLibrary.lightYellow,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: ColorsLibrary.whiteColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              global.foodItem.isInBookmarks
                                  ? CupertinoIcons.heart_solid
                                  : CupertinoIcons.heart,
                              size: 32,
                              color: ColorsLibrary.lightOrange,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
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
            widget.orderType != global.OrderType.archive
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
                : Container(
                    height: 16,
                  ),
            Card(
              color: ColorsLibrary.lightGray,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              elevation: 0,
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserInfoScreen(
                                id: global.userItem.id,
                                ownerName: widget.ownerName,
                                ownerProfileImage: widget.ownerProfileImage,
                                ownerRating: widget.ownerRating,
                              ),
                            ));
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.network(
                                    widget.ownerProfileImage.toString(),
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Text(
                                widget.ownerName,
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
                                widget.ownerRating.toString(),
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
                    ),
                    widget.orderType != global.OrderType.archive
                        ? Container(
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
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
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
                widget.orderType != global.OrderType.archive
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child:
                            buildInfoPropertyItem(expirationDateItem, context),
                      )
                    : Container(
                        height: 16,
                      ),
                buildInfoPropertyItem(priceDateItem, context),
                widget.orderType != global.OrderType.archive
                    ? buildInfoPropertyItem(pickUpItem, context)
                    : Container(),
                widget.orderType != global.OrderType.archive
                    ? buildInfoPropertyItem(distanceItem, context)
                    : Container(),
              ],
            ),
          ),
        ),
        widget.orderType != global.OrderType.archive
            ? Container(
                margin: const EdgeInsets.only(
                    top: 4, bottom: 16, left: 24, right: 24),
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
    if (choice == "Забронировать") {
    } else if (choice == "Удалить из закладок") {
    } else if (choice == "Подтвердить получение") {
    } else if (choice == "Отменить бронь") {
    } else if (choice == "Удалить") {}
  }
}
