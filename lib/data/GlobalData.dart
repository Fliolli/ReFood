library flutter_test_app.global;

import 'package:flutter_test_app/data/FoodItem.dart';

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

Map<String, String> foodItemAvailableFeature = {
  'Закладка': 'Добавить в закладки',
  'Бронь': 'Забронировать позицию',
  'Покупка': 'Купить позицию',
};

enum GoodType {full, trimmed}

enum OrderType {newOrder, bookmarked, booked, archive}

enum ScreenType {newGood, editGood}
