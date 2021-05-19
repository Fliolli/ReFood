class FoodModel {
  String id;
  final String image;
  final String name;
  final double price;
  final String unit;
  final String ownerID;
  final int bookmarksCount;
  final DateTime addMoment;
  final String description;
  final String whereToPickUp;
  final String whenToPickUp;
  final DateTime expirationDate;
  final double mass;

  FoodModel(
      {this.id,
      this.image,
      this.name,
      this.price,
      this.unit,
      this.ownerID,
      this.bookmarksCount,
      this.addMoment,
      this.description,
      this.whereToPickUp,
      this.whenToPickUp,
      this.expirationDate,
      this.mass});

  FoodModel.fromJson(Map<String, Object> json)
      : this(
          id: json['id'] as String,
          image: json['image'] as String,
          name: json['name'] as String,
          price: json['price'] as double,
          unit: json['unit'] as String,
          ownerID: json['ownerID'] as String,
          bookmarksCount: json['bookmarksCount'] as int,
          addMoment: json['addMoment'] as DateTime,
          description: json['description'] as String,
          whereToPickUp: json['whereToPickUp'] as String,
          whenToPickUp: json['whenToPickUp'] as String,
          expirationDate: json['expirationDate'] as DateTime,
          mass: json['mass'] as double,
        );

  Map<String, Object> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'price': price,
      'unit': unit,
      'ownerID': ownerID,
      'bookmarksCount': bookmarksCount,
      'addMoment': addMoment,
      'description': description,
      'whereToPickUp': whereToPickUp,
      'whenToPickUp': whenToPickUp,
      'expirationDate': expirationDate,
      'mass': mass,
    };
  }
}
