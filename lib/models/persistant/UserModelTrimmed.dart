import 'UserModel.dart';

class UserModelTrimmed {
  String id;
  String name;
  String profileImage;
  double rating;

  UserModelTrimmed({
    this.id,
    this.name,
    this.profileImage,
    this.rating,
  });

  UserModelTrimmed.fromUser(UserModel user)
      : this(
          id: user.id,
          name: user.name,
          profileImage: user.profileImage,
          rating: user.rating,
        );
}
