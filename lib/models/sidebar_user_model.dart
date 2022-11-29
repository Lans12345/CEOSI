import 'dart:convert';

SidebarUserModel sidebarUserModelFromJson(String str) =>
    SidebarUserModel.fromJson(json.decode(str));

String sidebarUserModelToJson(SidebarUserModel data) =>
    json.encode(data.toJson());

class SidebarUserModel {
  SidebarUserModel({
    required this.id,
    required this.name,
    required this.position,
    required this.profileImage,
  });

  String id;
  String name;
  String position;
  String profileImage;

  factory SidebarUserModel.fromJson(Map<String, dynamic> json) =>
      SidebarUserModel(
        id: json['id'],
        name: json['name'],
        position: json['position'],
        profileImage: json['profile_image'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'position': position,
        'profile_image': profileImage,
      };
}
