import 'dart:convert';

import 'package:ceosi_app/models/ceosi_flutter_catalog/author_model.dart';

UserContributionsModel userContributionsModelFromJson(String str) =>
    UserContributionsModel.fromJson(json.decode(str));

String userContributionsModelToJson(UserContributionsModel data) =>
    json.encode(data.toJson());

class UserContributionsModel {
  UserContributionsModel({
    required this.contributionData,
  });

  List<ContributionDatumModel> contributionData;

  factory UserContributionsModel.fromJson(Map<String, dynamic> json) =>
      UserContributionsModel(
        contributionData: List<ContributionDatumModel>.from(
            json['contribution_data']
                .map((x) => ContributionDatumModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'contribution_data':
            List<dynamic>.from(contributionData.map((x) => x.toJson())),
      };
}

class ContributionDatumModel {
  ContributionDatumModel({
    required this.profileId,
    required this.author,
    required this.contributions,
    required this.totalContribution,
  });

  String profileId;
  AuthorModel author;
  List<ContributionModel> contributions;
  String totalContribution;

  factory ContributionDatumModel.fromJson(Map<String, dynamic> json) =>
      ContributionDatumModel(
        profileId: json['profile_id'],
        author: AuthorModel.fromJson(json['author']),
        contributions: List<ContributionModel>.from(
            json['contributions'].map((x) => ContributionModel.fromJson(x))),
        totalContribution: json['total_contribution'],
      );

  Map<String, dynamic> toJson() => {
        'profile_id': profileId,
        'author': author.toJson(),
        'contributions':
            List<dynamic>.from(contributions.map((x) => x.toJson())),
        'total_contribution': totalContribution,
      };
}

class ContributionModel {
  ContributionModel({
    required this.entryId,
    required this.category,
    required this.title,
  });

  String entryId;
  String category;
  String title;

  factory ContributionModel.fromJson(Map<String, dynamic> json) =>
      ContributionModel(
        entryId: json['entry_id'],
        category: json['category'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'entry_id': entryId,
        'category': category,
        'title': title,
      };
}
