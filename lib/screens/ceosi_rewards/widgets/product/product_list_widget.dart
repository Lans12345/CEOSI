import 'package:ceosi_app/screens/ceosi_rewards/widgets/product/single_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

// ignore: must_be_immutable
class ProductListWidget extends StatelessWidget {
  late String query;

  ProductListWidget({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FirestoreListView(
          physics: const BouncingScrollPhysics(),
          pageSize: 10,
          errorBuilder: (context, error, stackTrace) {
            return Text(error.toString());
          },
          loadingBuilder: (context) {
            return const CircularProgressIndicator();
          },
          itemBuilder: (context, snapshot) {
            final products = snapshot.data();
            return ProductItemWidget(
              productName: products['product_name'],
              productCategory: products['product_category'],
              pointsEquivalent: products['points_equivalent'],
              imageURL: products['product_image'],
              productId: products['id'],
              qty: products['qty'],
            );
          },
          query: FirebaseFirestore.instance
              .collection('CEOSI-REWARDS-ITEMS')
              .where('product_category', isEqualTo: query)
              .orderBy('date')),
    );
  }
}
