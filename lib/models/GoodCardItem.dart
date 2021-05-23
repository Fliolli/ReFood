class GoodCardItem {
  String id;
  String image;
  String name;
  double price;
  String unit;
  DateTime expirationDate;
  int bookmarksCount;
  bool isFree;

  GoodCardItem(this.id, this.image, this.name, this.price, this.unit,
      this.expirationDate, this.bookmarksCount, this.isFree);
}
