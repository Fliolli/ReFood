import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/ColorsLibrary.dart';
import '../utils/PlatformUtils.dart';
import '../resources/StylesLibrary.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;

class NavigationItem {
  final IconData _icon;
  final String _title;
  final Color _color;

  const NavigationItem(
    this._icon,
    this._title,
    this._color,
  );
}

Widget buildNavigationItem(NavigationItem item, bool isSelected) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 250),
    height: 60,
    width: isSelected ? 140 : 60,
    padding: const EdgeInsets.only(left: 12, right: 12),
    decoration: isSelected
        ? BoxDecoration(
            color: item._color,
            borderRadius: BorderRadius.all(Radius.circular(50)))
        : null,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconTheme(
              data: IconThemeData(
                size: 28,
                color: isSelected
                    ? ColorsLibrary.whiteColor
                    : ColorsLibrary.neutralGray,
              ),
              child: Icon(
                item._icon,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: isSelected
                  ? DefaultTextStyle.merge(
                      style: selectByPlatform(
                          StylesLibrary.IOSPrimaryWhiteTextStyle,
                          StylesLibrary.AndroidPrimaryWhiteTextStyle),
                      child: Text('${item._title}'))
                  : Container(),
            )
          ],
        ),
      ],
    ),
  );
}
