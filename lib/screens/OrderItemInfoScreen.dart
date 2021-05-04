import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import '../utils/PlatformUtils.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:intl/intl.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;
import 'package:flutter_test_app/resources/StringsLibrary.dart' as strings;
import 'package:flutter_test_app/widgets/InfoPropertyItem.dart';

class OrderItemInfoScreen extends StatefulWidget {
  OrderItemInfoScreen(
      {Key key,
      this.id,
      this.image,
      this.name,
      this.price,
      this.unit,
      this.ownerName,
      this.ownerProfileImage,
      this.isFree,
      this.ownerRating});

  final int id;
  final String image;
  final String name;
  final int price;
  final String unit;
  final String ownerName;
  final String ownerProfileImage;
  final bool isFree;
  final double ownerRating;

  @override
  _OrderItemInfoScreenState createState() => _OrderItemInfoScreenState();
}

class _OrderItemInfoScreenState extends State<OrderItemInfoScreen> {
  //поиск позиции по id, а пока берется из GlobalData

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
          : '${widget.price.toString()} р. за ${widget.unit}',
    );
    InfoPropertyItem pickUpItem = InfoPropertyItem(
      strings.whenToPickUp,
      global.foodItem.pickUpTimes,
    );
    InfoPropertyItem distanceItem = InfoPropertyItem(
      strings.distance,
      '${global.foodItem.distance.toString()} км. от Вас',
    );
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorsLibrary.whiteColor,
          elevation: 0,
          title: Text(widget.isFree ? bookingTitle : sellingTitle,
              style: StylesLibrary.strongBlackTextStyle
                  .merge(const TextStyle(fontSize: 16))),
          leading: CloseButton(
            color: ColorsLibrary.primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
                icon: selectByPlatform(
                    Icon(Icons.more_horiz), Icon(Icons.more_vert)),
                color: ColorsLibrary.middleBlack,
                onPressed: () {})
          ]),
      body: ListView(children: [
        Column(
          children: <Widget>[
            Center(
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(130),
                      child: Image.network(widget.image.toString(),
                          height: 255, width: 255, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 10,
                    child: InkWell(
                      splashColor: ColorsLibrary.whiteTransparentColor,
                      onTap: () {
                        try {
                          setState(() {
                            global.foodItem.isInBookmarks =
                                !global.foodItem.isInBookmarks;
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
                  ),
                ],
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
            Container(
              padding: const EdgeInsets.only(right: 36, left: 36, bottom: 16),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                formatTimeDifference(global.foodItem.addMoment),
                textAlign: TextAlign.center,
                style: selectByPlatform(StylesLibrary.optionalBlackTextStyle,
                        StylesLibrary.optionalBlackTextStyle)
                    .merge(const TextStyle(
                  fontSize: 11,
                )),
              ),
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
                    Row(
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
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: buildInfoPropertyItem(expirationDateItem, context),
                ),
                buildInfoPropertyItem(priceDateItem, context),
                buildInfoPropertyItem(pickUpItem, context),
                buildInfoPropertyItem(distanceItem, context),
              ],
            ),
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(top: 4, bottom: 16, left: 24, right: 24),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: const YandexMap()),
        ),
        Container(
          margin: const EdgeInsets.only(right: 32, left: 32, bottom: 32),
          height: 45,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorsLibrary.lightOrange,
            borderRadius: const BorderRadius.all(Radius.circular(35)),
          ),
          child: InkWell(
            onTap: () {},
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    strings.moveToChat,
                    style: selectByPlatform(
                            StylesLibrary.IOSPrimaryWhiteTextStyle,
                            StylesLibrary.AndroidPrimaryWhiteTextStyle)
                        .merge(const TextStyle(
                            color: ColorsLibrary.whiteColor, fontSize: 17)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(
                      selectByPlatform(
                          CupertinoIcons.chat_bubble_2, Icons.send_rounded),
                      color: ColorsLibrary.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
