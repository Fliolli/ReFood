import 'package:flutter_test_app/models/persistant/UserModelTrimmed.dart';

class OrderCardItemTrimmed {
  String id;
  String image;
  String name;
  double price;
  String unit;
  UserModelTrimmed owner;
  bool isFree;
  String ownerID;

  OrderCardItemTrimmed(
      this.id,
      this.image,
      this.name,
      this.price,
      this.unit,
      this.owner,
      this.isFree,
      this.ownerID);
}