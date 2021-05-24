import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test_app/models/BadgeItem.dart';
import 'package:flutter_test_app/models/persistant/BadgeModel.dart';
import 'package:flutter_test_app/models/persistant/UserAnalyticModel.dart';
import 'package:flutter_test_app/data/GlobalData.dart' as global;

abstract class BaseBadgesProvider {
  Future<List<BadgeItem>> loadBadges(UserAnalyticModel userAnalyticModel);
}

class BadgesProvider implements BaseBadgesProvider {
  CollectionReference badgesRef = FirebaseFirestore.instance.collection('badges').withConverter(
      fromFirestore: (snapshot, _) => BadgeModel.fromJson(snapshot.data()),
      toFirestore: (badge, _) => (badge as BadgeModel).toJson());

  @override
  Future<List<BadgeItem>> loadBadges(UserAnalyticModel userAnalyticModel) async {
    List<BadgeModel> badges =
        await badgesRef.get().then((value) => value.docs.map((e) => e.data() as BadgeModel).toList());
    return badges
        .map((e) => BadgeItem(e.image, e.title, e.description, userAnalyticModel.earnedBadgesIDs.contains(e.id),
            global.BackGroundType.dark))
        .toList();
  }
}
