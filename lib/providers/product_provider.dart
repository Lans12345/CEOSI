import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product_model.dart';
import '../repositories/product_repository.dart';

final getProductListProvider =
    FutureProvider.family<List<ProductModel>, BuildContext>(
        (ref, context) async {
  return ProductRepository().getProducts(context);
});

final getItemProvider = StateProvider<ProductModel>((ref) {
  print('called provider');
  return ProductModel();
});

final getProductId = StateProvider<String>((ref) {
  return '';
});
