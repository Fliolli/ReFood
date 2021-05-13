import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/GlobalData.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/screens/GoodsScreen.dart';
import 'package:flutter_test_app/screens/OrdersScreen.dart';
import 'package:flutter_test_app/widgets/AchievementItem.dart';

import '../utils/PlatformUtils.dart';
import '../widgets/BadgeItem.dart';
import '../widgets/MenuItem.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  final List<BadgeItem> badgeItems = [
    const BadgeItem(
        ("assets/images/1.jpg"), "Климат кадет", BackGroundType.dark, true),
    const BadgeItem(
        ("assets/images/2.jpg"), "Климат кадет", BackGroundType.dark, false),
    const BadgeItem(
        ("assets/images/3.jpg"), "Климат кадет", BackGroundType.dark, true),
    const BadgeItem(
        ("assets/images/4.jpg"), "Климат кадет", BackGroundType.dark, false),
    const BadgeItem(
        ("assets/images/5.jpg"), "Климат кадет", BackGroundType.dark, false),
    const BadgeItem(
        ("assets/images/6.jpg"), "Климат кадет", BackGroundType.dark, true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Марина',
              style: StylesLibrary.strongWhiteTextStyle
                  .merge(TextStyle(fontSize: 17))),
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
                child: Column(children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 32),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: badgeItems.map((badgeItem) {
                            return buildBadgeItem(badgeItem, context);
                          }).toList(),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: <Widget>[
                        buildAchievementItem(AchievementItem('${2} шт.',
                            'Позиций \nспасено', BackGroundType.dark)),
                        buildAchievementItem(AchievementItem('На ${5} куб.м',
                            'Меньше \nвыброс CO2', BackGroundType.dark)),
                        buildAchievementItem(AchievementItem(
                            '${2} кг.', 'Еды \nспасено', BackGroundType.dark)),
                      ]),
                    ),
                  )
                ])),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Column(
                  children: menuItems.map((menuItem) {
                    return buildMenuItem(menuItem, context);
                  }).toList(),
                ))
          ])
        ]));
  }
}
