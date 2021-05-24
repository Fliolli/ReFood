import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;
import 'package:flutter_test_app/models/persistant/UserModel.dart';
import 'package:flutter_test_app/models/persistant/UserModelTrimmed.dart';
import 'package:flutter_test_app/services/Authentication.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

abstract class BaseUserProvider {
  Future<void> getCurrentUser();

  Future<void> addUserItem(UserModel userItem);

  Future<String> getUserName();

  void addNewGoodInUser(String id, global.GoodStatus status);

  Future<List<dynamic>> getMagazineItems();

  Future<List<dynamic>> getActiveMagazinesItemID();

  Future<List<dynamic>> getBookedMagazinesItemID();

  Future<List<dynamic>> getArchivedMagazinesItemID();

  Future<List<dynamic>> getOrdersItems();

  Future<List<dynamic>> getBookmarkedOrdersItemID();

  Future<List<dynamic>> getBookedOrdersItemID();

  Future<List<dynamic>> getArchivedOrdersItemID();

  Future<ListResult> downloadUserDefaultImages();

  Future<String> chooseUserDefaultImage();

  Future<Uint8List> downloadUserImage(String imagePath);

  Future<UserModelTrimmed> getUserTrimmed(String id);

  Future<UserModel> getUserFull(String id);
}

class UserProvider implements BaseUserProvider {
  DocumentReference currentUser;
  String userID;

  CollectionReference usersRef = FirebaseFirestore.instance.collection('users').withConverter(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()),
      toFirestore: (user, _) => (user as UserModel).toJson());

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  firebase_storage.Reference userDefaultImagesRef =
      firebase_storage.FirebaseStorage.instance.ref().child('defaultImages').child('user');

  @override
  Future<void> getCurrentUser() async {
    String id = (await Authentication().getCurrentUser()).uid;
    DocumentReference user = FirebaseFirestore.instance.collection('users').doc(id);
    currentUser = user;
    userID = user.id;
  }

  @override
  Future<String> getUserName() async {
    return currentUser.get().then((value) => value.get('name'));
  }

  @override
  Future<void> addUserItem(UserModel userItem) async {
    usersRef
        .doc(userItem.id)
        .set(userItem)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    global.userProvider.getCurrentUser();
  }

  @override
  void addNewGoodInUser(String id, global.GoodStatus status) async {
    List<dynamic> magazineItems = await getMagazineItems();
    MagazineItem magazineItem = MagazineItem(id: id, status: status);
    magazineItems.add(magazineItem.toJson());
    currentUser.update({'magazineItems': magazineItems});
    global.userProvider.getCurrentUser();
  }

  @override
  Future<List<dynamic>> getMagazineItems() async {
    return currentUser.get().then((value) => value.get('magazineItems'));
  }

  @override
  Future<List<dynamic>> getActiveMagazinesItemID() async {
    return (await getMagazineItems())
        .map((e) => MagazineItem.fromJson(e))
        .where((element) => element.status == global.GoodStatus.active)
        .map((e) => e.id)
        .toList();
  }

  @override
  Future<List<dynamic>> getBookedMagazinesItemID() async {
    return (await getMagazineItems())
        .map((e) => MagazineItem.fromJson(e))
        .where((element) => element.status == global.GoodStatus.booked)
        .map((e) => e.id)
        .toList();
  }

  @override
  Future<List<dynamic>> getArchivedMagazinesItemID() async {
    return (await getMagazineItems())
        .map((e) => MagazineItem.fromJson(e))
        .where((element) => element.status == global.GoodStatus.archived)
        .map((e) => e.id)
        .toList();
  }

  @override
  Future<List<dynamic>> getOrdersItems() async {
    return currentUser.get().then((value) => value.get('orderItems'));
  }

  @override
  Future<List<dynamic>> getBookmarkedOrdersItemID() async {
    return (await getOrdersItems())
        .map((e) => OrderItem.fromJson(e))
        .where((element) => element.status == global.OrderStatus.bookmarked)
        .map((e) => e.id)
        .toList();
  }

  @override
  Future<List<dynamic>> getBookedOrdersItemID() async {
    return (await getOrdersItems())
        .map((e) => OrderItem.fromJson(e))
        .where((element) => element.status == global.OrderStatus.booked)
        .map((e) => e.id)
        .toList();
  }

  @override
  Future<List<dynamic>> getArchivedOrdersItemID() async {
    return (await getOrdersItems())
        .map((e) => OrderItem.fromJson(e))
        .where((element) => element.status == global.OrderStatus.archived)
        .map((e) => e.id)
        .toList();
  }

  @override
  Future<UserModelTrimmed> getUserTrimmed(String id) async {
    return await usersRef.doc(id).get().then((value) => (UserModelTrimmed.fromUser(value.data())));
  }

  @override
  Future<UserModel> getUserFull(String id) async {
    return await usersRef.doc(id).get().then((value) => (value.data()));
  }

  @override
  Future<ListResult> downloadUserDefaultImages() {
    return userDefaultImagesRef.list();
  }

  @override
  Future<String> chooseUserDefaultImage() async {
    var defaultImages = await downloadUserDefaultImages().then((value) => value.items);
    return defaultImages[Random().nextInt(defaultImages.length)].fullPath;
  }

  @override
  Future<Uint8List> downloadUserImage(String imagePath) async {
    if (imagePath.isEmpty) {
      print('nil');
    }
    return storage.ref(imagePath).getData();
  }
}
