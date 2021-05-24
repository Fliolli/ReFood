import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test_app/data/GlobalData.dart';
import 'package:flutter_test_app/models/OrderCardBookmarkItem.dart';
import '../resources/ColorsLibrary.dart';
import '../utils/PlatformUtils.dart';
import '../resources/StylesLibrary.dart';
import 'package:flutter_test_app/screens/OrderItemInfoScreen.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;

Widget buildOrderCardBookmarkItem(OrderCardBookmarkItem orderCardBookmarkItem, BuildContext context) {
  return Card(
    margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
    shadowColor: ColorsLibrary.neutralGray,
    color: ColorsLibrary.whiteColor,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderItemInfoScreen(
                orderType: OrderStatus.bookmarked,
                id: orderCardBookmarkItem.id,
                owner: orderCardBookmarkItem.owner,
              ),
            ));
      },
      child: Container(
          padding: const EdgeInsets.all(4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: FutureBuilder(
                          future: global.foodsProvider.downloadFoodImage(orderCardBookmarkItem.image),
                          builder: (context, image) {
                            if (image.hasData) {
                              return Image.memory(image.data as Uint8List, height: 90, width: 90, fit: BoxFit.cover);
                            }
                            if (image.hasError) {
                              print(image.error);
                              return Text('${image.error}');
                            } else {
                              return Container(
                                  height: 90, width: 90, child: Center(child: CircularProgressIndicator()));
                            }
                          }),
                    ),
                  ),
                  Container(
                    width: 33,
                    height: 33,
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
                      CupertinoIcons.heart_solid,
                      color: ColorsLibrary.lightOrange,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.59,
                      child: Text(
                        orderCardBookmarkItem.name,
                        style: selectByPlatform(
                                StylesLibrary.IOSPrimaryBlackTextStyle, StylesLibrary.AndroidPrimaryBlackTextStyle)
                            .merge(const TextStyle(fontSize: 17)),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 3),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: FutureBuilder(
                                  future:
                                      global.userProvider.downloadUserImage(orderCardBookmarkItem.owner.profileImage),
                                  builder: (context, image) {
                                    if (image.hasData) {
                                      return Image.memory(image.data as Uint8List,
                                          height: 30, width: 30, fit: BoxFit.cover);
                                    }
                                    if (image.hasError) {
                                      print(image.error);
                                      return Text('${image.error}');
                                    } else {
                                      return Container(
                                          height: 30, width: 30, child: Center(child: CircularProgressIndicator()));
                                    }
                                  }),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  width: 100,
                                  child: Text(
                                    orderCardBookmarkItem.owner.name,
                                    style: selectByPlatform(
                                            StylesLibrary.optionalBlackTextStyle, StylesLibrary.optionalBlackTextStyle)
                                        .merge(const TextStyle(fontSize: 13)),
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.star_border_rounded,
                                color: ColorsLibrary.lightOrange,
                              ),
                              SizedBox(
                                width: 30,
                                child: Text(
                                  orderCardBookmarkItem.owner.rating.toString(),
                                  style: selectByPlatform(
                                          StylesLibrary.optionalBlackTextStyle, StylesLibrary.optionalBlackTextStyle)
                                      .merge(const TextStyle(fontSize: 14)),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              selectByPlatform(CupertinoIcons.location, Icons.location_pin),
                              color: ColorsLibrary.neutralGray,
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 12),
                              width: 55,
                              child: Text(
                                '${orderCardBookmarkItem.distance.toString()} км.',
                                style: selectByPlatform(
                                        StylesLibrary.optionalBlackTextStyle, StylesLibrary.optionalBlackTextStyle)
                                    .merge(const TextStyle(fontSize: 12, wordSpacing: -2, letterSpacing: -0.5)),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Text(
                                orderCardBookmarkItem.isFree
                                    ? 'бесплатно'
                                    : '${orderCardBookmarkItem.price.toString()} р. ${orderCardBookmarkItem.unit}',
                                style: selectByPlatform(
                                        StylesLibrary.optionalBlackTextStyle, StylesLibrary.optionalBlackTextStyle)
                                    .merge(TextStyle(
                                        color: orderCardBookmarkItem.isFree
                                            ? ColorsLibrary.greenColor
                                            : ColorsLibrary.middleBlack,
                                        fontSize: 12,
                                        wordSpacing: -4,
                                        letterSpacing: -0.5)),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              )
            ],
          )),
    ),
  );
}
