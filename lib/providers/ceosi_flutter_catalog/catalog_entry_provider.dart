import 'package:ceosi_app/models/ceosi_flutter_catalog/catalog_entry_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repositories/ceosi_flutter_catalog/catalog_entry_repository.dart';

final catalogEntryFutureProvider = FutureProvider<CatalogEntryModel?>(
  (ref) async {
    return ref.watch(catalogEntryRepositoryProvider).getEntryData();
  },
);

class CatalogEntryNotifier
    extends StateNotifier<AsyncValue<CatalogEntryModel?>> {
  CatalogEntryNotifier(
    this.ref, [
    AsyncValue<CatalogEntryModel>? entryData,
  ]) : super(entryData ?? const AsyncValue.loading()) {
    _getEntryData();
  }

  final Ref ref;

  void _getEntryData() {
    final entryData = ref.watch(catalogEntryFutureProvider);
    state = entryData;
  }
}

final catalogEntryStateNotifierProvider = StateNotifierProvider.autoDispose<
    CatalogEntryNotifier, AsyncValue<CatalogEntryModel?>>(
  (ref) {
    return CatalogEntryNotifier(ref);
  },
);
