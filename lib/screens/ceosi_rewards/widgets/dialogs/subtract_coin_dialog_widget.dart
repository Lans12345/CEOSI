import 'package:ceosi_app/screens/ceosi_rewards/widgets/dialogs/error_dialog_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../constants/colors.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/text_widget.dart';
import '../../../../widgets/textformfield_widget.dart';
import '../buttons/dropdown_item_widget.dart';

// ignore: must_be_immutable
class SubractCoinDialog extends StatefulWidget {
  late String id;
  late String name;
  late String position;
  late String profileImage;

  SubractCoinDialog({
    super.key,
    required this.id,
    required this.name,
    required this.position,
    required this.profileImage,
  });

  @override
  State<SubractCoinDialog> createState() => _AddCoinDialogWidgetState();
}

class _AddCoinDialogWidgetState extends State<SubractCoinDialog> {
  final pointsEarnedController = TextEditingController();

  final commentController = TextEditingController();
  int pointsToAdd = 50;

  updateUserPoints() async {
    try {
      var collection = FirebaseFirestore.instance
          .collection('CEOSI-USERS-NEW')
          .where('id', isEqualTo: widget.id);

      var querySnapshot = await collection.get();
      late int currentUserPoints;
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            currentUserPoints = data['user_points'];
          }
        });

        if (currentUserPoints < pointsToAdd) {
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: ((context) {
                return ErrorDialog(
                    color: CustomColors.primary,
                    caption: 'Cannot Subtract Points',
                    onPressed: (() {
                      Navigator.of(context).pop();
                    }));
              }));
        } else {
          FirebaseFirestore.instance
              .collection('CEOSI-USERS-NEW')
              .doc(widget.id)
              .update({'user_points': currentUserPoints - pointsToAdd});

          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  final Stream<DocumentSnapshot> categoryData = FirebaseFirestore.instance
      .collection('CEOSI-REWARDS-UTILITIES')
      .doc('comments')
      .snapshots();

  int _dropdownValue = 0;

  String itemCategory = 'Snacks';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomColors.primary,
      child: SingleChildScrollView(
        child: SizedBox(
          height: 450,
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const BoldTextWidget(
                  color: Colors.white,
                  fontSize: 16,
                  text: 'SUBTRACTING CYBER COIN'),
              const SizedBox(
                height: 10,
              ),
              TextformfieldWidget(
                  label: 'Coin lost through',
                  isObscure: false,
                  colorFill: Colors.white,
                  textFieldController: pointsEarnedController),
              const NormalTextWidget(
                  color: Colors.white, fontSize: 14, text: 'Comment'),
              const SizedBox(
                height: 10,
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
                    List categList = data['comments'];
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)),
                        width: 300,
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
                                    itemCategory = data['comments'][i];
                                  },
                                  value: i,
                                  child:
                                      DropDownItem(label: data['comments'][i]),
                                ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _dropdownValue = int.parse(value.toString());
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: 100,
                child: NumberPicker(
                  step: 50,
                  axis: Axis.horizontal,
                  selectedTextStyle:
                      GoogleFonts.aleo(color: Colors.white, fontSize: 38),
                  textStyle:
                      GoogleFonts.aleo(color: Colors.white, fontSize: 18),
                  value: pointsToAdd,
                  minValue: 0,
                  maxValue: 1000,
                  onChanged: (value) => setState(() => pointsToAdd = value),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ButtonWidget(
                  borderRadius: 100,
                  onPressed: () {
                    if (itemCategory == '' ||
                        pointsEarnedController.text == '') {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return ErrorDialog(
                              caption: 'All fields are required',
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: CustomColors.primary,
                            );
                          }));
                    } else {
                      var newData = {
                        'name': widget.name,
                        'position': widget.position,
                        'comment': itemCategory,
                        'earned': pointsEarnedController.text,
                        'equivalent_points': pointsToAdd,
                        'profileImage': widget.profileImage,
                        'type': 'substraction',
                        'date': DateTime.now(),
                      };
                      updateUserPoints();
                      FirebaseFirestore.instance
                          .collection('CEOSI-USERS-NEW')
                          .doc(widget.id)
                          .update({
                        'earned_points': FieldValue.arrayUnion([newData])
                      });
                    }
                  },
                  buttonHeight: 50,
                  buttonWidth: 220,
                  textWidget: const BoldTextWidget(
                      color: CustomColors.primary,
                      fontSize: 18,
                      text: 'CONTINUE'),
                  color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
