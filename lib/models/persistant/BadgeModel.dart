class BadgeModel {
  String id;
  String image;
  String title;
  String description;

  BadgeModel({this.id, this.image, this.title, this.description});

  BadgeModel.fromJson(Map<String, Object> json)
      : this(
          id: json['id'] as String,
          image: json['image'] as String,
          title: json['title'] as String,
          description: json['description'] as String,
        );

  Map<String, Object> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
    };
  }
}
