import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test_app/models/GoodCardItem.dart';
import 'package:flutter_test_app/models/GoodCardItemTrimmed.dart';
import 'package:flutter_test_app/models/OrderCardItem.dart';
import 'package:flutter_test_app/models/OrderCardItemTrimmed.dart';
import 'package:flutter_test_app/models/persistant/FoodModel.dart';
import 'package:flutter_test_app/models/OrderCardBookmarkItem.dart';
import 'package:flutter_test_app/services/Authentication.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

abstract class BaseFoodsProvider {
  Future<void> createFoodItem(String image, String name, double price, String unit, DateTime addMoment,
      String description, String whereToPickUp, String whenToPickUp, DateTime expirationDate, double mass);

  Future<List<GoodCardItem>> loadActiveGoods();

  Future<String> uploadImageFile(File imageFile);

  Future<Uint8List> downloadFoodImage(String imagePath);

  Future<List<GoodCardItem>> loadBookedGoods();

  Future<List<GoodCardItemTrimmed>> loadArchivedGoods();

  Future<List<OrderCardBookmarkItem>> loadBookmarkedOrders();

  Future<List<OrderCardItem>> loadBookedOrders();

  Future<List<OrderCardItemTrimmed>> loadArchivedOrders();

  Future<FoodModel> getFoodItemInfo(String id);

  Future<Marker> createFoodItemMarker(GoogleMapsGeocoding geocoding, FoodModel foodModel);
}

class FoodsProvider implements BaseFoodsProvider {
  CollectionReference foodsRef = FirebaseFirestore.instance.collection('foods').withConverter(
      fromFirestore: (snapshot, _) => FoodModel.fromJson(snapshot.data()),
      toFirestore: (food, _) => (food as FoodModel).toJson());

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  @override
  Future<void> createFoodItem(String image, String name, double price, String unit, DateTime addMoment,
      String description, String whereToPickUp, String whenToPickUp, DateTime expirationDate, double mass) async {
    var userId = (await Authentication().getCurrentUser()).uid.toString();
    var foodItem = FoodModel(
        image: image,
        name: name,
        price: price,
        unit: unit,
        ownerID: userId,
        bookmarksCount: 0,
        addMoment: addMoment,
        description: description,
        whereToPickUp: whereToPickUp,
        whenToPickUp: whenToPickUp,
        expirationDate: expirationDate,
        mass: mass,
        mark: null);
    String uniqueID = Uuid().v4();
    foodItem.id = uniqueID;
    global.userProvider.addNewGoodInUser(uniqueID, global.GoodStatus.active);
    return foodsRef
        .doc(uniqueID)
        .set(foodItem)
        .then((value) => print("Food Added"))
        .catchError((error) => print("Failed to add food: $error"));
  }

  @override
  Future<List<GoodCardItem>> loadActiveGoods() async {
    var activeGoods = await global.userProvider.getActiveMagazinesItemID();
    if (activeGoods.isNotEmpty) {
      List<FoodModel> goods = await foodsRef
          .where('id', whereIn: activeGoods)
          .get()
          .then((value) => value.docs.map((e) => e.data() as FoodModel).toList());
      return goods
          .map((e) =>
              GoodCardItem(e.id, e.image, e.name, e.price, e.unit, e.expirationDate, e.bookmarksCount, e.price == 0.0))
          .toList();
    }
    return [];
  }

  @override
  Future<List<GoodCardItem>> loadBookedGoods() async {
    var bookedGoods = await global.userProvider.getBookedMagazinesItemID();
    if (bookedGoods.isNotEmpty) {
      List<FoodModel> goods = await foodsRef
          .where('id', whereIn: bookedGoods)
          .get()
          .then((value) => value.docs.map((e) => e.data() as FoodModel).toList());
      return goods
          .map((e) =>
              GoodCardItem(e.id, e.image, e.name, e.price, e.unit, e.expirationDate, e.bookmarksCount, e.price == 0.0))
          .toList();
    }
    return [];
  }

