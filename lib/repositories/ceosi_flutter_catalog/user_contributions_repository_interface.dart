import 'package:ceosi_app/models/ceosi_flutter_catalog/user_contributions_model.dart';

abstract class UserContributionsRepositoryInterface {
  Future<UserContributionsModel> getContributionsData();
}
