import 'package:flutter_test_app/data/GlobalData.dart';

class UserModel {
  String id;
  String name;
  String profileImage;
  double rating;
  String aboutMe;
  int countOfInFavorites;
  List<MagazineItem> magazineItems;
  List<String> favoritesIDs;
  String addressDescription;
  String addressID;
  List<OrderItem> orderItems;

  UserModel(
      {this.id,
      this.name,
      this.profileImage,
      this.rating,
      this.aboutMe,
      this.countOfInFavorites,
      this.magazineItems,
      this.favoritesIDs,
      this.addressDescription,
      this.addressID,
      this.orderItems});

  UserModel.fromJson(Map<String, Object> json)
      : this(
          id: json['id'] as String,
          name: json['name'] as String,
          profileImage: json['profileImage'] as String,
          rating: json['rating'] as double,
          aboutMe: json['aboutMe'] as String,
          countOfInFavorites: json['countOfInFavorites'] as int,
          magazineItems: (json['magazineItems'] as List<Object>)
              .map((e) => MagazineItem.fromJson(e))
              .toList(),
          favoritesIDs: (json['favoritesIDs'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
          addressDescription: json['addressDescription'] as String,
          addressID: json['addressID'] as String,
          orderItems: (json['orderItems'] as List<Object>)
              .map((e) => OrderItem.fromJson(e))
              .toList(),
        );

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'profileImage': profileImage,
      'rating': rating,
      'aboutMe': aboutMe,
      'countOfInFavorites': countOfInFavorites,
      'magazineItems': magazineItems,
      'favoritesIDs': favoritesIDs,
      'addressDescription': addressDescription,
      'addressID': addressID,
      'orderItems': orderItems
    };
  }
}

class OrderItem {
  String id;
  OrderStatus status;

  OrderItem({this.id, this.status});

  OrderItem.fromJson(Map<String, Object> json)
      : this(
          id: json['id'] as String,
          status: OrderStatus.values
              .firstWhere((element) => element.toString() == json['status']),
        );

  Map<String, Object> toJson() {
    return {
      'id': id,
      'status': status.toString(),
    };
  }
}

class MagazineItem {
  String id;
  GoodStatus status;

  MagazineItem({this.id, this.status});

  MagazineItem.fromJson(Map<String, Object> json)
      : this(
          id: json['id'] as String,
          status: GoodStatus.values
              .firstWhere((element) => element.toString() == json['status']),
        );

  Map<String, Object> toJson() {
    return {
      'id': id,
      'status': status.toString(),
    };
  }
}
