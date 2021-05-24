import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/GlobalData.dart';
import 'package:flutter_test_app/models/persistant/FoodModel.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';
import 'package:flutter_test_app/screens/NewOrEditGoodScreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import '../utils/PlatformUtils.dart';
import 'package:intl/intl.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;
import 'package:flutter_test_app/resources/StringsLibrary.dart' as strings;
import 'package:flutter_test_app/widgets/InfoPropertyItem.dart';

class GoodItemInfoScreen extends StatefulWidget {
  GoodItemInfoScreen({Key key, this.goodType, this.id});

  final global.GoodType goodType;
  final String id;

  @override
  _GoodItemInfoScreenState createState() => _GoodItemInfoScreenState();
}

class _GoodItemInfoScreenState extends State<GoodItemInfoScreen> {
  final List<String> popUpMenuItems = [
    "Редактировать",
    "Удалить",
  ];

  final List<String> popUpMenuItemsTrimmed = [
    "Удалить",
  ];

  final geocoding = GoogleMapsGeocoding(
      apiKey:
          Platform.isAndroid ? 'AIzaSyDeWEmtAR98Oxm19lCOu1eEdwtDUKrHGjk' : 'AIzaSyDYds6AfFKxRSrpc1q608pIhRQI2pZfCC8');

  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  FoodModel good;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorsLibrary.whiteColor,
          elevation: 0,
          title: Text(strings.good, style: StylesLibrary.strongBlackTextStyle.merge(const TextStyle(fontSize: 16))),
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
                  return widget.goodType == global.GoodType.full
                      ? popUpMenuItems.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList()
                      : popUpMenuItemsTrimmed.map((String choice) {
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
            good = foodItem.data;
            if (foodItem.hasData) {
              return ListView(children: [
                Column(
                  children: <Widget>[
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
                    widget.goodType != GoodType.trimmed
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
                        : Container(),
                    widget.goodType != GoodType.trimmed
                        ? FutureBuilder(
                            future: global.userProvider.getUserTrimmed(global.userProvider.userID),
                            builder: (context, owner) {
                              if (owner.hasData) {
                                return Card(
                                  color: ColorsLibrary.lightGray,
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  elevation: 0,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                    child: Column(
                                      children: [
                                        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(right: 5),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(60),
                                              child: FutureBuilder(
                                                  future: global.userProvider.downloadUserImage(owner.data.profileImage),
                                                  builder: (context, image) {
                                                    if (image.hasData) {
                                                      return Image.memory(image.data as Uint8List,
                                                          height: 40, width: 40, fit: BoxFit.cover);
                                                    }
                                                    if (image.hasError) {
                                                      print(image.error);
                                                      return Text('${image.error}');
                                                    } else {
                                                      return Container(
                                                          height: 40, width: 40, child: Center(child: CircularProgressIndicator()));
                                                    }
                                                  }),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.45,
                                            child: Text(
                                              owner.data.name,
                                              style: selectByPlatform(StylesLibrary.strongBlackTextStyle,
                                                      StylesLibrary.strongBlackTextStyle)
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
                                              owner.data.rating.toString(),
                                              style: selectByPlatform(StylesLibrary.strongBlackTextStyle,
                                                      StylesLibrary.strongBlackTextStyle)
                                                  .merge(const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.normal,
                                                      color: ColorsLibrary.blackColor)),
                                            ),
                                          ),
                                        ]),
                                        Container(
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
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              if (owner.hasError) {
                                print(owner.error);
                                return Text('${owner.error}');
                              } else {
                                return Container(
                                    height: 90, width: 90, child: Center(child: CircularProgressIndicator()));
                              }
                            })
                        : Container(),
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
                        widget.goodType != GoodType.trimmed
                            ? Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: buildInfoPropertyItem(
                                    InfoPropertyItem(strings.expirationDate,
                                        DateFormat("dd-MM-yy hh:mm").format(foodItem.data.expirationDate).toString()),
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
                        widget.goodType != GoodType.trimmed
                            ? buildInfoPropertyItem(
                                InfoPropertyItem(
                                  strings.whenToPickUp,
                                  foodItem.data.whenToPickUp,
                                ),
                                context)
                            : Container(),
                        buildInfoPropertyItem(
                            InfoPropertyItem(
                              strings.mass,
                              'Масса товара: ${foodItem.data.mass.toString()} кг.',
                            ),
                            context),
                        widget.goodType == GoodType.trimmed
                            ? buildInfoPropertyItem(
                                InfoPropertyItem(
                                  strings.mark,
                                  'Оценка покупателя: ${foodItem.data.toString()}',
                                ),
                                context)
                            : Container(),
                      ],
                    ),
                  ),
                ),
                widget.goodType != GoodType.trimmed
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
    if (choice == "Редактировать") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewOrEditGoodScreen(
              screenType: ScreenType.editGood,
              id: widget.id,
              name: good.name,
              description: good.description,
              image: good.image,
              expirationDate: good.expirationDate,
              price: good.price,
              unit: good.unit,
              whenToPickUp: good.whenToPickUp,
              whereToPickUp: good.whereToPickUp,
              isFree: good.price == 0.0,
            ),
          ));
    } else if (choice == "Удалить") {}
  }
}
