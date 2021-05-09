library flutter_test_app.global;

import 'package:flutter_test_app/data/FoodItem.dart';
import 'package:flutter_test_app/data/UserItem.dart';
import 'package:flutter_test_app/widgets/BadgeItem.dart';
import 'package:flutter_test_app/widgets/OrderCardItem.dart';

FoodItem foodItem = FoodItem(
    700,
    'https://avatars.mds.yandex.net/get-zen_doc/3963198/pub_5fc500f6e8c5ae189cc4783a_5fc5013937dee85d85fec99c/scale_1200',
    'Зелень для салата',
    50,
    'пакет',
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
    false);

List<OrderCardItem> magazineItems = [
  OrderCardItem(
      000,
      'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
      "Шоколадные круассаны",
      30,
      "штуку",
      0.6,
      "Марта",
      4.7,
      'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
      false),
  OrderCardItem(
      001,
      'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
      "Шоколадные круассаны",
      30,
      "штуку",
      0.6,
      "Марта",
      4.7,
      'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
      false),
];
final List<BadgeItem> badges = [
  const BadgeItem(("assets/images/1.jpg"), "Климат кадет", BackGroundType.light),
  const BadgeItem(("assets/images/2.jpg"), "Климат кадет", BackGroundType.light),
  const BadgeItem(("assets/images/3.jpg"), "Климат кадет", BackGroundType.light),
  const BadgeItem(("assets/images/4.jpg"), "Климат кадет", BackGroundType.light),
  const BadgeItem(("assets/images/5.jpg"), "Климат кадет", BackGroundType.light),
  const BadgeItem(("assets/images/6.jpg"), "Климат кадет", BackGroundType.light),
];
UserItem userItem = UserItem(900, "Виктория", "https://avatars.mds.yandex.net/get-zen_doc/98165/pub_5d028053a9b2fb00afda1d55_5d028c43c8a69200af4b27b8/scale_1200", 3.0, "Пусечная распупусечка, самая лучшая..", true, 6, badges, magazineItems, 8, 5, 5);

Map<String, String> foodItemAvailableFeature = {
  'Закладка': 'Добавить в закладки',
  'Бронь': 'Забронировать позицию',
  'Покупка': 'Купить позицию',
};

enum GoodType {full, trimmed}

enum OrderType {newOrder, bookmarked, booked, archive}

enum ScreenType {newGood, editGood}

enum BackGroundType {light, dark}
