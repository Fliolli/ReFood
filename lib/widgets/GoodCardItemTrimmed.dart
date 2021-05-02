import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../resources/ColorsLibrary.dart';
import '../utils/PlatformUtils.dart';
import '../resources/StylesLibrary.dart';
import 'package:flutter_test_app/screens/FoodItemInfoScreen.dart';

Widget buildGoodCardItemTrimmed(
    GoodCardItemTrimmed goodCardItemTrimmed, BuildContext context) {
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
              builder: (context) => FoodItemInfoScreen(
                id: goodCardItemTrimmed._id,
                image: goodCardItemTrimmed._image,
                name: goodCardItemTrimmed._name,
                price: goodCardItemTrimmed._price,
                unit: goodCardItemTrimmed._unit,
                ownerName: goodCardItemTrimmed._ownerName,
                ownerProfileImage: goodCardItemTrimmed._ownerProfileImage,
                isFree: goodCardItemTrimmed._isFree,
              ),
            ));
      },
      splashColor: ColorsLibrary.lightOrange,
      child: Container(
          padding: const EdgeInsets.all(4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(goodCardItemTrimmed._image.toString(),
                      height: 90, width: 90, fit: BoxFit.cover),
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
                        goodCardItemTrimmed._name,
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
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 3),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                  goodCardItemTrimmed._ownerProfileImage
                                      .toString(),
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Text(
                                        goodCardItemTrimmed._ownerName,
                                        style: selectByPlatform(
                                                StylesLibrary
                                                    .optionalBlackTextStyle,
                                                StylesLibrary
                                                    .optionalBlackTextStyle)
                                            .merge(
                                                const TextStyle(fontSize: 13)),
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: SizedBox(
                        width: 120,
                        child: Text(
                          goodCardItemTrimmed._isFree
                              ? 'бесплатно'
                              : '${goodCardItemTrimmed._price.toString()} р. за ${goodCardItemTrimmed._unit}',
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
                  ],
                ),
              )
            ],
          )),
    ),
  );
}

class GoodCardItemTrimmed {
  final int _id;
  String _image;
  String _name;
  int _price;
  String _unit;
  String _ownerName;
  String _ownerProfileImage;
  bool _isFree;

  GoodCardItemTrimmed(this._id, this._image, this._name, this._price,
      this._unit, this._ownerName, this._ownerProfileImage, this._isFree);
}
