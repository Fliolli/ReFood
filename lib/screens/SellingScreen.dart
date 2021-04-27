import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/widgets/InterractiveLabelItem.dart';
import '../utils/PlatformUtils.dart';
import 'package:flutter_test_app/widgets/OrderCardItem.dart';

class SellingScreen extends StatefulWidget {
  @override
  _SellingScreenState createState() => _SellingScreenState();
}

class _SellingScreenState extends State<SellingScreen> {
  int selectedInteractiveLabelIndex = 0;
  String title = "Витрина";
  final List<String> labelsName = ['Активные', 'Бронь', 'Оплачены', 'Архив'];

  final List<InteractiveLabelItem> goodsTypeLabelItems = [
    const InteractiveLabelItem(
      'Активные',
    ),
    const InteractiveLabelItem(
      'Бронь',
    ),
    const InteractiveLabelItem(
      'Оплачены',
    ),
    const InteractiveLabelItem(
      'Архив',
    ),
  ];

  List<OrderCardItem> activeGoodItems = [
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

  List<OrderCardItem> bookingGoodItems = [
    OrderCardItem(
        002,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        "Домашнее мороже00000000000000000000000ное",
        50,
        "штуку",
        0.9,
        "Марк6666666666666666666666666666666666666666",
        4.7,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        false),
    OrderCardItem(
        003,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        "Домашнее мороженое",
        50,
        "штуку",
        0.9,
        "Марк",
        4.7,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        false),
    OrderCardItem(
        003,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        "Домашнее мороженое",
        50,
        "штуку",
        0.9,
        "Марк",
        4.7,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        false),
    OrderCardItem(
        003,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        "Домашнее мороженое",
        50,
        "штуку",
        0.9,
        "Марк",
        4.7,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        false),
    OrderCardItem(
        003,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        "Домашнее мороженое",
        50,
        "штуку",
        0.9,
        "Марк",
        4.7,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        false),
    OrderCardItem(
        003,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        "Домашнее мороженое",
        50,
        "штуку",
        0.9,
        "Марк",
        4.7,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        false),
    OrderCardItem(
        003,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        "Домашнее мороженое",
        50,
        "штуку",
        0.9,
        "Марк",
        4.7,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        false),
  ];

  List<OrderCardItem> archiveGoodItems = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsLibrary.whiteColor,
          elevation: 0,
          title: Text(title,
              style: StylesLibrary.strongBlackTextStyle
                  .merge(const TextStyle(fontSize: 16))),
          leading: CloseButton(
            color: ColorsLibrary.primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 12),
              height: 60,
              padding: const EdgeInsets.only(left: 18),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                const BoxShadow(color: ColorsLibrary.lightGray, blurRadius: 6)
              ]),
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: goodsTypeLabelItems.map((goodsTypeLabelItem) {
                    var itemIndex =
                    goodsTypeLabelItems.indexOf(goodsTypeLabelItem);
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedInteractiveLabelIndex = itemIndex;
                        });
                      },
                      child: buildInteractiveLabelItem(goodsTypeLabelItem,
                          selectedInteractiveLabelIndex == itemIndex),
                    );
                  }).toList(),
                ),
              )),
          Container(
            child: Expanded(
              child: ListView(
                shrinkWrap: true,
                children: selectedInteractiveLabelIndex == 0
                    ? activeGoodItems.map((orderCardItem) {
                  return  OrderCard().createState().buildOrderCardItem(orderCardItem, context);
                }).toList()
                    : selectedInteractiveLabelIndex == 1 ? bookingGoodItems.map((orderCardItem) {
                  return  OrderCard().createState().buildOrderCardItem(orderCardItem, context);
                }).toList()
                    : activeGoodItems.map((orderCardItem) {
                  return  OrderCard().createState().buildOrderCardItem(orderCardItem, context);
                }).toList(),
              ),
            ),
          )
        ]));
  }
}
