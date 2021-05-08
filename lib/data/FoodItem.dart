class FoodItem {
  int id;
  String image;
  String name;
  int price;
  String unit;
  double distance;
  String ownerName;
  double ownerRating;
  String ownerProfileImage;
  int bookmarksCount;
  DateTime addMoment;
  String description;
  String whereToPickUp;
  String whenToPickUp;
  DateTime expirationDate;
  bool isFree;
  bool isInBookmarks;

  FoodItem(
      this.id,
      this.image,
      this.name,
      this.price,
      this.unit,
      this.distance,
      this.ownerName,
      this.ownerRating,
      this.ownerProfileImage,
      this.bookmarksCount,
      this.addMoment,
      this.description,
      this.whereToPickUp,
      this.whenToPickUp,
      this.expirationDate,
      this.isFree,
      this.isInBookmarks);
}