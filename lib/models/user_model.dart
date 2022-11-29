// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    required this.id,
    required this.userId,
    required this.email,
    required this.name,
    required this.profileImage,
    required this.position,
    required this.anonName,
    required this.created,
    required this.points,
    required this.contributions,
    required this.claimedRewards,
    required this.earnedPoints,
  });

  String id;
  String userId;
  String email;
  String name;
  String profileImage;
  String position;
  String anonName;
  int points;
  int contributions;
  List<ClaimedReward> claimedRewards;
  List<EarnedPoints> earnedPoints;
  DateTime created;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        userId: json['user_id'],
        email: json['email'],
        name: json['name'],
        created: json['created'],
        profileImage: json['profile_image'],
        position: json['position'],
        anonName: json['anon_name'],
        points: json['points'],
        contributions: json['contributions'],
        claimedRewards: List<ClaimedReward>.from(
            json['claimed_rewards'].map((x) => ClaimedReward.fromJson(x))),
        earnedPoints: List<EarnedPoints>.from(
            json['earned_points'].map((x) => ClaimedReward.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'email': email,
        'name': name,
        'profile_image': profileImage,
        'position': position,
        'created': created,
        'anon_name': anonName,
        'points': points,
        'contributions': contributions,
        'claimed_rewards':
            List<dynamic>.from(claimedRewards.map((x) => x.toJson())),
        'earned_points': List<dynamic>.from(earnedPoints.map((x) => x.toJson()))
      };
}

class ClaimedReward {
  ClaimedReward();

  factory ClaimedReward.fromJson(Map<String, dynamic> json) => ClaimedReward();

  Map<String, dynamic> toJson() => {};
}

class EarnedPoints {
  EarnedPoints();

  factory EarnedPoints.fromJson(Map<String, dynamic> json) => EarnedPoints();

  Map<String, dynamic> toJson() => {};
}
