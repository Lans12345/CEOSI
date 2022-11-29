import 'dart:convert';

AuthorModel authorModelFromJson(String str) =>
    AuthorModel.fromJson(json.decode(str));

String authorModelToJson(AuthorModel data) => json.encode(data.toJson());

class AuthorModel {
  AuthorModel({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory AuthorModel.fromJson(Map<String, dynamic> json) => AuthorModel(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
