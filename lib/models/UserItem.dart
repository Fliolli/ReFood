import 'package:flutter_test_app/models/BadgeItem.dart';
import 'package:flutter_test_app/widgets/OrderCardItem.dart';

class UserItem{
  int id;
  String ownerName;
  String ownerProfileImage;
  double ownerRating;
  String aboutMe;
  bool isInFavorites;
  int countOfInFavorites;
  List<BadgeItem> badges;
  List<OrderCardItem> magazineItems;
  int savedPositions;
  int savedMass;
  int lessCO2;

  UserItem(
      this.id,
      this.ownerName,
      this.ownerProfileImage,
      this.ownerRating,
      this.aboutMe,
      this.isInFavorites,
      this.countOfInFavorites,
      this.badges,
      this.magazineItems,
      this.savedPositions,
      this.savedMass,
      this.lessCO2);
}