import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/widgets/OrderTypeLabelItem.dart';
import '../utils/PlatformUtils.dart';
import 'package:flutter_test_app/widgets/OrderCardItem.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int selectedOrderTypeItemIndex = 0;
  String title = "Заказы";
  final List<String> labelsName = ['Покупка', 'Продажа'];

  final List<OrderTypeLabelItem> orderTypeLabelItems = [
    OrderTypeLabelItem(
      //labelsName.elementAt(0).toString(),
      'Покупка'
    ),
    const OrderTypeLabelItem(
      'Продажа',
    ),
  ];

  List<OrderCardItem> outgoingOrdersItems = [
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
        false,
        14),
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
        false,
        14),
  ];

  List<OrderCardItem> incomingOrdersItems = [
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
        false,
        10),
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
        false,
        10),
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
        body: ListView(children: <Widget>[
          Column(children: <Widget>[
            Container(
                height: 60,
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 18),
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
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
                            selectedOrderTypeItemIndex = itemIndex;
                          });
                        },
                        child: buildOrderTypeLabelItem(orderTypeLabelItem,
                            selectedOrderTypeItemIndex == itemIndex),
                      );
                    }).toList(),
                  ),
                )),
            Container(
              child: ListView(
                shrinkWrap: true,
                children: selectedOrderTypeItemIndex == 0
                    ? outgoingOrdersItems.map((orderCardItem) {
                        return buildOrderCardItem(orderCardItem);
                      }).toList()
                    : incomingOrdersItems.map((orderCardItem) {
                        return buildOrderCardItem(orderCardItem);
                      }).toList(),
              ),
            )
          ])
        ]));
  }
}
