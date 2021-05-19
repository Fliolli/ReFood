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

  UserModel({
      this.id,
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
          magazineItems: json['magazineItems'] as List<MagazineItem>,
          favoritesIDs: json['favoritesIDs'] as List<String>,
          addressDescription: json['addressDescription'] as String,
          addressID: json['addressID'] as String,
          orderItems: json['orderItems'] as List<OrderItem>,
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
  String _id;
  int _mark;
  String _status;

  OrderItem(this._id, this._mark, this._status);
}

class MagazineItem {
  String _id;
  String _status;

  MagazineItem(this._id, this._status);
}
