import 'package:ceosi_app/screens/ceosi_rewards/widgets/product/admin_single_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../buttons/dropdown_item_widget.dart';

// ignore: must_be_immutable
class ProductListWidgetAdminPanel extends StatefulWidget {
  const ProductListWidgetAdminPanel({super.key});

  @override
  State<ProductListWidgetAdminPanel> createState() =>
      _ProductListWidgetAdminPanelState();
}

class _ProductListWidgetAdminPanelState
    extends State<ProductListWidgetAdminPanel> {
  int _dropdownValue = 0;

  String itemCategory = 'Snacks';

  final Stream<DocumentSnapshot> categoryData = FirebaseFirestore.instance
      .collection('CEOSI-REWARDS-UTILITIES')
      .doc('categories')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<DocumentSnapshot>(
              stream: categoryData,
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: Text('Loading'));
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                dynamic data = snapshot.data;
                List categList = data['category'];
                return Container(
                  width: 350,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                    child: DropdownButton(
                      underline: Container(color: Colors.transparent),
                      iconEnabledColor: Colors.black,
                      isExpanded: true,
                      value: _dropdownValue,
                      items: [
                        for (int i = 0; i < categList.length; i++)
                          DropdownMenuItem(
                            onTap: () {
                              itemCategory = data['category'][i];
                            },
                            value: i,
                            child: DropDownItem(label: data['category'][i]),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _dropdownValue = int.parse(value.toString());
                        });
                      },
                    ),
                  ),
                );
              }),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SizedBox(
              child: FirestoreListView(
                  pageSize: 10,
                  loadingBuilder: (context) {
                    return const CircularProgressIndicator();
                  },
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, snapshot) {
                    final products = snapshot.data();
                    return ProductItemWidgetAdminPanel(
                      productName: products['product_name'],
                      productCategory: products['product_category'],
                      pointsEquivalent: products['points_equivalent'],
                      imageURL: products['product_image'],
                      productId: products['id'],
                      productDescription: products['reminders'],
                      productDetails: products['product_details'],
                      qty: products['qty'],
                    );
                  },
                  query: FirebaseFirestore.instance
                      .collection('CEOSI-REWARDS-ITEMS')
                      .where('product_category', isEqualTo: itemCategory)
                      .orderBy('date')),
            ),
          ),
        ],
      ),
    );
  }
}
