// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    this.productName,
    this.productCategory,
    this.pointsEquivalent,
    this.productImage,
  });

  String? productName;
  String? productCategory;
  String? pointsEquivalent;
  String? productImage;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productName: json['productName'],
        productCategory: json['productCategory'],
        pointsEquivalent: json['pointsEquivalent'],
        productImage: json['productImage'],
      );

  Map<String, dynamic> toJson() => {
        'productName': productName,
        'productCategory': productCategory,
        'pointsEquivalent': pointsEquivalent,
        'productImage': productImage,
      };
}
