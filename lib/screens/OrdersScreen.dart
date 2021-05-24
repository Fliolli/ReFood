import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/utils/PlatformUtils.dart';
import 'package:flutter_test_app/widgets/InteractiveLabelItem.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart' as strings;
import 'package:flutter_test_app/data/GlobalData.dart' as global;
import 'package:flutter_test_app/widgets/OrderCardBookmarkItem.dart';
import 'package:flutter_test_app/widgets/OrderCardItem.dart';
import 'package:flutter_test_app/widgets/OrderCardItemTrimmed.dart';

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
          title: Text(strings.orders, style: StylesLibrary.strongBlackTextStyle.merge(const TextStyle(fontSize: 16))),
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
              decoration: const BoxDecoration(
                  color: Colors.white, boxShadow: [const BoxShadow(color: ColorsLibrary.lightGray, blurRadius: 6)]),
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: orderTypeLabelItems.map((orderTypeLabelItem) {
                    var itemIndex = orderTypeLabelItems.indexOf(orderTypeLabelItem);
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedInteractiveLabelIndex = itemIndex;
                        });
                      },
                      child: buildInteractiveLabelItem(orderTypeLabelItem, selectedInteractiveLabelIndex == itemIndex),
                    );
                  }).toList(),
                ),
              )),
          selectedInteractiveLabelIndex == 0
              ? FutureBuilder(
                  future: global.foodsProvider.loadBookmarkedOrders(),
                  builder: (context, bookmarkedOrders) {
                    if (bookmarkedOrders.hasData) {
                      if ((bookmarkedOrders.data as List).isEmpty) {
                        return Container(
                            width: 260,
                            padding: EdgeInsets.only(top: 12),
                            child: Center(
                                child: Text(
                              'Здесь пока ничего нет. Вы еще не добавили ни одну позицию в закладки..',
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
                              itemCount: bookmarkedOrders.data.length,
                              itemBuilder: (context, index) {
                                return buildOrderCardBookmarkItem(bookmarkedOrders.data[index], context);
                              }),
                        ),
                      );
                    }
                    if (bookmarkedOrders.hasError) {
                      print(bookmarkedOrders.error);
                      return Text('${bookmarkedOrders.error}');
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })
              : selectedInteractiveLabelIndex == 1
                  ? FutureBuilder(
                      future: global.foodsProvider.loadBookedOrders(),
                      builder: (context, bookedOrders) {
                        if (bookedOrders.hasData) {
                          if ((bookedOrders.data as List).isEmpty) {
                            return Container(
                                width: 260,
                                padding: EdgeInsets.only(top: 12),
                                child: Center(
                                    child: Text(
                                  'Здесь пока ничего нет. Вы еще не забронировали ни одну позицию..',
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
                                  itemCount: bookedOrders.data.length,
                                  itemBuilder: (context, index) {
                                    return buildOrderCardItem(bookedOrders.data[index], context);
                                  }),
                            ),
                          );
                        }
                        if (bookedOrders.hasError) {
                          print(bookedOrders.error);
                          return Text('${bookedOrders.error}');
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      })
                  : selectedInteractiveLabelIndex == 2
                      ? FutureBuilder(
                          future: global.foodsProvider.loadArchivedOrders(),
                          builder: (context, archivedOrders) {
                            if (archivedOrders.hasData) {
                              if ((archivedOrders.data as List).isEmpty) {
                                return Container(
                                    width: 260,
                                    padding: EdgeInsets.only(top: 12),
                                    child: Center(
                                        child: Text(
                                      'Здесь пока ничего нет. У Вас еще нет завершенных заказов..',
                                      textAlign: TextAlign.justify,
                                      style: selectByPlatform(StylesLibrary.optionalBlackTextStyle,
                                              StylesLibrary.optionalBlackTextStyle)
                                          .merge(const TextStyle(
                                        fontSize: 13,
                                      )),
                                    )));
                              }
                              return Container(
                                child: Expanded(
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: archivedOrders.data.length,
                                      itemBuilder: (context, index) {
                                        return buildOrderCardItemTrimmed(archivedOrders.data[index], context);
                                      }),
                                ),
                              );
                            }
                            if (archivedOrders.hasError) {
                              print(archivedOrders.error);
                              return Text('${archivedOrders.error}');
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          })
                      : Container(),
        ]));
  }
}
