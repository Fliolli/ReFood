import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;
import 'package:flutter_test_app/data/GlobalData.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/widgets/AchievementItem.dart';
import 'package:flutter_test_app/widgets/BadgeItem.dart';

import '../utils/PlatformUtils.dart';

class UserInfoScreen extends StatefulWidget {
  final int id;
  final String ownerName;
  final String ownerProfileImage;
  final double ownerRating;

  UserInfoScreen(
      {Key key,
      this.id,
      this.ownerName,
      this.ownerProfileImage,
      this.ownerRating});

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  List<String> ownerPopUpMenuItems = [
    global.userItem.isInFavorites
        ? "Убрать из фаворитов"
        : "Добавить в фавориты",
    "Пожаловаться",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorsLibrary.whiteColor,
          elevation: 0,
          title: Text(seller,
              style: StylesLibrary.strongBlackTextStyle
                  .merge(const TextStyle(fontSize: 16))),
          leading: CloseButton(
            color: ColorsLibrary.primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: PopupMenuButton<String>(
                child: selectByPlatform(
                    Icon(
                      Icons.more_horiz,
                      color: ColorsLibrary.middleBlack,
                    ),
                    Icon(
                      Icons.more_vert,
                      color: ColorsLibrary.middleBlack,
                    )),
                elevation: 3.2,
                onSelected: _selectMenuItem,
                itemBuilder: (BuildContext context) {
                  return ownerPopUpMenuItems.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ),
          ]),
      body: ListView(children: [
        Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(130),
                      child: Image.network(widget.ownerProfileImage.toString(),
                          height: 220, width: 220, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 70,
                  child: InkWell(
                    splashColor: ColorsLibrary.whiteTransparentColor,
                    onTap: () {
                      try {
                        setState(() {
                          global.userItem.isInFavorites =
                              !global.userItem.isInFavorites;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: ColorsLibrary.whiteColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        global.userItem.isInFavorites
                            ? CupertinoIcons.heart_solid
                            : CupertinoIcons.heart,
                        size: 32,
                        color: ColorsLibrary.lightOrange,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 24, left: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.59,
                    child: Text(
                      widget.ownerName,
                      textAlign: TextAlign.center,
                      style: selectByPlatform(
                              StylesLibrary.IOSPrimaryBlackTextStyle,
                              StylesLibrary.AndroidPrimaryBlackTextStyle)
                          .merge(const TextStyle(fontSize: 24)),
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: ColorsLibrary.lightGray,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              elevation: 0,
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                  widget.ownerProfileImage.toString(),
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(
                              widget.ownerName,
                              style: selectByPlatform(
                                      StylesLibrary.strongBlackTextStyle,
                                      StylesLibrary.strongBlackTextStyle)
                                  .merge(const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: ColorsLibrary.blackColor)),
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Icon(
                              Icons.star_border_rounded,
                              color: ColorsLibrary.lightOrange,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            child: Text(
                              widget.ownerRating.toString(),
                              style: selectByPlatform(
                                      StylesLibrary.strongBlackTextStyle,
                                      StylesLibrary.strongBlackTextStyle)
                                  .merge(const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: ColorsLibrary.blackColor)),
                            ),
                          ),
                        ]),
                    Container(
                      padding: const EdgeInsets.only(top: 8, left: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Пользователь в фаворитах у ${global.userItem.countOfInFavorites} человек(а)',
                        style: selectByPlatform(
                                StylesLibrary.optionalBlackTextStyle,
                                StylesLibrary.optionalBlackTextStyle)
                            .merge(const TextStyle(
                          fontSize: 12,
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
            global.userItem.aboutMe,
            textAlign: TextAlign.justify,
            style: selectByPlatform(StylesLibrary.optionalBlackTextStyle,
                    StylesLibrary.optionalBlackTextStyle)
                .merge(const TextStyle(fontSize: 16, wordSpacing: -6)),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          elevation: 0,
          child: Container(
              height: 340,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorsLibrary.lightGray,
              ),
              child: Column(children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 32),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: global.userItem.badges.map((badgeItem) {
                          return buildBadgeItem(badgeItem);
                        }).toList(),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: <Widget>[
                      buildAchievementItem(AchievementItem(
                          '${global.userItem.savedPositions} шт.',
                          'Позиций \nспасено',
                          BackGroundType.light)),
                      buildAchievementItem(AchievementItem(
                          'На ${global.userItem.lessCO2} куб.м',
                          'Меньше \nвыброс CO2',
                          BackGroundType.light)),
                      buildAchievementItem(AchievementItem(
                          '${global.userItem.savedMass} кг.',
                          'Еды \nспасено',
                          BackGroundType.light)),
                    ]),
                  ),
                )
              ])),
        ),
      ]),
    );
  }

  void _selectMenuItem(String choice) {
    if (choice == "Убрать из фаворитов") {
    } else if (choice == "Добавить в фавориты") {
    } else if (choice == "Пожаловаться") {}
  }
}
