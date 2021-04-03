import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<MenuItem> menuItems = [
    MenuItem(
        Icons.assignment_turned_in_sharp,
        ColorsLibrary.greenColor,
        Text("Заказы"),
        (BuildContext context) => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()))
            }),
    MenuItem(
        Icons.filter_list,
        ColorsLibrary.lightYellow,
        Text("Фильтр"),
        (BuildContext context) => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()))
            }),
    MenuItem(
        Icons.add_business,
        ColorsLibrary.purpleColor,
        Text("Подключите свой бизнес"),
        (BuildContext context) => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()))
            }),
    MenuItem(
        Icons.people_rounded,
        ColorsLibrary.cyanColor,
        Text("Пригласить друзей"),
        (BuildContext context) => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()))
            }),
    MenuItem(
        Icons.help,
        ColorsLibrary.primaryColor,
        Text("Как использовать ReFood"),
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

  Widget _buildMenuItem(MenuItem menuItem) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Ink(
            height: 30,
            decoration: ShapeDecoration(
              color: menuItem._color,
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(
                menuItem._icon,
                color: ColorsLibrary.whiteColor,
                size: 15,
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: menuItem._title,
          ),
          IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              color: ColorsLibrary.primaryColor,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(0),
              onPressed: () {
                menuItem._action(context);
              })
        ],
      ),
    );
  }

  Widget _buildBadgeItem(BadgeItem badgeItem) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(children: <Widget>[
        Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  badgeItem._image,
                  fit: BoxFit.cover,
                  height: 140,
                  width: 140,
                )),
            ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Container(
                  height: 140,
                  width: 140,
                  color: ColorsLibrary.whiteTransparentColor,
                )),
          ],
        ),
        Center(
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  '${badgeItem._title}',
                  style: TextStyle(color: ColorsLibrary.whiteTransparentColor, fontSize: 15),
                )))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Марина', style: StylesLibrary.strongWhiteText),
          centerTitle: true,
          leading: CloseButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Настройки',
              onPressed: () {},
            )
          ],
        ),
        body: Column(children: <Widget>[
          Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorsLibrary.primaryColor,
                  ColorsLibrary.lightOrange,
                ],
              )),
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 36),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: badgeItems.map((badgeItem) {
                          return _buildBadgeItem(badgeItem);
                        }).toList(),
                      )),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 22),
                              child: Column(children: <Widget>[
                                Text(
                                  '${2} шт.',
                                  style: StylesLibrary.strongWhiteText,
                                  textAlign: TextAlign.center,
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 6),
                                    child: Text(
                                      'Позиций \nспасено',
                                      style: TextStyle(color: ColorsLibrary.whiteColor, fontSize: 13),
                                      textAlign: TextAlign.center,
                                    ))
                              ]),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 22),
                              child: Column(children: <Widget>[
                                Text(
                                  'На ${5} куб.м',
                                  style: StylesLibrary.strongWhiteText,
                                  textAlign: TextAlign.center,
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 6),
                                    child: Text(
                                      'Меньше \nвыброс CO2',
                                      style: TextStyle(color: ColorsLibrary.whiteColor, fontSize: 13),
                                      textAlign: TextAlign.center,
                                    ))
                              ]),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 22),
                              child: Column(children: <Widget>[
                                Text(
                                  '${2} кг.',
                                  style: StylesLibrary.strongWhiteText,
                                  textAlign: TextAlign.center,
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 6),
                                    child: Text(
                                      'Еды \nспасено',
                                      style: TextStyle(color: ColorsLibrary.whiteColor, fontSize: 13),
                                      textAlign: TextAlign.center,
                                    ))
                              ]),
                            )
                          ]),
                ),
                )])),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: menuItems.map((menuItem) {
                return _buildMenuItem(menuItem);
              }).toList(),
            ),
          )
        ]));
  }
}

class MenuItem {
  final IconData _icon;
  final Color _color;
  final Text _title;
  final _action;

  MenuItem(this._icon, this._color, this._title, this._action);
}

class BadgeItem {
  final String _image;
  final String _title;
  final String _description;

  BadgeItem(this._image, this._title, this._description);
}