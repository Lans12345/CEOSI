import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import '../../../../providers/product_provider.dart';
import '../../../../widgets/text_widget.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import '../dialogs/view_product_dialog.dart';

class SearchDelegateProduct extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query != '') {
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: Text('No Input. Cannot Procceed'),
              ),
            );
          }
        },
        icon: const Icon(
          Icons.search,
          color: Colors.blue,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
        color: Colors.grey[200],
        child: FirestoreListView(
            physics: const BouncingScrollPhysics(),
            pageSize: 10,
            errorBuilder: (context, error, stackTrace) {
              return Text(error.toString());
            },
            loadingBuilder: (context) {
              return const Center(child: CircularProgressIndicator());
            },
            itemBuilder: (context, snapshot) {
              final products = snapshot.data();
              return Consumer(
                builder: (context, ref, child) {
                  print(ref.watch(getUserPointsProvider.notifier).state);
                  print(ref.read(getUserPointsProvider.notifier).state);
                  return products['qty'] == 0
                      ? const SizedBox()
                      : ListTile(
                          tileColor: Colors.white,
                          onTap: ref
                                      .watch(getUserPointsProvider.notifier)
                                      .state ==
                                  -100
                              ? (() {
                                  ref.read(getProductId.notifier).state =
                                      products['id'];
                                  Navigator.pushNamed(
                                      context, '/rewardviewitemscreen');
                                })
                              : (() {
                                  ref
                                              .watch(getUserPointsProvider
                                                  .notifier)
                                              .state <
                                          products['points_equivalent']
                                      ? null
                                      : () {
                                          ref
                                              .read(getProductId.notifier)
                                              .state = products['id'];

                                          Navigator.pushNamed(
                                              context, '/rewardviewitemscreen');
                                        };
                                }),
                          leading: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: (ref
                                          .watch(getUserPointsProvider.notifier)
                                          .state ==
                                      -100
                                  ? () {
                                      showDialog(
                                          context: context,
                                          builder: ((context) {
                                            return ViewProductDialog(
                                                imageURL:
                                                    products['product_image']);
                                          }));
                                    }
                                  : ref
                                              .watch(getUserPointsProvider
                                                  .notifier)
                                              .state <
                                          products['points_equivalent']
                                      ? (null)
                                      : (() {
                                          showDialog(
                                              context: context,
                                              builder: ((context) {
                                                return ViewProductDialog(
                                                    imageURL: products[
                                                        'product_image']);
                                              }));
                                        })),
                              child: ref
                                          .watch(getUserPointsProvider.notifier)
                                          .state ==
                                      -100
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 10,
                                            ),
                                          ]),
                                      height: 50,
                                      width: 50,
                                      child: Image.network(
                                        products['product_image'],
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ref
                                              .watch(getUserPointsProvider
                                                  .notifier)
                                              .state <
                                          products['points_equivalent']
                                      ? Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 10,
                                                ),
                                              ]),
                                          height: 50,
                                          width: 50,
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 10,
                                                ),
                                              ]),
                                          height: 50,
                                          width: 50,
                                          child: Image.network(
                                            products['product_image'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                            ),
                          ),
                          title: BoldTextWidget(
                              color: ref
                                          .watch(getUserPointsProvider.notifier)
                                          .state ==
                                      -100
                                  ? CustomColors.primary
                                  : ref
                                              .watch(getUserPointsProvider
                                                  .notifier)
                                              .state <
                                          products['points_equivalent']
                                      ? Colors.red
                                      : CustomColors.primary,
                              fontSize: 14,
                              text: products['product_name']),
                          subtitle: NormalTextWidget(
                              color: Colors.grey,
                              fontSize: 10,
                              text:
                                  'Quantity: ${products['qty'].toString()}pcs left'),
                          trailing: BoldTextWidget(
                              color: ref
                                          .watch(getUserPointsProvider.notifier)
                                          .state ==
                                      -100
                                  ? CustomColors.primary
                                  : ref
                                              .watch(getUserPointsProvider
                                                  .notifier)
                                              .state <
                                          products['points_equivalent']
                                      ? Colors.red
                                      : CustomColors.primary,
                              fontSize: 12,
                              text: '${products['points_equivalent']}cc'));
                },
              );
            },
            query: FirebaseFirestore.instance
                .collection('CEOSI-REWARDS-ITEMS')
                .where('product_name',
                    isGreaterThanOrEqualTo: toBeginningOfSentenceCase(query))
                .where('product_name',
                    isLessThan: '${toBeginningOfSentenceCase(query)}z')));
  }
}
