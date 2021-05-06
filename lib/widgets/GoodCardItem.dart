import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test_app/data/GlobalData.dart';
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
                goodType: GoodType.full,
                id: goodCardItem._id,
                image: goodCardItem._image,
                name: goodCardItem._name,
                price: goodCardItem._price,
                unit: goodCardItem._unit,
                ownerName: goodCardItem._ownerName,
                ownerProfileImage: goodCardItem._ownerProfileImage,
                isFree: goodCardItem._isFree,
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
                  child: Image.network(goodCardItem._image.toString(),
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
                        goodCardItem._name,
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
                      child: Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(
                                goodCardItem._ownerProfileImage.toString(),
                                height: 25,
                                width: 25,
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            goodCardItem._ownerName,
                            style: selectByPlatform(
                                    StylesLibrary.optionalBlackTextStyle,
                                    StylesLibrary.optionalBlackTextStyle)
                                .merge(const TextStyle(fontSize: 13)),
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ]),
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
                                goodCardItem._isFree
                                    ? 'бесплатно'
                                    : '${goodCardItem._price.toString()} р. за ${goodCardItem._unit}',
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
                              goodCardItem._bookmarksCount.toString(),
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

class GoodCardItem {
  final int _id;
  String _image;
  String _name;
  int _price;
  String _unit;
  String _ownerName;
  String _ownerProfileImage;
  int _bookmarksCount;
  bool _isFree;

  GoodCardItem(
      this._id,
      this._image,
      this._name,
      this._price,
      this._unit,
      this._ownerName,
      this._ownerProfileImage,
      this._bookmarksCount,
      this._isFree);
}
