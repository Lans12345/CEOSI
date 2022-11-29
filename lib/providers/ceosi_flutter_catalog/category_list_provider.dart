import 'package:ceosi_app/models/ceosi_flutter_catalog/category_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repositories/ceosi_flutter_catalog/category_repository.dart';

final categoryListFutureProvider = FutureProvider<CategoryModel?>(
  (ref) async {
    return ref.watch(categoryRepositoryProvider).getCategoryList();
  },
);

class CategoryListNotifier extends StateNotifier<AsyncValue<CategoryModel?>> {
  CategoryListNotifier(
    this.ref, [
    AsyncValue<CategoryModel>? categoryList,
  ]) : super(categoryList ?? const AsyncValue.loading()) {
    _getCategoryList();
  }

  final Ref ref;

  void _getCategoryList() {
    final categoryList = ref.watch(categoryListFutureProvider);
    state = categoryList;
  }
}

final categoryListStateNotifierProvider = StateNotifierProvider.autoDispose<
    CategoryListNotifier, AsyncValue<CategoryModel?>>(
  (ref) {
    return CategoryListNotifier(ref);
  },
);
