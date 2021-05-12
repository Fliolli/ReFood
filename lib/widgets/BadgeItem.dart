import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/GlobalData.dart';
import '../resources/ColorsLibrary.dart';
import '../resources/StylesLibrary.dart';

class BadgeItem {
  final String _image;
  final String _title;
  final BackGroundType _backGroundType;
  final bool _achived;

  const BadgeItem(
      this._image, this._title, this._backGroundType, this._achived);
}

Widget buildBadgeItem(BadgeItem badgeItem) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
    child: Column(children: <Widget>[
      Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.asset(
                badgeItem._image,
                fit: BoxFit.cover,
                height: 140,
                width: 140,
              )),
          badgeItem._achived == true
              ? Container()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Container(
                    height: 140,
                    width: 140,
                    color: ColorsLibrary.whiteTransparentColor,
                  )),
        ],
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: 120,
        child: Text(
          '${badgeItem._title}',
          textAlign: TextAlign.center,
          style: StylesLibrary.optionalWhiteTextStyle.merge(TextStyle(
              color: badgeItem._backGroundType == BackGroundType.light
                  ? ColorsLibrary.middleBlack
                  : ColorsLibrary.whiteTransparentColor,
              fontSize: 15.5)),
        ),
      )
    ]),
  );
}
