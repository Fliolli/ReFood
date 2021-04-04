import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import '../utils/PlatformUtils.dart';
import '../widgets/MenuItem.dart';
import '../widgets/BadgeItem.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<MenuItem> menuItems = [
    MenuItem(
        selectByPlatform(
          CupertinoIcons.list_dash,
          Icons.list_rounded,
        ),
        ColorsLibrary.greenColor,
        "Заказы",
        (BuildContext context) => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()))
            }),
    MenuItem(
        selectByPlatform(
          CupertinoIcons.line_horizontal_3_decrease,
          Icons.filter_list,
        ),
        ColorsLibrary.lightYellow,
        "Фильтр",
        (BuildContext context) => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()))
            }),
    MenuItem(
        selectByPlatform(
          CupertinoIcons.briefcase,
          Icons.add_business_rounded,
        ),
        ColorsLibrary.purpleColor,
        "Подключите свой бизнес",
        (BuildContext context) => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()))
            }),
    MenuItem(
        selectByPlatform(
          CupertinoIcons.person_2,
          Icons.people_rounded,
        ),
        ColorsLibrary.cyanColor,
        "Пригласить друзей",
        (BuildContext context) => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()))
            }),
    MenuItem(
        selectByPlatform(
          CupertinoIcons.question,
          CupertinoIcons.question,
        ),
        ColorsLibrary.primaryColor,
        "Как использовать ReFood",
        (BuildContext context) => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()))
            }),
  ];

  final List<BadgeItem> badgeItems = [
    BadgeItem(("assets/images/1.jpg"), "Климат кадет", "Чтобы получить"),
    BadgeItem(("assets/images/2.jpg"), "Климат кадет", "Чтобы получить"),
    BadgeItem(("assets/images/3.jpg"), "Климат кадет", "Чтобы получить"),
    BadgeItem(("assets/images/4.jpg"), "Климат кадет", "Чтобы получить"),
    BadgeItem(("assets/images/5.jpg"), "Климат кадет", "Чтобы получить"),
    BadgeItem(("assets/images/6.jpg"), "Климат кадет", "Чтобы получить"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title:
              Text('Марина', style: StylesLibrary.strongWhiteTextStyle.merge(TextStyle(fontSize: 18))),
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
              onPressed: () {},
            )
          ],
        ),
        body: Column(children: <Widget>[
          Container(
              height: 400,
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
                  margin: const EdgeInsets.symmetric(vertical: 36),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: badgeItems.map((badgeItem) {
                          return buildBadgeItem(badgeItem);
                        }).toList(),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 18),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(children: <Widget>[
                          Text(
                            '${2} шт.',
                            style: StylesLibrary.strongWhiteTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 6),
                              child: Text(
                                'Позиций \nспасено',
                                style: StylesLibrary.optionalWhiteTextStyle,
                                textAlign: TextAlign.center,
                              ))
                        ]),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(children: <Widget>[
                          Text(
                            'На ${5} куб.м',
                            style: StylesLibrary.strongWhiteTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 6),
                              child: Text(
                                'Меньше \nвыброс CO2',
                                style: StylesLibrary.optionalWhiteTextStyle,
                                textAlign: TextAlign.center,
                              ))
                        ]),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(children: <Widget>[
                          Text(
                            '${2} кг.',
                            style: StylesLibrary.strongWhiteTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 6),
                              child: Text(
                                'Еды \nспасено',
                                style: StylesLibrary.optionalWhiteTextStyle,
                                textAlign: TextAlign.center,
                              ))
                        ]),
                      )
                    ]),
                  ),
                )
              ])),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: menuItems.map((menuItem) {
                return buildMenuItem(menuItem);
              }).toList(),
            ),
          )
        ]));
  }
}
