import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;
import 'package:flutter_test_app/models/GoodCardItem.dart';
import 'package:intl/intl.dart';
import '../resources/ColorsLibrary.dart';
import '../utils/PlatformUtils.dart';
import '../resources/StylesLibrary.dart';
import 'package:flutter_test_app/screens/GoodItemInfoScreen.dart';

Widget buildGoodCardItem(GoodCardItem goodCardItem, BuildContext context) {
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
              builder: (context) => GoodItemInfoScreen(
                goodType: global.GoodType.full,
                id: goodCardItem.id,
                image: goodCardItem.image,
                name: goodCardItem.name,
                price: goodCardItem.price,
                unit: goodCardItem.unit,
                isFree: goodCardItem.isFree,
              ),
            ));
      },
      child: Container(
          padding: const EdgeInsets.all(4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: FutureBuilder(
                      future: global.foodsProvider
                          .downloadFoodImage(goodCardItem.image),
                      builder: (context, image) {
                        if (image.hasData) {
                          return Image.memory(image.data as Uint8List,
                              height: 90, width: 90, fit: BoxFit.cover);
                        }
                        if (image.hasError) {
                          print(image.error);
                          return Text('${image.error}');
                        } else {
                          return Container(
                              height: 90,
                              width: 90,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.59,
                      child: Text(
                        goodCardItem.name,
                        style: selectByPlatform(
                                StylesLibrary.IOSPrimaryBlackTextStyle,
                                StylesLibrary.AndroidPrimaryBlackTextStyle)
                            .merge(const TextStyle(fontSize: 17)),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.59,
                        child: Text(
                          "Срок годности: ${DateFormat("dd-MM-yyyy").format(global.foodItem.expirationDate).toString()}",
                          style: selectByPlatform(
                                  StylesLibrary.optionalBlackTextStyle,
                                  StylesLibrary.optionalBlackTextStyle)
                              .merge(const TextStyle(
                            fontSize: 13,
                          )),
                          softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: SizedBox(
                              width: 140,
                              child: Text(
                                goodCardItem.isFree
                                    ? 'бесплатно'
                                    : '${goodCardItem.price.toString()} р. ${goodCardItem.unit}',
                                style: selectByPlatform(
                                        StylesLibrary.optionalBlackTextStyle,
                                        StylesLibrary.optionalBlackTextStyle)
                                    .merge(const TextStyle(
                                        fontSize: 12,
                                        wordSpacing: -4,
                                        letterSpacing: -0.5)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 3),
                            child: Icon(
                              CupertinoIcons.heart_solid,
                              color: ColorsLibrary.lightOrange,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            child: Text(
                              goodCardItem.bookmarksCount.toString(),
                              style: selectByPlatform(
                                      StylesLibrary.optionalBlackTextStyle,
                                      StylesLibrary.optionalBlackTextStyle)
                                  .merge(const TextStyle(fontSize: 15)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    ),
  );
}
