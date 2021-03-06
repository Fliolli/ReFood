import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test_app/models/GoodCardItemTrimmed.dart';
import '../resources/ColorsLibrary.dart';
import '../utils/PlatformUtils.dart';
import '../resources/StylesLibrary.dart';
import 'package:flutter_test_app/screens/GoodItemInfoScreen.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;

Widget buildGoodCardItemTrimmed(GoodCardItemTrimmed goodCardItemTrimmed, BuildContext context) {
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
                goodType: global.GoodType.trimmed,
                id: goodCardItemTrimmed.id,
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
                      future: global.foodsProvider.downloadFoodImage(goodCardItemTrimmed.image),
                      builder: (context, image) {
                        if (image.hasData) {
                          return Image.memory(image.data as Uint8List, height: 90, width: 90, fit: BoxFit.cover);
                        }
                        if (image.hasError) {
                          print(image.error);
                          return Text('${image.error}');
                        } else {
                          return Container(height: 90, width: 90, child: Center(child: CircularProgressIndicator()));
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
                        goodCardItemTrimmed.name,
                        style: selectByPlatform(
                                StylesLibrary.IOSPrimaryBlackTextStyle, StylesLibrary.AndroidPrimaryBlackTextStyle)
                            .merge(const TextStyle(fontSize: 17)),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.59,
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "??????????: ${global.foodItem.mass} ????.",
                        style:
                            selectByPlatform(StylesLibrary.optionalBlackTextStyle, StylesLibrary.optionalBlackTextStyle)
                                .merge(const TextStyle(fontSize: 13)),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.59,
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "????????????: ${global.foodItem.mark}",
                        style:
                            selectByPlatform(StylesLibrary.optionalBlackTextStyle, StylesLibrary.optionalBlackTextStyle)
                                .merge(const TextStyle(fontSize: 13)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SizedBox(
                        width: 120,
                        child: Text(
                          goodCardItemTrimmed.isFree
                              ? '??????????????????'
                              : '${goodCardItemTrimmed.price.toString()} ??. ${goodCardItemTrimmed.unit}',
                          style: selectByPlatform(
                                  StylesLibrary.optionalBlackTextStyle, StylesLibrary.optionalBlackTextStyle)
                              .merge(const TextStyle(fontSize: 12, wordSpacing: -4, letterSpacing: -0.5)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    ),
  );
}
