class UserAnalyticModel {
  List<dynamic> earnedBadgesIDs;
  int lessCO2Value;
  int savedMassValue;
  int savedPositionsCount;

  UserAnalyticModel({this.earnedBadgesIDs, this.lessCO2Value, this.savedMassValue, this.savedPositionsCount});

  UserAnalyticModel.fromJson(Map<String, Object> json)
      : this(
          earnedBadgesIDs: json['earnedBadgesIDs'] as List<dynamic>,
          lessCO2Value: json['lessCO2Value'] as int,
          savedMassValue: json['savedMassValue'] as int,
          savedPositionsCount: json['savedPositionsCount'] as int,
        );

  Map<String, Object> toJson() {
    return {
      'earnedBadgesIDs': earnedBadgesIDs,
      'lessCO2Value': lessCO2Value,
      'savedMassValue': savedMassValue,
      'savedPositionsCount': savedPositionsCount,
    };
  }
}
