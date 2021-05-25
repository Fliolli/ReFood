class UserAnalyticModel {
  List<dynamic> earnedBadgesIDs;
  double lessCO2Value;
  double savedMassValue;
  int savedPositionsCount;

  UserAnalyticModel({this.earnedBadgesIDs, this.lessCO2Value, this.savedMassValue, this.savedPositionsCount});

  UserAnalyticModel.fromJson(Map<String, Object> json)
      : this(
          earnedBadgesIDs: json['earnedBadgesIDs'] as List<dynamic>,
          lessCO2Value: double.parse(json['lessCO2Value'].toString()),
          savedMassValue: double.parse(json['savedMassValue'].toString()),
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
