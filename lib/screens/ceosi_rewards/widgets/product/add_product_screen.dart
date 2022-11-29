import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/widgets/number_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

import '../../../../repositories/product_repository.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/text_widget.dart';
import '../../../../widgets/textformfield_widget.dart';
import '../buttons/dropdown_item_widget.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  int _dropdownValue = 0;

  String itemCategory = 'Snacks';

  late File imageFile;

  late String fileName;
  int qty = 1;

  final _remindersController = TextEditingController();

  final _detailsController = TextEditingController();
  late var itemNameController = TextEditingController();
  late var pointsEqualController = TextEditingController();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  bool hasLoaded = false;

  late String imageURL;

  final Stream<DocumentSnapshot> categoryData = FirebaseFirestore.instance
      .collection('CEOSI-REWARDS-UTILITIES')
      .doc('categories')
      .snapshots();

  Future<void> uploadPicture(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      fileName = path.basename(pickedImage.path);
      imageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: const [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QRegular'),
                ),
              ],
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('Rewards/Items/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Rewards/Items/$fileName')
            .getDownloadURL();

        setState(() {
          hasLoaded = true;
        });

        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        // ignore: use_build_context_synchronously

      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Widget uploadSelection() {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              uploadPicture('camera');
            },
            leading: const BoldTextWidget(
                color: CustomColors.primary, fontSize: 12, text: 'Camera'),
            trailing: const Icon(
              Icons.camera,
              color: CustomColors.primary,
            ),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              uploadPicture('gallery');
            },
            leading: const BoldTextWidget(
                color: CustomColors.primary, fontSize: 12, text: 'Gallery'),
            trailing: const Icon(
              Icons.photo_rounded,
              color: CustomColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: CustomColors.primary,
        title: const BoldTextWidget(
            color: Colors.white, fontSize: 24, text: 'Add Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            hasLoaded
                ? GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((context) {
                          return uploadSelection();
                        }),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              imageURL,
                            ),
                            fit: BoxFit.cover),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: CustomColors.primary,
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((context) {
                          return uploadSelection();
                        }),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: CustomColors.primary,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: (() {
                    if (qty > 1) {
                      setState(() {
                        qty--;
                      });
                    }
                  }),
                  icon: const Icon(Icons.remove),
                ),
                Column(
                  children: [
                    BoldTextWidget(
                        color: Colors.black,
                        fontSize: 32,
                        text: qty.toString()),
                    const NormalTextWidget(
                        color: Colors.black, fontSize: 10, text: 'Quantity'),
                  ],
                ),
                IconButton(
                  onPressed: (() {
                    setState(() {
                      qty++;
                    });
                  }),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            TextformfieldWidget(
                label: 'Item Name',
                isObscure: false,
                colorFill: Colors.white,
                textFieldController: itemNameController),
            NumberTextformfieldWidget(
                label: 'Coins Equivalent',
                isObscure: false,
                colorFill: Colors.white,
                textFieldController: pointsEqualController),
            TextformfieldWidget(
                label: 'Product Details',
                colorFill: Colors.white,
                textFieldController: _detailsController),
            TextformfieldWidget(
                label: 'Reminders',
                colorFill: Colors.white,
                textFieldController: _remindersController),
            const NormalTextWidget(
                color: CustomColors.primary,
                fontSize: 12,
                text: 'Item Category'),
            const SizedBox(
              height: 5,
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

                  return Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: SizedBox(
                        width: 250,
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
                                  child:
                                      DropDownItem(label: data['category'][i]),
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
                    ),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                borderRadius: 100,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((context) {
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
                                    color: Colors.white,
                                    fontSize: 18,
                                    text:
                                        'Are you sure you want\n   to add this product?'),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.white,
                                  size: 120,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                ButtonWidget(
                                    borderRadius: 100,
                                    onPressed: () async {
                                      try {
                                        ProductRepository().addItem(
                                            itemNameController.text,
                                            itemCategory,
                                            int.parse(
                                                pointsEqualController.text),
                                            imageURL,
                                            _detailsController.text,
                                            _remindersController.text,
                                            qty);

                                        Navigator.pushNamed(
                                            context, '/adminpanelscreenreward');
                                        AnimatedSnackBar.rectangle(
                                          duration: const Duration(seconds: 1),
                                          'Product Added Succesfully!',
                                          '',
                                          type: AnimatedSnackBarType.success,
                                          brightness: Brightness.light,
                                        ).show(
                                          context,
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: NormalTextWidget(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    text:
                                                        'Cannot Procceed! Missing fields')));
                                      }
                                    },
                                    buttonHeight: 50,
                                    buttonWidth: 220,
                                    textWidget: const BoldTextWidget(
                                        color: CustomColors.primary,
                                        fontSize: 18,
                                        text: 'PROCEED'),
                                    color: Colors.white)
                              ],
                            ),
                          ),
                        );
                      }));
                },
                buttonHeight: 50,
                buttonWidth: 220,
                textWidget: const BoldTextWidget(
                    color: CustomColors.primary,
                    fontSize: 18,
                    text: 'CONTINUE'),
                color: Colors.white),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
