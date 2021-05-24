import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/GlobalData.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/screens/NewOrEditGoodScreen.dart';
import 'package:flutter_test_app/widgets/GoodCardItem.dart';
import 'package:flutter_test_app/widgets/InteractiveLabelItem.dart';
import '../utils/PlatformUtils.dart';
import 'package:flutter_test_app/widgets/GoodCardItemTrimmed.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart' as strings;
import 'package:flutter_test_app/data/GlobalData.dart' as global;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsLibrary.whiteColor,
          elevation: 0,
          title: Text(title, style: StylesLibrary.strongBlackTextStyle.merge(const TextStyle(fontSize: 16))),
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
                decoration: const BoxDecoration(
                    color: Colors.white, boxShadow: [const BoxShadow(color: ColorsLibrary.lightGray, blurRadius: 6)]),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: goodsTypeLabelItems.map((goodsTypeLabelItem) {
                      var itemIndex = goodsTypeLabelItems.indexOf(goodsTypeLabelItem);
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedInteractiveLabelIndex = itemIndex;
                          });
                        },
                        child:
                            buildInteractiveLabelItem(goodsTypeLabelItem, selectedInteractiveLabelIndex == itemIndex),
                      );
                    }).toList(),
                  ),
                )),
            selectedInteractiveLabelIndex == 0
                ? FutureBuilder(
                    future: global.foodsProvider.loadActiveGoods(),
                    builder: (context, activeGoods) {
                      if (activeGoods.hasData) {
                        if ((activeGoods.data as List).isEmpty) {
                          return Container(
                              width: 260,
                              padding: EdgeInsets.only(top: 12),
                              child: Center(
                                  child: Text(
                                'Здесь пока ничего нет. Вы можете выставить свои продукты на продажу или отдать бесплатно. Нажмите на кнопку "+".',
                                textAlign: TextAlign.justify,
                                style: selectByPlatform(
                                        StylesLibrary.optionalBlackTextStyle, StylesLibrary.optionalBlackTextStyle)
                                    .merge(const TextStyle(
                                  fontSize: 13,
                                )),
                              )));
                        }
                        return Container(
                          child: Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: activeGoods.data.length,
                                itemBuilder: (context, index) {
                                  return buildGoodCardItem(activeGoods.data[index], context);
                                }),
                          ),
                        );
                      }
                      if (activeGoods.hasError) {
                        print(activeGoods.error);
                        return Text('${activeGoods.error}');
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })
                : selectedInteractiveLabelIndex == 1
                    ? FutureBuilder(
                        future: global.foodsProvider.loadBookedGoods(),
                        builder: (context, bookedGoods) {
                          if (bookedGoods.hasData) {
                            if ((bookedGoods.data as List).isEmpty) {
                              return Container(
                                  width: 260,
                                  padding: EdgeInsets.only(top: 12),
                                  child: Center(
                                      child: Text(
                                    'Здесь пока ничего нет. Никто еще не бронировал ваши продукты..',
                                    textAlign: TextAlign.justify,
                                    style: selectByPlatform(
                                            StylesLibrary.optionalBlackTextStyle, StylesLibrary.optionalBlackTextStyle)
                                        .merge(const TextStyle(fontSize: 13)),
                                  )));
                            }
                            return Container(
                              child: Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: bookedGoods.data.length,
                                    itemBuilder: (context, index) {
                                      return buildGoodCardItem(bookedGoods.data[index], context);
                                    }),
                              ),
                            );
                          }
                          if (bookedGoods.hasError) {
                            print(bookedGoods.error);
                            return Text('${bookedGoods.error}');
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        })
                    : selectedInteractiveLabelIndex == 2
                        ? FutureBuilder(
                            future: global.foodsProvider.loadArchivedGoods(),
                            builder: (context, archivedGoods) {
                              if (archivedGoods.hasData) {
                                if ((archivedGoods.data as List).isEmpty) {
                                  return Container(
                                      width: 260,
                                      padding: EdgeInsets.only(top: 12),
                                      child: Center(
                                          child: Text(
                                        'Здесь пока ничего нет. У Вас еще нет завершенных продаж..',
                                        textAlign: TextAlign.justify,
                                        style: selectByPlatform(StylesLibrary.optionalBlackTextStyle,
                                                StylesLibrary.optionalBlackTextStyle)
                                            .merge(const TextStyle(fontSize: 13)),
                                      )));
                                }
                                return Container(
                                  child: Expanded(
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: archivedGoods.data.length,
                                        itemBuilder: (context, index) {
                                          return buildGoodCardItemTrimmed(archivedGoods.data[index], context);
                                        }),
                                  ),
                                );
                              }
                              if (archivedGoods.hasError) {
                                print(archivedGoods.error);
                                return Text('${archivedGoods.error}');
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            })
                        : Container(),
          ]),
          selectedInteractiveLabelIndex == 0
              ? Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewOrEditGoodScreen.newGood(
                              screenType: ScreenType.newGood,
                            ),
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
