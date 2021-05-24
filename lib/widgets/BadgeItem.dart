import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/GlobalData.dart';
import 'package:flutter_test_app/models/BadgeItem.dart';
import '../resources/ColorsLibrary.dart';
import '../resources/StylesLibrary.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;

Widget buildBadgeItem(BadgeItem badgeItem, BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
    child: Column(children: <Widget>[
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
                        padding: const EdgeInsets.only(top: 8),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(70),
                            child: Image.network(
                              badgeItem.image,
                              fit: BoxFit.cover,
                              height: 160,
                              width: 160,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          '${badgeItem.title}',
                          textAlign: TextAlign.center,
                          style: StylesLibrary.optionalWhiteTextStyle
                              .merge(TextStyle(color: ColorsLibrary.middleBlack, fontSize: 15.5)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          global.badge.description,
                          textAlign: TextAlign.justify,
                          style: StylesLibrary.optionalWhiteTextStyle.merge(TextStyle(
                            color: ColorsLibrary.middleBlack,
                            fontSize: 15.5,
                          )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(
                  badgeItem.image,
                  fit: BoxFit.cover,
                  height: 140,
                  width: 140,
                )),
            badgeItem.achieved == true
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
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: 120,
        child: Text(
          '${badgeItem.title}',
          textAlign: TextAlign.center,
          style: StylesLibrary.optionalWhiteTextStyle.merge(TextStyle(
              color: badgeItem.backGroundType == BackGroundType.light
                  ? ColorsLibrary.middleBlack
                  : badgeItem.achieved
                      ? ColorsLibrary.whiteColor
                      : ColorsLibrary.whiteTransparentColor,
              fontSize: 15.5)),
        ),
      )
    ]),
  );
}
