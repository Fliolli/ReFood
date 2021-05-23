import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test_app/models/persistant/UserAnalyticModel.dart';
import 'package:flutter_test_app/models/persistant/UserModel.dart';
import 'package:flutter_test_app/services/Authentication.dart';

abstract class BaseUserAnalyticProvider {
  Future<void> addUserAnalyticItem(UserModel userItem, UserAnalyticModel userAnalyticModel);
  Future<UserAnalyticModel> loadUserAnalytics();
  int getSavedPositionsCount(UserAnalyticModel userAnalyticModel);
  int getSavedMassValue(UserAnalyticModel userAnalyticModel);
  int getLessCO2Value(UserAnalyticModel userAnalyticModel);
}

class UserAnalyticProvider implements BaseUserAnalyticProvider {
  CollectionReference userAnalyticRef = FirebaseFirestore.instance
      .collection('userAnalytic')
      .withConverter(
      fromFirestore: (snapshot, _) => UserAnalyticModel.fromJson(snapshot.data()),
      toFirestore: (userAnalyticModel, _) => (userAnalyticModel as UserAnalyticModel).toJson());

  @override
  Future<void> addUserAnalyticItem(UserModel userItem, UserAnalyticModel userAnalyticModel) async {
    return userAnalyticRef
        .doc(userItem.id)
        .set(userAnalyticModel)
        .then((value) => print("UserAnalytic Added"))
        .catchError((error) => print("Failed to add userAnalytic: $error"));
  }

  @override
  Future<UserAnalyticModel> loadUserAnalytics() async {
    return await userAnalyticRef
        .doc((await Authentication().getCurrentUser()).uid)
        .get()
        .then((value) => value.data());
  }

  @override
  int getSavedPositionsCount(UserAnalyticModel userAnalyticModel) {
    return userAnalyticModel.savedPositionsCount;
  }

  @override
  int getSavedMassValue(UserAnalyticModel userAnalyticModel) {
    return userAnalyticModel.savedMassValue;
  }

  @override
  int getLessCO2Value(UserAnalyticModel userAnalyticModel) {
    return userAnalyticModel.lessCO2Value;
  }
}