library flutter_test_app.global;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test_app/models/FoodItem.dart';
import 'package:flutter_test_app/models/OrderCardItem.dart';
import 'package:flutter_test_app/models/UserItem.dart';
import 'package:flutter_test_app/providers/BadgesProvider.dart';
import 'package:flutter_test_app/providers/FoodsProvider.dart';
import 'package:flutter_test_app/providers/UserAnalyticProvider.dart';
import 'package:flutter_test_app/providers/UserProvider.dart';
import 'package:flutter_test_app/widgets/OrderCardItem.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart' as strings;

FoodItem foodItem = FoodItem(
    700,
    'https://avatars.mds.yandex.net/get-zen_doc/3963198/pub_5fc500f6e8c5ae189cc4783a_5fc5013937dee85d85fec99c/scale_1200',
    'Зелень для салата',
    50,
    strings.packetUnit,
    2.3,
    'Агафья',
    5.0,
    'https://avatars.mds.yandex.net/get-zen_doc/98165/pub_5d028053a9b2fb00afda1d55_5d028c43c8a69200af4b27b8/scale_1200',
    59,
    DateTime.utc(2021, 4, 14, 15, 5),
    'Зелень для салата. Свежая, вкусная, вкусная, в ней много витаминов, будете прям зожниками, ням-ням.',
    'локация',
    'Забрать можно сегодня или завтра до 15.00',
    DateTime.utc(2021, 4, 16, 10, 00),
    false,
    false,
    4,
    0.3);

UserItem userItem = UserItem(
  900,
  "Виктория",
  "https://avatars.mds.yandex.net/get-zen_doc/98165/pub_5d028053a9b2fb00afda1d55_5d028c43c8a69200af4b27b8/scale_1200",
  3.0,
  "Пусечная распупусечка, самая лучшая..",
  true,
  6,
  [],
  [],
  8,
  5,
  5,
);

class Badge {
  String image;
  String title;
  BackGroundType backGroundType;
  bool achieved;
  String description;

  Badge(this.image, this.title, this.backGroundType, this.achieved,
      this.description);
}

Badge badge = Badge(
    ("assets/images/1.jpg"),
    "Климат кадет",
    BackGroundType.light,
    true,
    "Чтобы получить этот значок, нужно много много стараться и ваще быть пусечкой.");

enum GoodType { full, trimmed }

enum GoodStatus { active, booked, archived }

enum OrderStatus { newOrder, bookmarked, booked, archived }

enum ScreenType { newGood, editGood }

enum BackGroundType { light, dark }

int selectedBottomNavItem = 1;

UserProvider userProvider = UserProvider();
FoodsProvider foodsProvider = FoodsProvider();
BadgesProvider badgesProvider = BadgesProvider();
UserAnalyticProvider userAnalyticProvider = UserAnalyticProvider();
