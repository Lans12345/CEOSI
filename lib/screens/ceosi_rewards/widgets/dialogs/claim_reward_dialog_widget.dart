import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/uid.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/text_widget.dart';

// ignore: must_be_immutable
class ClaimRewardDialogWidget extends StatefulWidget {
  late String productName;
  late String productCategory;
  late String productImage;
  late int pointsEquivalent;
  late String productId;
  late int qty;

  ClaimRewardDialogWidget(
      {super.key,
      required this.productName,
      required this.productCategory,
      required this.productImage,
      required this.pointsEquivalent,
      required this.productId,
      required this.qty});

  @override
  State<ClaimRewardDialogWidget> createState() =>
      _ClaimRewardDialogWidgetState();
}

class _ClaimRewardDialogWidgetState extends State<ClaimRewardDialogWidget> {
  @override
  Widget build(BuildContext context) {
    var newData = {
      'product_name': widget.productName,
      'product_category': widget.productCategory,
      'product_image': widget.productImage,
      'points_equivalent': widget.pointsEquivalent,
      'date': DateTime.now(),
    };

    addItemToList(WidgetRef ref) {
      FirebaseFirestore.instance
          .collection('CEOSI-USERS-NEW')
          .doc(FirebaseAuthToken().uid)
          .update({
        'claimed_rewards': FieldValue.arrayUnion([newData])
      });
    }

    updateUserPoints(WidgetRef ref) async {
      var collection = FirebaseFirestore.instance
          .collection('CEOSI-USERS-NEW')
          .where('id', isEqualTo: FirebaseAuthToken().uid);

      var querySnapshot = await collection.get();
      late int currentUserPoints;
      late String position;
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            currentUserPoints = data['user_points'];
            position = data['position'];
          }
        });

        if (position != 'Admin') {
          FirebaseFirestore.instance
              .collection('CEOSI-USERS-NEW')
              .doc(FirebaseAuthToken().uid)
              .update(
                  {'user_points': currentUserPoints - widget.pointsEquivalent});
        }
      }
    }

    return Dialog(
      backgroundColor: CustomColors.primary,
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 370,
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: (() {
                    Navigator.of(context).pop();
                  }),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
            ),
            const BoldTextWidget(
                color: Colors.white, fontSize: 18, text: 'ITEM CLAIMED!'),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/icons/check.png',
              height: 120,
            ),
            const SizedBox(
              height: 40,
            ),
            Consumer(
              builder: (context, ref, child) {
                return ButtonWidget(
                    borderRadius: 100,
                    onPressed: () async {
                      addItemToList(ref);
                      updateUserPoints(ref);

                      FirebaseFirestore.instance
                          .collection('CEOSI-REWARDS-ITEMS')
                          .doc(widget.productId)
                          .update({'qty': widget.qty - 1});

                      Navigator.pushNamed(context, '/rewardhomescreen');
                      AnimatedSnackBar.rectangle(
                        duration: const Duration(seconds: 1),
                        'Claimed Succesfully!',
                        'You may now claim your reward',
                        type: AnimatedSnackBarType.success,
                        brightness: Brightness.light,
                      ).show(
                        context,
                      );
                    },
                    buttonHeight: 50,
                    buttonWidth: 220,
                    textWidget: const BoldTextWidget(
                        color: CustomColors.primary,
                        fontSize: 18,
                        text: 'Continue'),
                    color: Colors.white);
              },
            )
          ],
        ),
      ),
    );
  }
}
