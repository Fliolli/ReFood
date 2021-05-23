import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/GlobalData.dart';
import 'package:flutter_test_app/models/persistant/UserAnalyticModel.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/screens/GoodsScreen.dart';
import 'package:flutter_test_app/screens/OrdersScreen.dart';
import 'package:flutter_test_app/widgets/AchievementItem.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;
import '../utils/PlatformUtils.dart';
import '../widgets/BadgeItem.dart';
import '../widgets/MenuItem.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference userAnalyticsRef = FirebaseFirestore.instance
      .collection("userAnalytic")
      .withConverter(
          fromFirestore: (snapshot, _) =>
              UserAnalyticModel.fromJson(snapshot.data()),
          toFirestore: (badge, _) => (badge as UserAnalyticModel).toJson());

  final List<MenuItem> menuItems = [
    MenuItem(
        selectByPlatform(
          CupertinoIcons.list_dash,
          Icons.list_rounded,
        ),
        ColorsLibrary.greenColor,
        "Заказы",
        (BuildContext context) => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrdersScreen()))
            }),
    MenuItem(
        selectByPlatform(
          CupertinoIcons.square_grid_2x2,
          Icons.apps_rounded,
        ),
        ColorsLibrary.yellowColor,
        "Витрина",
        (BuildContext context) => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GoodsScreen()))
            }),
    MenuItem(
        selectByPlatform(
          CupertinoIcons.briefcase,
          Icons.add_business_rounded,
        ),
        ColorsLibrary.purpleColor,
        "Подключить свой бизнес",
        (BuildContext context) => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()))
            }),
    MenuItem(
        selectByPlatform(
          CupertinoIcons.person_2,
          Icons.people_rounded,
        ),
        ColorsLibrary.cyanColor,
        "Пригласить друзей",
        (BuildContext context) => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()))
            }),
    MenuItem(
        CupertinoIcons.question,
        ColorsLibrary.primaryColor,
        "Как использовать ReFood",
        (BuildContext context) => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()))
            }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: FutureBuilder(
              future: global.userProvider.getUserName(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data,
                      style: StylesLibrary.strongWhiteTextStyle
                          .merge(TextStyle(fontSize: 17)));
                }
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('${snapshot.error}');
                } else {
                  return Container();
                }
              }),
          centerTitle: true,
          leading: CloseButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: selectByPlatform(
                  const Icon(
                    CupertinoIcons.gear_alt,
                  ),
                  const Icon(
                    Icons.settings,
                  )),
              tooltip: 'Настройки',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersScreen()),
                );
              },
            )
          ],
        ),
        body: ListView(children: [
          Column(children: <Widget>[
            Container(
              height: 335,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorsLibrary.primaryColor,
                  ColorsLibrary.lightOrange,
                ],
              )),
              child: FutureBuilder(
                  future: global.userAnalyticProvider.loadUserAnalytics(),
                  builder: (context, analytic) {
                    if (analytic.hasData) {
                      return FutureBuilder(
                          future: global.badgesProvider.loadBadges(analytic.data),
                          builder: (context, badges) {
                            if (badges.hasData) {
                              return Column(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 32),
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 176,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        badges.data.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return buildBadgeItem(
                                                          badges.data[index],
                                                          context);
                                                    }),
                                              ),
                                            ],
                                          ))),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(children: <Widget>[
                                        buildAchievementItem(AchievementItem(
                                            '${global.userAnalyticProvider.getSavedPositionsCount(analytic.data)} шт.',
                                            'Позиций \nспасено',
                                            BackGroundType.dark)),
                                        buildAchievementItem(AchievementItem(
                                            'На ${global.userAnalyticProvider.getLessCO2Value(analytic.data)} куб.м',
                                            'Меньше \nвыброс CO2',
                                            BackGroundType.dark)),
                                        buildAchievementItem(AchievementItem(
                                            '${global.userAnalyticProvider.getSavedMassValue(analytic.data)} кг.',
                                            'Еды \nспасено',
                                            BackGroundType.dark)),
                                      ]),
                                    ),
                                  )
                                ],
                              );
                            }
                            if (badges.hasError) {
                              print(badges.error);
                              return Text('${badges.error}');
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          });
                    }
                    if (analytic.hasError) {
                      print(analytic.error);
                      return Text('${analytic.error}');
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Column(
                  children: menuItems.map((menuItem) {
                    return buildMenuItem(menuItem, context);
                  }).toList(),
                ))
          ]),
        ]));
  }
}
