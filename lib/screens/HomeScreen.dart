import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/services/Authentication.dart';
import 'package:flutter_test_app/widgets/OrderCardItem.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'ProfileScreen.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import '../widgets/BottomNav.dart';
import '../utils/PlatformUtils.dart';
import 'package:group_button/group_button.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart' as strings;
import 'package:flutter_test_app/data/GlobalData.dart' as global;
import 'package:flutter_test_app/widgets/FavoriteCardItem.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuthentication auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  Completer<GoogleMapController> _controller = Completer();

  final LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(children: <Widget>[
        SizedBox.expand(
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topRight,
          margin: const EdgeInsets.symmetric(vertical: 35, horizontal: 10),
          child: FloatingActionButton(
            onPressed: () {
              _signOut();
            },
            child: selectByPlatform(
                const Icon(
                  CupertinoIcons.location_north,
                  color: ColorsLibrary.primaryColor,
                ),
                const Icon(
                  Icons.navigation,
                  color: ColorsLibrary.primaryColor,
                )),
            backgroundColor: ColorsLibrary.whiteColor,
            heroTag: "location",
          ),
        ),
        DraggableScrollableSheet(
            initialChildSize: 0.1,
            maxChildSize: 0.86,
            minChildSize: 0.1,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: ColorsLibrary.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: sheet(scrollController, context),
              );
            }),
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 35, horizontal: 10),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              child: selectByPlatform(
                  const Icon(
                    CupertinoIcons.line_horizontal_3,
                    color: ColorsLibrary.middleBlack,
                  ),
                  const Icon(
                    Icons.menu,
                    color: ColorsLibrary.middleBlack,
                  )),
              backgroundColor: ColorsLibrary.whiteColor,
              heroTag: "menu",
            )),
      ])
          //_widgetOptions.elementAt(_selectedIndex),
          ),
      bottomNavigationBar: const BottomNavCustom(),
    );
  }
}

Widget sheet(ScrollController sc, BuildContext context) {
  List<OrderCardItem> orders = [
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

  List<FavoriteCardItem> favorites = [
    FavoriteCardItem(
      000,
      "Марта",
      4.7,
      'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
    ),
    FavoriteCardItem(
      000,
      "Марта",
      4.7,
      'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
    ),
    FavoriteCardItem(
      000,
      "Марта",
      4.7,
      'https://avatars.mds.yandex.net/get-zen_doc/4303740/pub_60672ce16d990144ce8ba4ab_60673783b207860379f6c9dd/scale_1200',
    ),
  ];

  return global.selectedBottomNavItem == 1
      ? Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ListView(
            controller: sc,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 0),
                    padding: EdgeInsets.only(top: 0),
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                        color: ColorsLibrary.neutralGray,
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 24, left: 24),
                  child: Text(
                    "Welcome to ReFood!",
                    style: StylesLibrary.strongBlackTextStyle
                        .merge(TextStyle(fontSize: 17)),
                  )),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Row(
                    children: [
                      GroupButton(
                        buttonHeight: 45,
                        spacing: 8,
                        isRadio: false,
                        direction: Axis.horizontal,
                        onSelected: (index, isSelected) => print(
                            '$index button is ${isSelected ? 'selected' : 'unselected'}'),
                        buttons: [
                          strings.meals,
                          strings.bread,
                          strings.pastries,
                          strings.vegetables,
                          strings.fruits,
                          strings.drink,
                        ],
                        selectedTextStyle: selectByPlatform(
                            StylesLibrary.IOSPrimaryWhiteTextStyle,
                            StylesLibrary.AndroidPrimaryWhiteTextStyle),
                        unselectedTextStyle: selectByPlatform(
                                StylesLibrary.IOSPrimaryBlackTextStyle,
                                StylesLibrary.AndroidPrimaryBlackTextStyle)
                            .merge(TextStyle(color: ColorsLibrary.middleBlack)),
                        selectedColor: ColorsLibrary.primaryColor,
                        unselectedColor: ColorsLibrary.whiteTransparentColor,
                        unselectedBorderColor: ColorsLibrary.neutralGray,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: orders.map((orderCardItem) {
                  return buildOrderCardItem(orderCardItem, context);
                }).toList(),
              ),
            ],
          ),
        )
      : global.selectedBottomNavItem == 0
          ? ListView(controller: sc, children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 12),
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                        color: ColorsLibrary.neutralGray,
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  ),
                ],
              ),
            ])
          : ListView(controller: sc, children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 12),
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                        color: ColorsLibrary.neutralGray,
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Column(
                  children: favorites.map((favoriteCardItem) {
                    return buildFavoriteCardItem(favoriteCardItem, context);
                  }).toList(),
                ),
              ),
            ]);
}
