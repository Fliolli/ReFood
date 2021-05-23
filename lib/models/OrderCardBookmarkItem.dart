import 'package:flutter_test_app/models/persistant/UserModelTrimmed.dart';

class OrderCardBookmarkItem {
  String id;
  String image;
  String name;
  double price;
  String unit;
  double distance;
  UserModelTrimmed owner;
  bool isFree;
  String ownerID;

  OrderCardBookmarkItem(
      this.id,
      this.image,
      this.name,
      this.price,
      this.unit,
      this.distance,
      this.owner,
      this.isFree,
      this.ownerID);
}