import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/ColorsLibrary.dart';
import '../utils/PlatformUtils.dart';
import '../resources/StylesLibrary.dart';

Widget buildPropertyTitleItem(String title, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 18, left: 32, right: 32),
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        title,
        textAlign: TextAlign.justify,
        style: selectByPlatform(StylesLibrary.strongBlackTextStyle, StylesLibrary.strongBlackTextStyle)
            .merge(const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: ColorsLibrary.middleBlack)),
      ),
    ),
  );
}
