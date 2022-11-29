import 'dart:convert';

import 'package:ceosi_app/repositories/product_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductRepository implements ProductRepositoryInterface {
  @override
  Future<List<ProductModel>> getProducts(BuildContext context) async {
    print('called');
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/products.json');
    final body = json.decode(data);

    return body.map<ProductModel>(ProductModel.fromJson).toList();
  }

  Future addItem(
      String? productName,
      String? productCategory,
      int? pointsEquivalent,
      String? productImage,
      String? productDetails,
      String? reminders,
      int? qty) async {
    final docUser =
        FirebaseFirestore.instance.collection('CEOSI-REWARDS-ITEMS').doc();

    final json = {
      'product_name': productName ?? 'Not specified',
      'product_category': productCategory ?? 'Not specified',
      'points_equivalent': pointsEquivalent ?? 0,
      'product_image': productImage ??
          'https://gdm-catalog-fmapi-prod.imgix.net/ProductScreenshot/60dbe92f-b6fb-4a2a-bd3c-6bef787a1aba.png',
      'product_details': productDetails ?? 'Not specified',
      'reminders': reminders ?? 'Not specified',
      'id': docUser.id,
      'date': DateTime.now(),
      'qty': qty
    };

    await docUser.set(json);
  }

  @override
  Future addItemClaimed(
    String? productName,
    String? productCategory,
    int? pointsEquivalent,
    String? productImage,
    String? userEmail,
  ) async {
    final docUser = FirebaseFirestore.instance
        .collection('CEOSI-REWARDS-ITEMS-CLAIMED')
        .doc();

    final json = {
      'product_name': productName ?? 'Not specified',
      'product_category': productCategory ?? 'Not specified',
      'points_equivalent': pointsEquivalent ?? 0,
      'product_image': productImage ?? 'Not specified',
      'id': docUser.id,
      'email': userEmail ?? 'Not specified',
      'date': DateTime.now(),
    };

    await docUser.set(json);
  }
}
