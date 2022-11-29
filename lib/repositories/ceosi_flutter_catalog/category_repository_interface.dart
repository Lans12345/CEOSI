import 'package:ceosi_app/models/ceosi_flutter_catalog/category_model.dart';

abstract class CategoryRepositoryInterface {
  Future<CategoryModel?> getCategoryList();
}
