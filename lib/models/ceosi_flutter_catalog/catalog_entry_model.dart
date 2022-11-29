import 'dart:convert';

import 'package:ceosi_app/models/ceosi_flutter_catalog/author_model.dart';

CatalogEntryModel catalogEntryModelFromJson(String str) =>
    CatalogEntryModel.fromJson(json.decode(str));

String catalogEntryModelToJson(CatalogEntryModel data) =>
    json.encode(data.toJson());

class CatalogEntryModel {
  CatalogEntryModel({
    required this.entryData,
  });

  List<EntryDatumModel> entryData;

  factory CatalogEntryModel.fromJson(Map<String, dynamic> json) =>
      CatalogEntryModel(
        entryData: List<EntryDatumModel>.from(
            json['entry_data'].map((x) => EntryDatumModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'entry_data': List<dynamic>.from(entryData.map((x) => x.toJson())),
      };
}

class EntryDatumModel {
  EntryDatumModel({
    required this.author,
    required this.category,
    required this.createdAt,
    required this.data,
    required this.description,
    required this.entryId,
    required this.isCode,
    required this.modifiedAt,
    required this.previewUrl,
    required this.title,
  });

  AuthorModel author;
  String category;
  String createdAt;
  String data;
  String description;
  String entryId;
  bool isCode;
  String modifiedAt;
  String previewUrl;
  String title;

  factory EntryDatumModel.fromJson(Map<String, dynamic> json) =>
      EntryDatumModel(
        author: AuthorModel.fromJson(json['author']),
        category: json['category'],
        createdAt: json['created_at'],
        data: json['data'],
        description: json['description'],
        entryId: json['entry_id'],
        isCode: json['is_code'],
        modifiedAt: json['modified_at'],
        previewUrl: json['preview_url'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'author': author.toJson(),
        'category': category,
        'created_at': createdAt,
        'data': data,
        'description': description,
        'entry_id': entryId,
        'is_code': isCode,
        'modified_at': modifiedAt,
        'preview_url': previewUrl,
        'title': title,
      };
}
