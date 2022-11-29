import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:ceosi_app/widgets/button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/icons.dart';
import '../../../../widgets/text_widget.dart';
import '../../../../widgets/textformfield_widget.dart';
import '../dialogs/view_product_dialog.dart';

class ProductItemWidgetAdminPanel extends ConsumerStatefulWidget {
  late String productName;
  late String productCategory;
  late int pointsEquivalent;
  late String imageURL;
  late String productId;
  late String productDescription;
  late String productDetails;
  late int qty;

  ProductItemWidgetAdminPanel(
      {super.key,
      required this.productName,
      required this.productCategory,
      required this.pointsEquivalent,
      required this.imageURL,
      required this.productId,
      required this.productDescription,
      required this.productDetails,
      required this.qty});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductState();
}

class _AddProductState extends ConsumerState<ProductItemWidgetAdminPanel> {
  final TextEditingController _reminderController = TextEditingController();
  final _detailsController = TextEditingController();
  final _coinController = TextEditingController();

  late int newQty = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: ((context) {
                return SizedBox(
                  height: 150,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  backgroundColor: CustomColors.primary,
                                  title: const Center(
                                    child: Icon(
                                      Icons.warning_rounded,
                                      color: Colors.white,
                                      size: 102,
                                    ),
                                  ),
                                  content: const NormalTextWidget(
                                      color: Colors.white,
                                      fontSize: 14,
                                      text:
                                          'Are you sure you want to delete this product?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: const NormalTextWidget(
                                          color: Colors.white,
                                          fontSize: 12,
                                          text: 'NO'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        // final preferences = await SharedPreferences.getInstance();
                                        // await preferences.clear();

                                        FirebaseFirestore.instance
                                            .collection('CEOSI-REWARDS-ITEMS')
                                            .doc(widget.productId)
                                            .delete();

                                        // ignore: use_build_context_synchronously
                                        Navigator.pushReplacementNamed(
                                            context, '/adminpanelscreenreward');
                                      },
                                      child: const NormalTextWidget(
                                          color: Colors.white,
                                          fontSize: 12,
                                          text: 'YES'),
                                    ),
                                  ],
                                );
                              }));
                        },
                        leading: const BoldTextWidget(
                            color: CustomColors.primary,
                            fontSize: 12,
                            text: 'Delete'),
                        trailing: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: ((context) {
                              return Dialog(
                                backgroundColor: CustomColors.primary,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      BoldTextWidget(
                                          color: Colors.white,
                                          fontSize: 18,
                                          text: widget.productName),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Image.network(
                                        widget.imageURL,
                                        height: 220,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const BoldTextWidget(
                                          color: Colors.white,
                                          fontSize: 14,
                                          text: 'Points Equivalent'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            50, 0, 50, 0),
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 20, 0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: TextFormField(
                                            controller: _coinController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              suffixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Image.asset(
                                                  'assets/icons/coin.png',
                                                  height: 15,
                                                ),
                                              ),
                                              hintText: widget.pointsEquivalent
                                                  .toString(),
                                              hintStyle: const TextStyle(
                                                  color: CustomColors.primary,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 24),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const BoldTextWidget(
                                          color: Colors.white,
                                          fontSize: 14,
                                          text: 'Product Detail'),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: TextformfieldWidget(
                                            label: widget.productDetails,
                                            textFieldController:
                                                _detailsController),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const BoldTextWidget(
                                          color: Colors.white,
                                          fontSize: 14,
                                          text: 'Reminder'),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: TextformfieldWidget(
                                            label: widget.productDescription,
                                            textFieldController:
                                                _reminderController),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: ButtonWidget(
                                          borderRadius: 100,
                                          color: Colors.white,
                                          onPressed: (() {
                                            FirebaseFirestore.instance
                                                .collection(
                                                    'CEOSI-REWARDS-ITEMS')
                                                .doc(widget.productId)
                                                .update({
                                              'points_equivalent':
                                                  _coinController.text == ''
                                                      ? widget.pointsEquivalent
                                                      : int.parse(
                                                          _coinController.text),
                                              'product_details':
                                                  _detailsController.text == ''
                                                      ? widget.productDetails
                                                      : _detailsController.text,
                                              'reminders': _reminderController
                                                          .text ==
                                                      ''
                                                  ? widget.productDescription
                                                  : _reminderController.text,
                                            });
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          }),
                                          buttonHeight: 50,
                                          buttonWidth: 300,
                                          textWidget: const BoldTextWidget(
                                              color: CustomColors.primary,
                                              fontSize: 18,
                                              text: 'Continue'),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                        leading: const BoldTextWidget(
                          color: CustomColors.primary,
                          fontSize: 12,
                          text: 'Edit',
                        ),
                        trailing: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                );
              }));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  width: 5,
                  color: CustomColors.primary,
                ),
              ),
            ),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  const VerticalDivider(
                    color: CustomColors.primary,
                    width: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: (() {
                          if (newQty > 1) {
                            setState(() {
                              newQty--;
                            });
                          }
                        }),
                        icon: const Icon(Icons.remove),
                      ),
                      BoldTextWidget(
                          color: CustomColors.primary,
                          fontSize: 32,
                          text: newQty.toString()),
                      IconButton(
                        onPressed: (() {
                          setState(() {
                            newQty++;
                          });
                        }),
                        icon: const Icon(Icons.add),
                      ),
                      IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('CEOSI-REWARDS-ITEMS')
                                .doc(widget.productId)
                                .update({'qty': widget.qty + newQty});

                            setState(() {
                              newQty = 1;
                            });

                            AnimatedSnackBar.rectangle(
                              duration: const Duration(seconds: 1),
                              'Update Status:',
                              'Product Quantity updated succesfully!',
                              type: AnimatedSnackBarType.success,
                              brightness: Brightness.light,
                            ).show(
                              context,
                            );
                          },
                          icon: const Icon(
                            Icons.check_box,
                            color: CustomColors.primary,
                          )),
                    ],
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: (() {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return ViewProductDialog(imageURL: widget.imageURL);
                          }));
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                            ),
                          ]),
                      height: 50,
                      width: 50,
                      child: Image.network(
                        widget.imageURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 130,
                              child: BoldTextWidget(
                                  color: Colors.black,
                                  fontSize: 12,
                                  text: widget.productName),
                            ),
                            NormalTextWidget(
                                color: Colors.black,
                                fontSize: 10,
                                text: 'Quantity: ${widget.qty}pcs left'),
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
                      text: '${widget.pointsEquivalent}cc'),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
