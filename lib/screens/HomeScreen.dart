import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/OrderCardItem.dart';
import 'package:flutter_test_app/models/persistant/UserModelTrimmed.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/services/Authentication.dart';
import 'package:flutter_test_app/widgets/OrderCardItem.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'ProfileScreen.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import '../widgets/BottomNav.dart';
import '../utils/PlatformUtils.dart';
import 'package:group_button/group_button.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart' as strings;
import 'package:flutter_test_app/data/GlobalData.dart' as global;
import 'package:flutter_test_app/widgets/FavoriteCardItem.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.auth, this.userId, this.onSignedOut}) : super(key: key);

  final BaseAuthentication auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final geocoding = GoogleMapsGeocoding(
      apiKey:
          Platform.isAndroid ? 'AIzaSyDeWEmtAR98Oxm19lCOu1eEdwtDUKrHGjk' : 'AIzaSyDYds6AfFKxRSrpc1q608pIhRQI2pZfCC8');

  Completer<GoogleMapController> _controller = Completer();

  final LatLng _center = const LatLng(55.7522200, 37.6155600);

  List<Marker> markers = List.generate(
      5,
      (index) => Marker(
            markerId: MarkerId(index.toString()),
            position: LatLng(55.7522200 - Random().nextDouble()/2 , 37.6155600 - Random().nextDouble()/5),
            //infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
            /*onTap: () {
        _onMarkerTapped(markerId);
      },*/
          ),
      growable: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(children: <Widget>[
        SizedBox.expand(
          child: GoogleMap(
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: Set<Marker>.of(markers),
          ),
        ),
        Container(
          alignment: Alignment.topRight,
          margin: const EdgeInsets.symmetric(vertical: 35, horizontal: 10),
          child: FloatingActionButton(
            onPressed: () {
              _checkLocationPermission();
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
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                            auth: widget.auth,
                            userId: widget.userId,
                            onSignedOut: widget.onSignedOut,
                          )),
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

  _checkLocationPermission() async {
    if (await Permission.location.isGranted ||
        await Permission.locationAlways.isGranted ||
        await Permission.locationWhenInUse.isGranted) {
      return Container();
    } else {
      openAppSettings();
    }
  }
}

Widget sheet(ScrollController sc, BuildContext context) {
  List<OrderCardItem> orders = [
    OrderCardItem(
        "000",
        'foodImages/kruassani-shokoladnoi-nachinkoi.jpg',
        "Шоколадные круассаны",
        20,
        strings.thingUnit,
        0.7,
        UserModelTrimmed(
            name: 'Марина', profileImage: 'defaultImages/user/e59e552d628037070489aca02f9a2698.png', rating: 4.7),
        false,
        'id'),
    OrderCardItem(
        "000",
        'foodImages/92075cdf250236caacde72d49557d65d.jpg',
        "Свежая зелень",
        0,
        strings.thingUnit,
        2.6,
        UserModelTrimmed(
            name: 'Димон', profileImage: 'defaultImages/user/f0d6ffe23f6b71c95d72db400675e52b.webp', rating: 4.0),
        false,
        'id'),
    OrderCardItem(
        "000",
        'foodImages/HTB1eFPBe_Zmx1VjSZFGq6yx2XXaa.jpg',
        "Ланч с рисом",
        100,
        strings.thingUnit,
        0.7,
        UserModelTrimmed(
            name: 'Марина', profileImage: 'defaultImages/user/e59e552d628037070489aca02f9a2698.png', rating: 4.7),
        false,
        'id'),
  ];

  List<FavoriteCardItem> favorites = [
    FavoriteCardItem(
      000,
      "Марина",
      4.7,
      'https://cdn.dribbble.com/users/1044993/screenshots/14109938/media/e59e552d628037070489aca02f9a2698.png',
    ),
    FavoriteCardItem(
      000,
      "Владислав",
      4.1,
      'https://sun9-66.userapi.com/impg/c854024/v854024796/17f675/yf6NffQwiAA.jpg?size=1185x772&quality=96&sign=11108a2ccd849b4b150ea906875aaafb&type=album',
    ),
    FavoriteCardItem(
      000,
      "Димон",
      4.0,
      'https://firebasestorage.googleapis.com/v0/b/refoodapp-f852f.appspot.com/o/defaultImages%2Fuser%2Ff0d6ffe23f6b71c95d72db400675e52b.webp?alt=media&token=3859a862-63b5-4061-9aa8-715c0be930ef',
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
                        color: ColorsLibrary.neutralGray, borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 24, left: 24),
                  child: Text(
                    "Поиск позиций",
                    style: StylesLibrary.strongBlackTextStyle.merge(TextStyle(fontSize: 17)),
                  )),
              Divider(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Row(
                    children: [
                      GroupButton(
                        buttonHeight: 45,
                        spacing: 8,
                        isRadio: false,
                        direction: Axis.horizontal,
                        onSelected: (index, isSelected) =>
                            print('$index button is ${isSelected ? 'selected' : 'unselected'}'),
                        buttons: [
                          strings.meals,
                          strings.bread,
                          strings.pastries,
                          strings.vegetables,
                          strings.fruits,
                          strings.drink,
                        ],
                        selectedTextStyle: selectByPlatform(
                            StylesLibrary.IOSPrimaryWhiteTextStyle, StylesLibrary.AndroidPrimaryWhiteTextStyle),
                        unselectedTextStyle: selectByPlatform(
                                StylesLibrary.IOSPrimaryBlackTextStyle, StylesLibrary.AndroidPrimaryBlackTextStyle)
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
                            color: ColorsLibrary.neutralGray, borderRadius: BorderRadius.all(Radius.circular(12.0))),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 24, left: 24),
                      child: Text(
                        "Добро пожаловать в ReFood!",
                        style: StylesLibrary.strongBlackTextStyle.merge(TextStyle(fontSize: 17)),
                      )),
                  Divider(),
                  Container(
                      width: 260,
                      height: 200,
                      padding: EdgeInsets.only(top: 12),
                      margin: EdgeInsets.symmetric(horizontal: 55),
                      child: Center(
                          child: Text(
                        'Нажмите на маркер подходящей позиции на карте и здесь появится подробная информация о выбранном товаре..',
                        textAlign: TextAlign.justify,
                        style:
                            selectByPlatform(StylesLibrary.optionalBlackTextStyle, StylesLibrary.optionalBlackTextStyle)
                                .merge(const TextStyle(fontSize: 13)),
                      )))
                ],
              ),
            )
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
                        color: ColorsLibrary.neutralGray, borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 24, left: 24),
                  child: Text(
                    "Фавориты",
                    style: StylesLibrary.strongBlackTextStyle.merge(TextStyle(fontSize: 17)),
                  )),
              Divider(),
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
