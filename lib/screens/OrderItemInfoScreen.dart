import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;
import 'package:flutter_test_app/models/persistant/FoodModel.dart';
import 'package:flutter_test_app/models/persistant/UserModelTrimmed.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart';
import 'package:flutter_test_app/resources/StringsLibrary.dart' as strings;
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/screens/UserInfoScreen.dart';
import 'package:flutter_test_app/widgets/InfoPropertyItem.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart';

import '../utils/PlatformUtils.dart';

class OrderItemInfoScreen extends StatefulWidget {
  final global.OrderStatus orderType;
  final String id;
  final UserModelTrimmed owner;

  OrderItemInfoScreen({Key key, this.orderType, this.id, this.owner});

  @override
  _OrderItemInfoScreenState createState() => _OrderItemInfoScreenState();
}

class _OrderItemInfoScreenState extends State<OrderItemInfoScreen> {
  final List<String> bookmarkedPopUpMenuItems = [
    "Забронировать",
    "Удалить из закладок",
  ];

  final List<String> bookedPopUpMenuItems = [
    "Подтвердить получение",
    "Отменить бронь",
  ];

  final List<String> archivePopUpMenuItems = [
    "Удалить",
  ];

  @override
  Widget build(BuildContext context) {
    final geocoding = GoogleMapsGeocoding(
        apiKey:
            Platform.isAndroid ? 'AIzaSyDeWEmtAR98Oxm19lCOu1eEdwtDUKrHGjk' : 'AIzaSyDYds6AfFKxRSrpc1q608pIhRQI2pZfCC8');

    Completer<GoogleMapController> _controller = Completer();

    void _onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorsLibrary.whiteColor,
          elevation: 0,
          title: Text(
              widget.orderType == global.OrderStatus.bookmarked
                  ? bookingTitle
                  : widget.orderType == global.OrderStatus.booked
                      ? bookedTitle
                      : archivedTitle,
              style: StylesLibrary.strongBlackTextStyle.merge(const TextStyle(fontSize: 16))),
          leading: CloseButton(
            color: ColorsLibrary.primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: PopupMenuButton<String>(
                child: selectByPlatform(
                    Icon(
                      Icons.more_horiz,
                      color: ColorsLibrary.middleBlack,
                    ),
                    Icon(
                      Icons.more_vert,
                      color: ColorsLibrary.middleBlack,
                    )),
                elevation: 3.2,
                onSelected: _selectMenuItem,
                itemBuilder: (BuildContext context) {
                  return widget.orderType == global.OrderStatus.bookmarked
                      ? bookmarkedPopUpMenuItems.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList()
                      : widget.orderType == global.OrderStatus.booked
                          ? bookedPopUpMenuItems.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList()
                          : archivePopUpMenuItems.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                },
              ),
            ),
          ]),
      body: FutureBuilder(
          future: global.foodsProvider.getFoodItemInfo(widget.id),
          builder: (context, foodItem) {
            if (foodItem.hasData) {
              return ListView(children: [
                Column(
                  children: <Widget>[
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(130),
                              child: FutureBuilder(
                                  future: global.foodsProvider.downloadFoodImage(foodItem.data.image),
                                  builder: (context, image) {
                                    if (image.hasData) {
                                      return Image.memory(image.data as Uint8List,
                                          height: 255, width: 255, fit: BoxFit.cover);
                                    }
                                    if (image.hasError) {
                                      print(image.error);
                                      return Text('${image.error}');
                                    } else {
                                      return Container(
                                          height: 90, width: 90, child: Center(child: CircularProgressIndicator()));
                                    }
                                  }),
                            ),
                          ),
                        ),
                        widget.orderType == global.OrderStatus.bookmarked
                            ? Positioned(
                                top: 15,
                                left: 65,
                                child: InkWell(
                                  splashColor: ColorsLibrary.whiteTransparentColor,
                                  onTap: () {
                                    try {
                                      setState(() {
                                        global.foodItem.isInBookmarks = !global.foodItem.isInBookmarks;
                                        final snackBar = SnackBar(
                                          content: Text(
                                            global.foodItem.isInBookmarks
                                                ? strings.orderAddedToBookmarks
                                                : strings.orderDeletedFromBookmarks,
                                            style: StylesLibrary.optionalWhiteTextStyle,
                                          ),
                                          backgroundColor: global.foodItem.isInBookmarks
                                              ? ColorsLibrary.lightGreen
                                              : ColorsLibrary.lightYellow,
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      });
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: ColorsLibrary.whiteColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 6,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      global.foodItem.isInBookmarks ? CupertinoIcons.heart_solid : CupertinoIcons.heart,
                                      size: 32,
                                      color: ColorsLibrary.lightOrange,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, right: 24, left: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.59,
                            child: Text(
                              foodItem.data.name,
                              textAlign: TextAlign.center,
                              style: selectByPlatform(StylesLibrary.IOSPrimaryBlackTextStyle,
                                      StylesLibrary.AndroidPrimaryBlackTextStyle)
                                  .merge(const TextStyle(fontSize: 24)),
                              softWrap: true,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    widget.orderType != global.OrderStatus.archived
                        ? Container(
                            padding: const EdgeInsets.only(right: 36, left: 36, bottom: 16),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              formatTimeDifference(foodItem.data.addMoment),
                              textAlign: TextAlign.center,
                              style: selectByPlatform(
                                      StylesLibrary.optionalBlackTextStyle, StylesLibrary.optionalBlackTextStyle)
                                  .merge(const TextStyle(
                                fontSize: 11,
                              )),
                            ),
                          )
                        : Container(
                            height: 16,
                          ),
                    Card(
                      color: ColorsLibrary.lightGray,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      elevation: 0,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserInfoScreen(
                                        id: global.userItem.id,
                                        ownerName: widget.owner.name,
                                        ownerProfileImage: widget.owner.profileImage,
                                        ownerRating: widget.owner.rating,
                                      ),
                                    ));
                              },
                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: FutureBuilder(
                                        future: global.userProvider.downloadUserImage(widget.owner.profileImage),
                                        builder: (context, profileImage) {
                                          if (profileImage.hasData) {
                                            return Image.memory(profileImage.data as Uint8List,
                                                height: 40, width: 40, fit: BoxFit.cover);
                                          }
                                          if (profileImage.hasError) {
                                            print(profileImage.error);
                                            return Text('${profileImage.error}');
                                          } else {
                                            return Container(
                                                height: 40,
                                                width: 40,
                                                child: Center(child: CircularProgressIndicator()));
                                          }
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  child: Text(
                                    widget.owner.name,
                                    style: selectByPlatform(
                                            StylesLibrary.strongBlackTextStyle, StylesLibrary.strongBlackTextStyle)
                                        .merge(const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: ColorsLibrary.blackColor)),
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Icon(
                                    Icons.star_border_rounded,
                                    color: ColorsLibrary.lightOrange,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                  child: Text(
                                    widget.owner.rating.toString(),
                                    style: selectByPlatform(
                                            StylesLibrary.strongBlackTextStyle, StylesLibrary.strongBlackTextStyle)
                                        .merge(const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: ColorsLibrary.blackColor)),
                                  ),
                                ),
                              ]),
                            ),
                            widget.orderType != global.OrderStatus.archived
                                ? Container(
                                    padding: const EdgeInsets.only(top: 8, left: 10),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      'Товар в закладках у ${foodItem.data.bookmarksCount} пользователей(я)',
                                      style: selectByPlatform(StylesLibrary.optionalBlackTextStyle,
                                              StylesLibrary.optionalBlackTextStyle)
                                          .merge(const TextStyle(
                                        fontSize: 12,
                                      )),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16, right: 24, left: 24),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    foodItem.data.description,
                    textAlign: TextAlign.justify,
                    style: selectByPlatform(StylesLibrary.optionalBlackTextStyle, StylesLibrary.optionalBlackTextStyle)
                        .merge(const TextStyle(fontSize: 16, wordSpacing: -6)),
                  ),
                ),
                Card(
                  color: ColorsLibrary.lightGray,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  elevation: 0,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      children: [
                        widget.orderType != global.OrderStatus.archived
                            ? Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: buildInfoPropertyItem(
                                    InfoPropertyItem(
                                        strings.expirationDate,
                                        DateFormat("dd-MM-yy").format(foodItem.data.expirationDate).toString() +
                                            '  (дд-мм-гг)'),
                                    context),
                              )
                            : Container(
                                height: 16,
                              ),
                        buildInfoPropertyItem(
                            InfoPropertyItem(
                              strings.price,
                              foodItem.data.price == 0.0
                                  ? 'бесплатно'
                                  : '${foodItem.data.price.toString()} р. ${foodItem.data.unit}',
                            ),
                            context),
                        widget.orderType != global.OrderStatus.archived
                            ? buildInfoPropertyItem(
                                InfoPropertyItem(
                                  strings.whenToPickUp,
                                  foodItem.data.whenToPickUp,
                                ),
                                context)
                            : Container(),
                        widget.orderType != global.OrderStatus.archived
                            ? buildInfoPropertyItem(
                                InfoPropertyItem(
                                  strings.distance,
                                  '${0.7.toString()} км. от Вас',
                                ),
                                context)
                            : Container(),
                      ],
                    ),
                  ),
                ),
                widget.orderType != global.OrderStatus.archived
                    ? FutureBuilder(
                        future: global.foodsProvider.createFoodItemMarker(geocoding, foodItem.data),
                        builder: (context, marker) {
                          if (marker.hasData) {
                            return Container(
                              margin: const EdgeInsets.only(top: 4, bottom: 16, left: 24, right: 24),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                child: GoogleMap(
                                  zoomControlsEnabled: false,
                                  myLocationEnabled: true,
                                  onMapCreated: _onMapCreated,
                                  gestureRecognizers: Set()
                                    ..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())),
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(marker.data.position.latitude, marker.data.position.longitude),
                                    zoom: 11.0,
                                  ),
                                  markers: Set<Marker>.of([marker.data]),
                                ),
                              ),
                            );
                          }
                          if (marker.hasError) {
                            print(marker.error);
                            return Text('${marker.error}');
                          } else {
                            return Container(
                                height: 100, width: 100, child: Center(child: CircularProgressIndicator()));
                          }
                        })
                    : Container(),
              ]);
            }
            if (foodItem.hasError) {
              print(foodItem.error);
              return Text('${foodItem.error}');
            } else {
              return Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: CircularProgressIndicator()));
            }
          }),
    );
  }

  void _selectMenuItem(String choice) {
    if (choice == "Забронировать") {
    } else if (choice == "Удалить из закладок") {
    } else if (choice == "Подтвердить получение") {
      showSlideDialog(
        context: context,
        pillColor: ColorsLibrary.neutralGray,
        backgroundColor: ColorsLibrary.whiteColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.symmetric(horizontal: 36),
          child: ListView(
            children: [
              Column(
                children: [],
              )
            ],
          ),
        ),
      );
    } else if (choice == "Отменить бронь") {
    } else if (choice == "Удалить") {}
  }
}