  @override
  Future<List<GoodCardItemTrimmed>> loadArchivedGoods() async {
    var archivedGoods = await global.userProvider.getArchivedMagazinesItemID();
    if (archivedGoods.isNotEmpty) {
      List<FoodModel> goods = await foodsRef
          .where('id', whereIn: archivedGoods)
          .get()
          .then((value) => value.docs.map((e) => e.data() as FoodModel).toList());
      return goods
          .map((e) => GoodCardItemTrimmed(e.id, e.image, e.name, e.price, e.unit, e.mass, e.mark, e.price == 0.0))
          .toList();
    }
    return [];
  }

  @override
  Future<List<OrderCardBookmarkItem>> loadBookmarkedOrders() async {
    var bookmarkedOrders = await global.userProvider.getBookmarkedOrdersItemID();
    if (bookmarkedOrders.isNotEmpty) {
      List<FoodModel> orders = await foodsRef
          .where('id', whereIn: bookmarkedOrders)
          .get()
          .then((value) => value.docs.map((e) => e.data() as FoodModel).toList());
      return Future.wait(orders
          .map((e) async => OrderCardBookmarkItem(e.id, e.image, e.name, e.price, e.unit, 0.7,
              await global.userProvider.getUserTrimmed(e.ownerID), e.price == 0.0, e.ownerID))
          .toList());
    }
    return [];
  }

  @override
  Future<List<OrderCardItem>> loadBookedOrders() async {
    var bookedOrders = await global.userProvider.getBookedOrdersItemID();
    if (bookedOrders.isNotEmpty) {
      List<FoodModel> orders = await foodsRef
          .where('id', whereIn: bookedOrders)
          .get()
          .then((value) => value.docs.map((e) => e.data() as FoodModel).toList());
      return Future.wait(orders
          .map((e) async => OrderCardItem(e.id, e.image, e.name, e.price, e.unit, 0.7,
              await global.userProvider.getUserTrimmed(e.ownerID), e.price == 0.0, e.ownerID))
          .toList());
    }
    return [];
  }

  @override
  Future<List<OrderCardItemTrimmed>> loadArchivedOrders() async {
    var archivedOrders = await global.userProvider.getArchivedOrdersItemID();
    if (archivedOrders.isNotEmpty) {
      List<FoodModel> orders = await foodsRef
          .where('id', whereIn: archivedOrders)
          .get()
          .then((value) => value.docs.map((e) => e.data() as FoodModel).toList());
      return Future.wait(orders
          .map((e) async => OrderCardItemTrimmed(e.id, e.image, e.name, e.price, e.unit,
              await global.userProvider.getUserTrimmed(e.ownerID), e.price == 0.0, e.ownerID))
          .toList());
    }
    return [];
  }

  @override
  Future<String> uploadImageFile(File imageFile) async {
    String imageID = Uuid().v4();
    try {
      var path = 'foodImages/${imageID + imageFile.path.substring(imageFile.path.lastIndexOf('.'))}';
      await storage.ref(path).putFile(imageFile);
      return path;
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Future<Uint8List> downloadFoodImage(String imagePath) {
    return storage.ref('$imagePath').getData();
  }

  @override
  Future<FoodModel> getFoodItemInfo(String id) async {
    return await foodsRef.doc(id).get().then((value) => (value.data()) as FoodModel);
  }

  @override
  Future<Marker> createFoodItemMarker(GoogleMapsGeocoding geocoding, FoodModel foodModel) async {
    var cords =
        await geocoding.searchByPlaceId(foodModel.whereToPickUp).then((value) => value.results[0].geometry.location);
    return Marker(
      markerId: MarkerId(foodModel.id),
      position: LatLng(cords.lat, cords.lng),
      //infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      /*onTap: () {
        _onMarkerTapped(markerId);
      },*/
    );
  }
}
