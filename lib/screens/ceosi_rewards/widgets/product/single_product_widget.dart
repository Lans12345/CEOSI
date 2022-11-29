import 'package:ceosi_app/screens/ceosi_rewards/widgets/dialogs/error_dialog_widget.dart';
import 'package:ceosi_app/screens/ceosi_rewards/widgets/dialogs/view_product_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/icons.dart';
import '../../../../constants/uid.dart';
import '../../../../providers/product_provider.dart';
import '../../../../widgets/text_widget.dart';

// ignore: must_be_immutable
class ProductItemWidget extends ConsumerWidget {
  late String productName;
  late String productCategory;
  late int pointsEquivalent;
  late String imageURL;
  late String productId;

  late int qty;

  ProductItemWidget(
      {super.key,
      required this.productName,
      required this.productCategory,
      required this.pointsEquivalent,
      required this.imageURL,
      required this.productId,
      required this.qty});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('CEOSI-USERS-NEW')
        .doc(FirebaseAuthToken().uid)
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
        stream: userData,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Loading'));
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          dynamic data = snapshot.data;
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: GestureDetector(
              onTap: data['position'] == 'Admin'
                  ? (() {
                      ref.watch(getProductId.notifier).state = productId;
                      Navigator.pushNamed(context, '/rewardviewitemscreen');
                    })
                  : data['user_points'] < pointsEquivalent
                      ? (() {
                          showDialog(
                            context: context,
                            builder: ((context) {
                              return ErrorDialog(
                                  color: Colors.white,
                                  caption: 'Insufficient coins',
                                  onPressed: (() {
                                    Navigator.of(context).pop();
                                  }));
                            }),
                          );
                        })
                      : () async {
                          ref.watch(getProductId.notifier).state = productId;
                          Navigator.pushNamed(context, '/rewardviewitemscreen');
                        },
              child: qty == 0
                  ? const SizedBox()
                  : Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              // borderRadius: const BorderRadius.only(
                              //   bottomLeft: Radius.circular(5),
                              //   bottomRight: Radius.circular(5),
                              // ),
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  width: 5,
                                  color: data['position'] == 'Admin'
                                      ? CustomColors.primary
                                      : data['user_points'] < pointsEquivalent
                                          ? CustomColors.secondary
                                          : CustomColors.primary,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                imageURL.isEmpty
                                    ? const CircularProgressIndicator(
                                        color: CustomColors.primary,
                                      )
                                    : GestureDetector(
                                        onTap: (data['position'] == 'Admin'
                                            ? () {
                                                showDialog(
                                                    context: context,
                                                    builder: ((context) {
                                                      return ViewProductDialog(
                                                          imageURL: imageURL);
                                                    }));
                                              }
                                            : () {
                                                data['user_points'] <
                                                        pointsEquivalent
                                                    ? null
                                                    : showDialog(
                                                        context: context,
                                                        builder: ((context) {
                                                          return ViewProductDialog(
                                                              imageURL:
                                                                  imageURL);
                                                        }));
                                              }),
                                        child: Container(
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
                                            child: data['position'] == 'Admin'
                                                ? Image.network(
                                                    imageURL,
                                                    fit: BoxFit.cover,
                                                  )
                                                : data['user_points'] <
                                                        pointsEquivalent
                                                    ? null
                                                    : Image.network(
                                                        imageURL,
                                                        fit: BoxFit.cover,
                                                      )),
                                      ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 130,
                                            child: BoldTextWidget(
                                                color: Colors.black,
                                                fontSize: 12,
                                                text: productName),
                                          ),
                                          NormalTextWidget(
                                              color: Colors.black,
                                              fontSize: 10,
                                              text: '$qty pcs left'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Image.asset(
                                  CustomIcons().coinIcon,
                                  height: 22,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                BoldTextWidget(
                                    color: CustomColors.primary,
                                    fontSize: 14,
                                    text: '${pointsEquivalent}cc'),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          );
        });
  }
}
