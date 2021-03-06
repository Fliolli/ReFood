import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/ColorsLibrary.dart';
import '../utils/PlatformUtils.dart';
import '../resources/StylesLibrary.dart';

class InfoPropertyItem {
  final String _propertyTitle;
  final String _propertyValue;

  const InfoPropertyItem(this._propertyTitle, this._propertyValue);
}

Widget buildInfoPropertyItem(InfoPropertyItem item, BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 4, right: 10, left: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            item._propertyTitle,
            style: selectByPlatform(StylesLibrary.strongBlackTextStyle, StylesLibrary.strongBlackTextStyle)
                .merge(const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: ColorsLibrary.blackColor)),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, bottom: 16),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            item._propertyValue,
            style: selectByPlatform(StylesLibrary.optionalBlackTextStyle, StylesLibrary.optionalBlackTextStyle)
                .merge(const TextStyle(
              fontSize: 15,
            )),
          ),
        ),
      ),
    ],
  );
}
