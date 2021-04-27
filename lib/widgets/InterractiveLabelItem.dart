import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/ColorsLibrary.dart';
import '../resources/StylesLibrary.dart';
import '../utils/PlatformUtils.dart';

class InteractiveLabelItem {
  final String title;

  const InteractiveLabelItem(this.title);
}

Widget buildInteractiveLabelItem(InteractiveLabelItem item, bool isSelected) {
  return AnimatedContainer(
    margin: const EdgeInsets.only(right: 10),
    duration: const Duration(milliseconds: 250),
    height: 38,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: isSelected
            ? ColorsLibrary.primaryColor
            : ColorsLibrary.whiteTransparentColor,
        borderRadius: const BorderRadius.all(Radius.circular(35)),
        border: Border.symmetric(
          horizontal: isSelected
              ? BorderSide.none
              : const BorderSide(width: 1.0, color: ColorsLibrary.neutralGray),
          vertical: isSelected
              ? BorderSide.none
              : const BorderSide(width: 1.0, color: ColorsLibrary.neutralGray),
        )),
    child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Text(
            '${item.title}',
            style: isSelected
                ? selectByPlatform(StylesLibrary.IOSPrimaryWhiteTextStyle, StylesLibrary.AndroidPrimaryWhiteTextStyle)
                : selectByPlatform(StylesLibrary.IOSPrimaryBlackTextStyle, StylesLibrary.AndroidPrimaryBlackTextStyle).merge(TextStyle(color: ColorsLibrary.middleBlack)),
          ),
        )),
  );
}
