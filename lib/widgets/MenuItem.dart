import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/ColorsLibrary.dart';
import '../utils/PlatformUtils.dart';
import '../resources/StylesLibrary.dart';

class MenuItem {
  final IconData _icon;
  final Color _color;
  final String _title;
  final _action;

  MenuItem(this._icon, this._color, this._title, this._action);
}

Widget buildMenuItem(MenuItem menuItem) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Ink(
          height: 30,
          decoration: ShapeDecoration(
            color: menuItem._color,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(
              menuItem._icon,
              color: ColorsLibrary.whiteColor,
              size: 15,
            ),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: Text('${menuItem._title}', style: selectByPlatform(StylesLibrary.IOSPrimaryBlackTextStyle, StylesLibrary.AndroidPrimaryBlackTextStyle),),
        ),
        IconButton(
            icon: Icon(CupertinoIcons.chevron_right),
            color: ColorsLibrary.primaryColor,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(0),
            onPressed: () {
              menuItem._action();
            })
      ],
    ),
  );
}