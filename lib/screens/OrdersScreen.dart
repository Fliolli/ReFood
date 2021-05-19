import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/widgets/InteractiveLabelItem.dart';
import 'package:flutter_test_app/widgets/OrderCardBookmarkItem.dart';
import 'package:flutter_test_app/widgets/OrderCardItemTrimmed.dart';
import 'package:flutter_test_app/widgets/OrderCardItem.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart' as strings;

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int selectedInteractiveLabelIndex = 0;

  final List<InteractiveLabelItem> orderTypeLabelItems = [
    const InteractiveLabelItem(
      'Закладки',
    ),
    const InteractiveLabelItem(
      'Бронь',
    ),
    const InteractiveLabelItem(
      'Архив',
    ),
  ];

  List<OrderCardBookmarkItem> bookmarkOrderItems = [
    OrderCardBookmarkItem(
        000,
        'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
        "Шоколадные круассаны",
        0,
        strings.thingUnit,
        0.6,
        "Марта Мартовна Мартович",
        4.7,
        'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
        true),
  ];

  List<OrderCardItem> bookingOrderItems = [
    OrderCardItem(
        000,
        'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
        "Шоколадные круассаны",
        30,
        strings.thingUnit,
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
        strings.thingUnit,
        0.6,
        "Марта",
        4.7,
        'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
        false),
  ];

  List<OrderCardItemTrimmed> archiveOrderItems = [
    OrderCardItemTrimmed(
        000,
        'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
        "Шоколадные круассаны",
        30,
        strings.thingUnit,
        "Марта",
        4.7,
        'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
        false),
  ];

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('foods')
        .doc('VDAUqNPRIVRRNIzzzi79')
        .get()
        .then((value) => print(value.data()));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsLibrary.whiteColor,
          elevation: 0,
          title: Text(strings.orders,
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
                  children: orderTypeLabelItems.map((orderTypeLabelItem) {
                    var itemIndex =
                        orderTypeLabelItems.indexOf(orderTypeLabelItem);
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedInteractiveLabelIndex = itemIndex;
                        });
                      },
                      child: buildInteractiveLabelItem(orderTypeLabelItem,
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
                    ? bookmarkOrderItems.map((orderCardItem) {
                        return buildOrderCardBookmarkItem(
                            orderCardItem, context);
                      }).toList()
                    : selectedInteractiveLabelIndex == 1
                        ? bookingOrderItems.map((orderCardItem) {
                            return buildOrderCardItem(orderCardItem, context);
                          }).toList()
                        : archiveOrderItems.map((orderCardItem) {
                            return buildOrderCardItemTrimmed(
                                orderCardItem, context);
                          }).toList(),
              ),
            ),
          )
        ]));
  }
}
