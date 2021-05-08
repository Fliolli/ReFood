import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import '../utils/PlatformUtils.dart';

Widget buildCustomTextField(
    CustomTextField customTextField, BuildContext context) {
  return Container(
      margin: EdgeInsets.only(top: 6, right: 16, left: 16),
      height: customTextField._height,
      width: customTextField._width,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
              color: ColorsLibrary.neutralGray, // set border color
              width: 1.0), // set border width
          borderRadius: BorderRadius.all(Radius.circular(
              customTextField._borderRadius)), // set rounded corner radius
        ),
        child: TextFormField(
          style: selectByPlatform(StylesLibrary.IOSPrimaryBlackTextStyle,
                  StylesLibrary.AndroidPrimaryBlackTextStyle)
              .merge(const TextStyle(
                  fontSize: 15, color: ColorsLibrary.middleBlack)),
          cursorColor: ColorsLibrary.primaryColor,
          controller: customTextField._textEditingController,
          cursorHeight: 24,
          cursorWidth: 1,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: customTextField._textInputType,
          textInputAction: customTextField._textInputAction,
          maxLines: customTextField._maxLines,
          minLines: customTextField._minLines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            errorStyle: selectByPlatform(StylesLibrary.IOSPrimaryBlackTextStyle,
                    StylesLibrary.AndroidPrimaryBlackTextStyle)
                .merge(const TextStyle(
                    fontSize: 12, color: ColorsLibrary.primaryColor)),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            hintText: customTextField._hintText,
            hintStyle: TextStyle(
              fontSize: 12,
            ),
          ),
          validator: customTextField._validator,
        ),
      ));
}

class CustomTextField {
  double _height;
  double _width;
  double _borderRadius;
  TextInputType _textInputType;
  TextInputAction _textInputAction;
  int _maxLines;
  int _minLines;
  String _hintText;
  Function _validator;
  TextEditingController _textEditingController;

  CustomTextField(
      this._height,
      this._width,
      this._borderRadius,
      this._textInputType,
      this._textInputAction,
      this._maxLines,
      this._minLines,
      this._hintText,
      this._validator,
      this._textEditingController);
}
