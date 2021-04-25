import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/ColorsLibrary.dart';
import '../resources/StylesLibrary.dart';

class BadgeItem {
  final String _image;
  final String _title;
  final String _description;

  const BadgeItem(this._image, this._title, this._description);
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
          ClipRRect(
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
              color: ColorsLibrary.whiteTransparentColor, fontSize: 15.5)),
        ),
      )
    ]),
  );
}
