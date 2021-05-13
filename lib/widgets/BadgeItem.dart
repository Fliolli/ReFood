import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/GlobalData.dart';
import '../resources/ColorsLibrary.dart';
import '../resources/StylesLibrary.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;

class BadgeItem {
  final String _image;
  final String _title;
  final BackGroundType _backGroundType;
  final bool _achieved;

  const BadgeItem(
      this._image, this._title, this._backGroundType, this._achieved);
}

Widget buildBadgeItem(BadgeItem badgeItem, BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
    child: Column(children: <Widget>[
      Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              showSlideDialog(
                context: context,
                pillColor: ColorsLibrary.neutralGray,
                backgroundColor: ColorsLibrary.whiteColor,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  padding: EdgeInsets.symmetric(horizontal: 36),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.asset(
                                  badgeItem._image,
                                  fit: BoxFit.cover,
                                  height: 140,
                                  width: 140,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                                '${badgeItem._title}',
                                textAlign: TextAlign.center,
                                style: StylesLibrary.optionalWhiteTextStyle.merge(TextStyle(
                                    color: ColorsLibrary.middleBlack,
                                    fontSize: 15.5)),
                              ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              global.badge.description,
                              textAlign: TextAlign.justify,
                              style: StylesLibrary.optionalWhiteTextStyle.merge(TextStyle(
                                  color: ColorsLibrary.middleBlack,
                                  fontSize: 15.5,)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  badgeItem._image,
                  fit: BoxFit.cover,
                  height: 140,
                  width: 140,
                )),
          ),
          badgeItem._achieved == true
              ? Container()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Container(
                    height: 140,
                    width: 140,
                    color: ColorsLibrary.whiteTransparentColor,
                  )),
        ],
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: 120,
        child: Text(
          '${badgeItem._title}',
          textAlign: TextAlign.center,
          style: StylesLibrary.optionalWhiteTextStyle.merge(TextStyle(
              color: badgeItem._backGroundType == BackGroundType.light
                  ? ColorsLibrary.middleBlack
                  : ColorsLibrary.whiteTransparentColor,
              fontSize: 15.5)),
        ),
      )
    ]),
  );
}
