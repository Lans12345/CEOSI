import 'package:ceosi_app/models/ceosi_flutter_catalog/user_contributions_model.dart';
import 'package:ceosi_app/repositories/ceosi_flutter_catalog/user_contributions_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userContributionsFutureProvider = FutureProvider<UserContributionsModel?>(
  (ref) async {
    return ref
        .watch(userContributionsRepositoryProvider)
        .getContributionsData();
  },
);

class UserContributionsNotifier
    extends StateNotifier<AsyncValue<UserContributionsModel?>> {
  UserContributionsNotifier(
    this.ref, [
    AsyncValue<UserContributionsModel>? contributionData,
  ]) : super(contributionData ?? const AsyncValue.loading()) {
    _getContributionData();
  }

  final Ref ref;

  void _getContributionData() {
    final contributionData = ref.watch(userContributionsFutureProvider);
    state = contributionData;
  }
}

final userContributionsStateNotifierProvider =
    StateNotifierProvider.autoDispose<UserContributionsNotifier,
        AsyncValue<UserContributionsModel?>>(
  (ref) {
    return UserContributionsNotifier(ref);
  },
);
