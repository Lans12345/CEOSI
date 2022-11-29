import 'dart:convert';

import 'package:ceosi_app/models/ceosi_flutter_catalog/author_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CatalogEntriesModel catalogEntriesModelFromJson(String str) =>
    CatalogEntriesModel.fromJson(json.decode(str));

String catalogEntriesModelToJson(CatalogEntriesModel data) =>
    json.encode(data.toJson());

class CatalogEntriesModel {
  CatalogEntriesModel({
    required this.author,
    required this.category,
    required this.createdAt,
    required this.entryId,
    required this.modifiedAt,
    required this.title,
  });

  AuthorModel author;
  String category;
  Timestamp createdAt;
  String entryId;
  Timestamp modifiedAt;
  String title;

  factory CatalogEntriesModel.fromJson(Map<String, dynamic> json) =>
      CatalogEntriesModel(
        author: AuthorModel.fromJson(json['author']),
        category: json['category'],
        createdAt: json['created_at'],
        entryId: json['entry_id'],
        modifiedAt: json['modified_at'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'author': author.toJson(),
        'category': category,
        'created_at': createdAt,
        'entry_id': entryId,
        'modified_at': modifiedAt,
        'title': title,
      };
}
