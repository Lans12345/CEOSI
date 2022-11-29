import 'package:ceosi_app/models/ceosi_flutter_catalog/author_model.dart';
import 'package:ceosi_app/models/ceosi_flutter_catalog/user_contributions_model.dart';
import 'package:ceosi_app/repositories/ceosi_flutter_catalog/user_contributions_repository_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userContributionsRepositoryProvider =
    Provider<UserContributionsRepository>(
        (ref) => UserContributionsRepository());

class UserContributionsRepository
    implements UserContributionsRepositoryInterface {
  @override
  Future<UserContributionsModel> getContributionsData() async {
    final data = await Future.value(
      UserContributionsModel(
        contributionData: [
          ContributionDatumModel(
            profileId: '2BQIPInwGMgIDEDQ4Zn5',
            author: AuthorModel(
                id: 'ExyqFN6jJwgafL6E268r', name: 'June Paolo Tabequero'),
            contributions: [
              ContributionModel(
                entryId: ' YVwMpSe3ATaMjgDaOkTe',
                category: 'Conventions',
                title: 'File Structure',
              ),
              ContributionModel(
                entryId: 'MUolM97bLTsL34f7DF1W',
                category: 'Widgets',
                title: 'Text Widget',
              ),
              ContributionModel(
                entryId: 'mI6ppIGwgFdwZy7KLQxO',
                category: 'Widgets',
                title: 'Button Widget',
              )
            ],
            totalContribution: '3',
          ),
        ],
      ),
    );
    return Future.delayed(const Duration(seconds: 3), () => data);
  }
}
