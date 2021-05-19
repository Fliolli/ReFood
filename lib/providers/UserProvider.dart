import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test_app/models/persistant/UserAnalyticModel.dart';
import 'package:flutter_test_app/models/persistant/UserModel.dart';
import 'package:flutter_test_app/services/Authentication.dart';

abstract class BaseUserProvider {
  Future<void> addUserItem(UserModel userItem);
  Future<void> addUserAnalyticItem(UserModel userItem, UserAnalyticModel userAnalyticModel);
  Future<String> getUserName();
}

class UserProvider implements BaseUserProvider {
  CollectionReference usersRef = FirebaseFirestore.instance
      .collection('users')
      .withConverter(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()),
      toFirestore: (user, _) => (user as UserModel).toJson());

  CollectionReference userAnalyticRef = FirebaseFirestore.instance
      .collection('userAnalytic')
      .withConverter(
      fromFirestore: (snapshot, _) => UserAnalyticModel.fromJson(snapshot.data()),
      toFirestore: (userAnalyticModel, _) => (userAnalyticModel as UserAnalyticModel).toJson());

  Future<String> getUserName() async {
    String id = (await Authentication().getCurrentUser()).uid;
    DocumentReference currentUser = FirebaseFirestore.instance.collection('users').doc(id);

    return currentUser
        .get()
        .then((value) => value.get('name'));
  }

  Future<void> addUserItem(UserModel userItem) async {
    return usersRef
        .doc(userItem.id)
        .set(userItem)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addUserAnalyticItem(UserModel userItem, UserAnalyticModel userAnalyticModel) async {
    return userAnalyticRef
        .doc(userItem.id)
        .set(userAnalyticModel)
        .then((value) => print("UserAnalytic Added"))
        .catchError((error) => print("Failed to add userAnalytic: $error"));
  }
}