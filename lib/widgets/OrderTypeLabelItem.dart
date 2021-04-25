import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/ColorsLibrary.dart';
import '../resources/StylesLibrary.dart';
import '../utils/PlatformUtils.dart';

class OrderTypeLabelItem {
  final String title;

  const OrderTypeLabelItem(this.title);
}

Widget buildOrderTypeLabelItem(OrderTypeLabelItem item, bool isSelected) {
  return AnimatedContainer(
    margin: const EdgeInsets.only(right: 12),
    duration: const Duration(milliseconds: 250),
    height: 38,
    width: 100,
    decoration: BoxDecoration(
        color: isSelected
            ? ColorsLibrary.primaryColor
            : ColorsLibrary.whiteTransparentColor,
        borderRadius: const BorderRadius.all(Radius.circular(35)),
        border: Border.symmetric(
          horizontal: isSelected
              ? BorderSide.none
              : const BorderSide(width: 1.0, color: ColorsLibrary.middleBlack),
          vertical: isSelected
              ? BorderSide.none
              : const BorderSide(width: 1.0, color: ColorsLibrary.middleBlack),
        )),
    child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Text(
            '${item.title}',
            style: isSelected
                ? selectByPlatform(StylesLibrary.IOSPrimaryWhiteTextStyle, StylesLibrary.AndroidPrimaryWhiteTextStyle)
                : selectByPlatform(StylesLibrary.IOSPrimaryBlackTextStyle, StylesLibrary.AndroidPrimaryBlackTextStyle),
          ),
        )),
  );
}
