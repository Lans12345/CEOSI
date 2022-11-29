import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.categoryList,
  });

  List<CategoryItem> categoryList;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryList: List<CategoryItem>.from(
            json['category_list'].map((x) => CategoryItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'category_list':
            List<dynamic>.from(categoryList.map((x) => x.toJson())),
      };
}

class CategoryItem {
  CategoryItem({
    required this.title,
    required this.items,
  });

  String title;
  String items;

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
        title: json['title'],
        items: json['items'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'items': items,
      };
}
