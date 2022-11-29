import 'package:ceosi_app/providers/product_provider.dart';
import 'package:ceosi_app/screens/ceosi_rewards/widgets/dialogs/error_dialog_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import 'widgets/dialogs/claim_reward_dialog_widget.dart';

class RewardViewItemScreen extends ConsumerWidget {
  const RewardViewItemScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('CEOSI-REWARDS-ITEMS')
        .doc(ref.watch(getProductId.notifier).state)
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot>(
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
            return Center(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Image.network(
                        data['product_image'],
                        height: 280,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BoldTextWidget(
                          textAlign: TextAlign.center,
                          color: Colors.black,
                          fontSize: 24,
                          text: data['product_name']),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: CustomColors.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: const NormalTextWidget(
                                          color: Colors.white,
                                          fontSize: 14,
                                          text: 'Quantity'),
                                      trailing: NormalTextWidget(
                                          color: Colors.white,
                                          fontSize: 12,
                                          text: "${data['qty']}pcs left"),
                                    ),
                                    ListTile(
                                      leading: const NormalTextWidget(
                                          color: Colors.white,
                                          fontSize: 14,
                                          text: 'Points Equivalent'),
                                      trailing: NormalTextWidget(
                                          color: Colors.white,
                                          fontSize: 12,
                                          text:
                                              "${data['points_equivalent']}cc"),
                                    ),
                                    const Divider(
                                      color: Colors.white,
                                    ),
                                    const NormalTextWidget(
                                        color: Colors.white,
                                        fontSize: 18,
                                        text: 'Details'),
                                    NormalTextWidget(
                                        color: Colors.white,
                                        fontSize: 12,
                                        text: data['product_details']),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const NormalTextWidget(
                                        color: Colors.white,
                                        fontSize: 18,
                                        text: 'Reminders'),
                                    NormalTextWidget(
                                        color: Colors.white,
                                        fontSize: 12,
                                        text: data['reminders']),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Center(
                                      child: ButtonWidget(
                                          color: Colors.white,
                                          borderRadius: 100,
                                          onPressed: () {
                                            if (data['qty'] < 1) {
                                              showDialog(
                                                  context: context,
                                                  builder: ((context) {
                                                    return ErrorDialog(
                                                        color: CustomColors
                                                            .secondary,
                                                        caption: 'Out of stock',
                                                        onPressed: (() {
                                                          Navigator.of(context)
                                                              .pop();
                                                        }));
                                                  }));
                                            } else {
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return ClaimRewardDialogWidget(
                                                      productName:
                                                          data['product_name'],
                                                      pointsEquivalent: data[
                                                          'points_equivalent'],
                                                      productCategory: data[
                                                          'product_category'],
                                                      productImage:
                                                          data['product_image'],
                                                      productId: data['id'],
                                                      qty: data['qty'],
                                                    );
                                                  });
                                            }
                                          },
                                          buttonHeight: 50,
                                          buttonWidth: 300,
                                          textWidget: const BoldTextWidget(
                                              color: CustomColors.primary,
                                              fontSize: 18,
                                              text: 'Claim Reward')),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_circle_left_rounded,
                          color: CustomColors.primary,
                        )),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
