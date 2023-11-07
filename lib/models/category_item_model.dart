class CategoryItemModel {
  late int iconCodePoint;

  late String iconFontPackage;

  late String iconFontFamily;

  late String text;

  late String description;

  CategoryItemModel({
    this.iconCodePoint = 0,
    this.iconFontPackage = '',
    this.iconFontFamily = '',
    this.text = '',
    this.description = '',
  });

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) {
    return CategoryItemModel(
      iconCodePoint: json['iconCodePoint'],
      iconFontPackage: json['iconFontPackage'],
      iconFontFamily: json['iconFontFamily'],
      text: json['text'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iconCodePoint': iconCodePoint,
      'iconFontPackage': iconFontPackage,
      'iconFontFamily': iconFontFamily,
      'text': text,
      'description': description,
    };
  }
}
