import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/screens/ceosi_rewards/widgets/drawer_widget.dart';
import 'package:ceosi_app/widgets/button_widget.dart';
import 'package:ceosi_app/widgets/textformfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../widgets/text_widget.dart';

class ConfigScreen extends StatelessWidget {
  final Stream<DocumentSnapshot> categData = FirebaseFirestore.instance
      .collection('CEOSI-REWARDS-UTILITIES')
      .doc('categories')
      .snapshots();

  final Stream<DocumentSnapshot> commentData = FirebaseFirestore.instance
      .collection('CEOSI-REWARDS-UTILITIES')
      .doc('comments')
      .snapshots();

  final categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: const DrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomColors.primary,
        title: const BoldTextWidget(
            color: Colors.white, fontSize: 18, text: 'CONFIGURATIONS'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BoldTextWidget(
                            color: CustomColors.primary,
                            fontSize: 18,
                            text: 'Product Category'),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: MaterialButton(
                            color: CustomColors.primary,
                            onPressed: (() {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return Dialog(
                                      backgroundColor: CustomColors.primary,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 20, 10, 20),
                                        child: SizedBox(
                                          height: 250,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const SizedBox(),
                                                  IconButton(
                                                    onPressed: (() {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                    icon: const Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              TextformfieldWidget(
                                                  label: 'Category name',
                                                  textFieldController:
                                                      categoryController),
                                              const SizedBox(
                                                height: 50,
                                              ),
                                              ButtonWidget(
                                                borderRadius: 100,
                                                color: Colors.white,
                                                onPressed: (() {
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'CEOSI-REWARDS-UTILITIES')
                                                      .doc('categories')
                                                      .update({
                                                    'category':
                                                        FieldValue.arrayUnion([
                                                      categoryController.text
                                                    ])
                                                  });

                                                  Navigator.of(context).pop();

                                                  categoryController.clear();

                                                  AnimatedSnackBar.rectangle(
                                                    duration: const Duration(
                                                        seconds: 1),
                                                    'Update Status:',
                                                    'Category added succesfully!',
                                                    type: AnimatedSnackBarType
                                                        .success,
                                                    brightness:
                                                        Brightness.light,
                                                  ).show(
                                                    context,
                                                  );
                                                }),
                                                buttonHeight: 50,
                                                buttonWidth: 200,
                                                textWidget:
                                                    const BoldTextWidget(
                                                        color: CustomColors
                                                            .primary,
                                                        fontSize: 12,
                                                        text: 'CONTINUE'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }));
                            }),
                            child: const NormalTextWidget(
                                color: Colors.white,
                                fontSize: 14,
                                text: '+ Add'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: categData,
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(child: Text('Loading'));
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text('Something went wrong'));
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          dynamic data = snapshot.data;
                          List categList = data['category'];
                          return Expanded(
                            child: SizedBox(
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  for (int i = 0; i < categList.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 10),
                                      child: ListTile(
                                        tileColor: Colors.white,
                                        leading: BoldTextWidget(
                                            color: CustomColors.primary,
                                            fontSize: 14,
                                            text: categList[i]),
                                        trailing: IconButton(
                                          onPressed: (() {
                                            showDialog(
                                                context: context,
                                                builder: ((context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        CustomColors.primary,
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
                                                            'Are you sure you want to delete this category?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const NormalTextWidget(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                text: 'NO'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          // final preferences = await SharedPreferences.getInstance();
                                                          // await preferences.clear();

                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'CEOSI-REWARDS-UTILITIES')
                                                              .doc('categories')
                                                              .update({
                                                            'category': FieldValue
                                                                .arrayRemove([
                                                              categList[i]
                                                            ])
                                                          }).whenComplete(() {
                                                            print(
                                                                'Field Deleted');
                                                          });

                                                          // ignore: use_build_context_synchronously
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const NormalTextWidget(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                text: 'YES'),
                                                      ),
                                                    ],
                                                  );
                                                }));
                                          }),
                                          icon: const Icon(
                                            Icons.delete,
                                            color: CustomColors.secondary,
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BoldTextWidget(
                            color: CustomColors.primary,
                            fontSize: 18,
                            text: 'Comment List'),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: MaterialButton(
                            color: CustomColors.primary,
                            onPressed: (() {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return Dialog(
                                      backgroundColor: CustomColors.primary,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 20, 10, 20),
                                        child: SizedBox(
                                          height: 250,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const SizedBox(),
                                                  IconButton(
                                                    onPressed: (() {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                    icon: const Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              TextformfieldWidget(
                                                  label: 'Comment type',
                                                  textFieldController:
                                                      categoryController),
                                              const SizedBox(
                                                height: 50,
                                              ),
                                              ButtonWidget(
                                                borderRadius: 100,
                                                color: Colors.white,
                                                onPressed: (() {
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'CEOSI-REWARDS-UTILITIES')
                                                      .doc('comments')
                                                      .update({
                                                    'comments':
                                                        FieldValue.arrayUnion([
                                                      categoryController.text
                                                    ])
                                                  });

                                                  Navigator.of(context).pop();

                                                  categoryController.clear();

                                                  AnimatedSnackBar.rectangle(
                                                    duration: const Duration(
                                                        seconds: 1),
                                                    'Update Status:',
                                                    'Category added succesfully!',
                                                    type: AnimatedSnackBarType
                                                        .success,
                                                    brightness:
                                                        Brightness.light,
                                                  ).show(
                                                    context,
                                                  );
                                                }),
                                                buttonHeight: 50,
                                                buttonWidth: 200,
                                                textWidget:
                                                    const BoldTextWidget(
                                                        color: CustomColors
                                                            .primary,
                                                        fontSize: 12,
                                                        text: 'CONTINUE'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }));
                            }),
                            child: const NormalTextWidget(
                                color: Colors.white,
                                fontSize: 14,
                                text: '+ Add'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: commentData,
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(child: Text('Loading'));
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text('Something went wrong'));
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          dynamic data = snapshot.data;
                          List commentList = data['comments'];
                          return Expanded(
                            child: SizedBox(
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  for (int i = 0; i < commentList.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 10),
                                      child: ListTile(
                                        tileColor: Colors.white,
                                        leading: BoldTextWidget(
                                            color: CustomColors.primary,
                                            fontSize: 14,
                                            text: commentList[i]),
                                        trailing: IconButton(
                                          onPressed: (() {
                                            showDialog(
                                                context: context,
                                                builder: ((context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        CustomColors.primary,
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
                                                            'Are you sure you want to delete this category?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const NormalTextWidget(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                text: 'NO'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          // final preferences = await SharedPreferences.getInstance();
                                                          // await preferences.clear();

                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'CEOSI-REWARDS-UTILITIES')
                                                              .doc('comments')
                                                              .update({
                                                            'comments': FieldValue
                                                                .arrayRemove([
                                                              commentList[i]
                                                            ])
                                                          }).whenComplete(() {
                                                            print(
                                                                'Field Deleted');
                                                          });

                                                          // ignore: use_build_context_synchronously
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const NormalTextWidget(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                text: 'YES'),
                                                      ),
                                                    ],
                                                  );
                                                }));
                                          }),
                                          icon: const Icon(
                                            Icons.delete,
                                            color: CustomColors.secondary,
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
