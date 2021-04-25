import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/ColorsLibrary.dart';
import '../utils/PlatformUtils.dart';
import '../resources/StylesLibrary.dart';

class MenuItem {
  final IconData _icon;
  final Color _color;
  final String _title;
  final Function _action;

  const MenuItem(this._icon, this._color, this._title, this._action);
}

Widget buildMenuItem(MenuItem menuItem, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5),
    child: InkWell(
      highlightColor: ColorsLibrary.primaryColor,
      onTap: () {
        menuItem._action(context);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              height: 50,
              decoration: ShapeDecoration(
                color: menuItem._color,
                shape: CircleBorder(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  menuItem._icon,
                  color: ColorsLibrary.whiteColor,
                  size: 15,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${menuItem._title}',
              style: selectByPlatform(StylesLibrary.IOSPrimaryBlackTextStyle,
                  StylesLibrary.AndroidPrimaryBlackTextStyle),
            ),
          ),
          Container(
            child: Icon(CupertinoIcons.chevron_right,
                color: ColorsLibrary.primaryColor),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(0),
          )
        ],
      ),
    ),
  );
}
