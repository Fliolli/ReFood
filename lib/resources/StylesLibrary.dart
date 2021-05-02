import 'package:flutter/material.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';

class StylesLibrary {
  static const TextStyle AndroidPrimaryBlackTextStyle = TextStyle(
      fontSize: 15.5,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      color: ColorsLibrary.blackColor);
  static const TextStyle AndroidPrimaryWhiteTextStyle = TextStyle(
      fontSize: 15.5,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      color: ColorsLibrary.whiteColor);
  static const TextStyle strongWhiteTextStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'Prosto_One',
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: ColorsLibrary.whiteColor);
  static const TextStyle strongBlackTextStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'Prosto_One',
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: ColorsLibrary.middleBlack);
  static const TextStyle IOSPrimaryBlackTextStyle = TextStyle(
      fontSize: 15.5,
      fontFamily: 'SFMono',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: ColorsLibrary.blackColor);
  static const TextStyle IOSPrimaryWhiteTextStyle = TextStyle(
      fontSize: 15.5,
      fontFamily: 'SFMono',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: ColorsLibrary.whiteColor);
  static const TextStyle optionalWhiteTextStyle = TextStyle(
      fontSize: 13,
      fontFamily: 'Roboto_Mono',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: ColorsLibrary.whiteColor,
      wordSpacing: -4,
      letterSpacing: -0.5);
  static const TextStyle optionalBlackTextStyle = TextStyle(
      fontSize: 13,
      fontFamily: 'Roboto_Mono',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: ColorsLibrary.middleBlack,
      wordSpacing: -4,
      letterSpacing: -0.5);
}
