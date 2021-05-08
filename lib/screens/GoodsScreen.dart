import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/GlobalData.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/screens/NewOrEditGoodScreen.dart';
import 'package:flutter_test_app/widgets/GoodCardItem.dart';
import 'package:flutter_test_app/widgets/InteractiveLabelItem.dart';
import '../utils/PlatformUtils.dart';
import 'package:flutter_test_app/widgets/OrderCardBookmarkItem.dart';
import 'package:flutter_test_app/widgets/GoodCardItemTrimmed.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart';

class GoodsScreen extends StatefulWidget {
  @override
  _GoodsScreenState createState() => _GoodsScreenState();
}

class _GoodsScreenState extends State<GoodsScreen> {
  int selectedInteractiveLabelIndex = 0;
  static const String title = "Витрина";

  final List<InteractiveLabelItem> goodsTypeLabelItems = [
    const InteractiveLabelItem(
      'Активные',
    ),
    const InteractiveLabelItem(
      'Бронь',
    ),
    const InteractiveLabelItem(
      'Архив',
    ),
  ];

  List<GoodCardItem> activeGoodItems = [
    GoodCardItem(
        100,
        'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
        "Шоколадные круассаны",
        30,
        "штуку",
        "Марта",
        'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
        6986,
        false),
    GoodCardItem(
        101,
        'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
        "Шоколадные круассаны",
        30,
        "штуку",
        "Марта",
        'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
        2,
        false),
  ];

  List<GoodCardItem> bookingGoodItems = [
    GoodCardItem(
        200,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        "Домашнее мороже00000000000000000000000ное",
        50,
        "штуку",
        "Марк6666666666666666666666666666666666666666",
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        1,
        false),
    GoodCardItem(
        201,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        "Домашнее мороже00000000000000000000000ное",
        50,
        "штуку",
        "Марк6666666666666666666666666666666666666666",
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        6,
        false),
    GoodCardItem(
        202,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        "Домашнее мороже00000000000000000000000ное",
        50,
        "штуку",
        "Марк6666666666666666666666666666666666666666",
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        3,
        false),
    GoodCardItem(
        203,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        "Домашнее мороже00000000000000000000000ное",
        50,
        "штуку",
        "Марк6666666666666666666666666666666666666666",
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        4,
        false),
    GoodCardItem(
        204,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        "Домашнее мороже00000000000000000000000ное",
        50,
        "штуку",
        "Марк6666666666666666666666666666666666666666",
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        8,
        false),
    GoodCardItem(
        205,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        "Домашнее мороже00000000000000000000000ное",
        50,
        "штуку",
        "Марк6666666666666666666666666666666666666666",
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        8,
        false),
    GoodCardItem(
        206,
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        "Домашнее мороже00000000000000000000000ное",
        50,
        "штуку",
        "Марк6666666666666666666666666666666666666666",
        'https://medaboutme.ru/upload/medialibrary/07d/shutterstock_281680307.jpg',
        8,
        false),
  ];

  List<GoodCardItemTrimmed> archiveGoodItems = [
    GoodCardItemTrimmed(
        300,
        'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
        "Шоколадные круассаны",
        30,
        "штуку",
        "Марта",
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
        body: Stack(children: <Widget>[
          Column(children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 12),
                height: 60,
                padding: const EdgeInsets.only(left: 18),
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
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
                      ? activeGoodItems.map((goodCardItem) {
                          return buildGoodCardItem(goodCardItem, context);
                        }).toList()
                      : selectedInteractiveLabelIndex == 1
                          ? bookingGoodItems.map((goodCardItem) {
                              return buildGoodCardItem(goodCardItem, context);
                            }).toList()
                          : archiveGoodItems.map((goodCardItem) {
                                  return buildGoodCardItemTrimmed(
                                      goodCardItem, context);
                                }).toList(),
                ),
              ),
            )
          ]),
          selectedInteractiveLabelIndex == 0
              ? Container(
                  alignment: Alignment.bottomRight,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewOrEditGoodScreen.newGood(screenType: ScreenType.newGood,),
                          ));
                    },
                    child: selectByPlatform(
                        const Icon(
                          CupertinoIcons.add,
                          color: ColorsLibrary.whiteColor,
                        ),
                        const Icon(
                          Icons.add,
                          color: ColorsLibrary.whiteColor,
                        )),
                    backgroundColor: ColorsLibrary.primaryColor,
                    heroTag: "addGood",
                  ),
                )
              : Container(),
        ]));
  }
}
