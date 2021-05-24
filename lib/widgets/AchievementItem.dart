import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/GlobalData.dart';
import '../resources/StylesLibrary.dart';

class AchievementItem {
  final String _achievementText;
  final String _achievementDescription;
  final BackGroundType _backGroundType;

  const AchievementItem(this._achievementText, this._achievementDescription, this._backGroundType);
}

Widget buildAchievementItem(AchievementItem achievementItem) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 22),
    child: Column(children: <Widget>[
      Text(
        '${achievementItem._achievementText}',
        style: achievementItem._backGroundType == BackGroundType.dark
            ? StylesLibrary.strongWhiteTextStyle
            : StylesLibrary.strongBlackTextStyle,
        textAlign: TextAlign.center,
      ),
      Container(
          margin: const EdgeInsets.only(top: 6),
          child: Text(
            '${achievementItem._achievementDescription}',
            style: achievementItem._backGroundType == BackGroundType.dark
                ? StylesLibrary.optionalWhiteTextStyle
                : StylesLibrary.optionalBlackTextStyle,
            textAlign: TextAlign.center,
          ))
    ]),
  );
}
