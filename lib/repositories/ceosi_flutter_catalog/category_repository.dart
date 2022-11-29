import 'package:ceosi_app/models/ceosi_flutter_catalog/category_model.dart';
import 'package:ceosi_app/repositories/ceosi_flutter_catalog/category_repository_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider =
    Provider<CategoryRepository>((ref) => CategoryRepository());

class CategoryRepository implements CategoryRepositoryInterface {
  @override
  Future<CategoryModel?> getCategoryList() async {
    final data = await Future.value(CategoryModel(
      categoryList: [
        CategoryItem(
          title: 'Category 1',
          items: '8',
        ),
        CategoryItem(
          title: 'Category 2',
          items: '32',
        ),
        CategoryItem(
          title: 'Category 3',
          items: '13',
        ),
        CategoryItem(
          title: 'Category 4',
          items: '20',
        ),
        CategoryItem(
          title: 'Category 5',
          items: '9',
        ),
        CategoryItem(
          title: 'Category 6',
          items: '16',
        ),
        CategoryItem(
          title: 'Category 7',
          items: '3',
        ),
        CategoryItem(
          title: 'Category 8',
          items: '7',
        ),
      ],
    ));
    return Future.delayed(const Duration(seconds: 3), () => data);
  }
}
