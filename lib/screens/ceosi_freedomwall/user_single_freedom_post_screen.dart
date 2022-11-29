import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/widgets/error_dialogue_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ceosi_app/widgets/sidebar_navigation_column_widget.dart';
import 'package:flutter/material.dart';

import '../../constants/icons.dart';
import '../../services/navigation.dart';
import '../../widgets/button_widget.dart';
import 'widgets/dropdown_button_form_field_widget.dart';

import '../../widgets/sidebar_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/textformfield_widget.dart';

class UserSingleFreedomPostScreen extends StatefulWidget {
  final String? content;
  final String? mood;
  final String? id;

  const UserSingleFreedomPostScreen(
      {super.key, this.id, this.content, this.mood});

  @override
  State<UserSingleFreedomPostScreen> createState() =>
      _UserSingleFreedomPostScreenState();
}

class _UserSingleFreedomPostScreenState
    extends State<UserSingleFreedomPostScreen> {
  late String catchedContent;
  late String catchedMood;
  late String catchedId;
  late TextEditingController contentcontroller =
      TextEditingController(text: catchedContent);
  final moods = [
    'Enjoyment\u{1F60A}',
    'Sadness\u{1F62D}',
    'Anger\u{1F621}',
    'Disgust\u{1F616}',
    'Fear\u{1F628}',
  ];
  GlobalKey<FormState> key = GlobalKey<FormState>();

  delete() {
    FirebaseFirestore.instance
        .collection('CEOSI-FREEDOMWALL-FREEDOMPOSTS')
        .doc(catchedId)
        .delete();

    Navigation(context).goToFreedomPostsScreen();
  }

  deletePost(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text('continue'),
      onPressed: () {
        delete();
      },
    );
    Widget nobutton = TextButton(
      child: const Text('cancel'),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: CustomColors.primary,
      title: const BoldTextWidget(
          color: Colors.white, fontSize: 20, text: 'CEOSI-APP'),
      content: const NormalTextWidget(
          color: Colors.white,
          fontSize: 14,
          text: 'Do you want to delete this post?'),
      actions: [okButton, nobutton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  save() {
    if (editPostformKey.currentState!.validate() && edit == true) {
      var newdata = {
        'mood': mood ?? catchedMood,
        'content': contentcontroller.text
      };
      var collection = FirebaseFirestore.instance
          .collection('CEOSI-FREEDOMWALL-FREEDOMPOSTS');
      collection
          .doc(catchedId) // <-- Doc ID where data should be updated.
          .update(newdata);
      Navigation(context).goToFreedomPostsScreen();
    } else {
      showDialog(
        context: context,
        builder: ((context) {
          return ErrorDialog(
              caption: edit ? 'Content is Empty' : 'Press Edit Button',
              onPressed: () {
                Navigator.of(context).pop();
              });
        }),
      );
    }
  }

  Object? mood;
  bool edit = false;
  final editPostformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    catchedContent = widget.content!;
    catchedMood = widget.mood!;
    catchedId = widget.id!;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        drawer: const SidebarWidget(
            navigationColumn: SidebarNavigationColumnWidget()),
        appBar: AppBar(
          backgroundColor: CustomColors.primary,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: editPostformKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 150,
                      ),
                      ButtonWidget(
                          borderRadius: 10,
                          onPressed: () {
                            setState(() {
                              edit = !edit;
                            });
                          },
                          buttonHeight: 50,
                          buttonWidth: 50,
                          textWidget: Image.asset(CustomIcons().editicon,
                              fit: BoxFit.contain)),
                      ButtonWidget(
                          borderRadius: 10,
                          onPressed: () async {
                            deletePost(context);
                          },
                          buttonHeight: 50,
                          buttonWidth: 50,
                          textWidget: Image.asset(CustomIcons().deleteicon,
                              fit: BoxFit.contain)),
                    ],
                  ),
                  DropDownButtonFormFieldWidget(
                      enabled: edit,
                      dropdownbackgroundcolor: Colors.black12,
                      dropdownitemcolor: Colors.black,
                      padding: const EdgeInsets.fromLTRB(37, 12, 37, 0),
                      label: '',
                      value: catchedMood,
                      hint: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            NormalTextWidget(
                                color: Colors.black,
                                fontSize: 20,
                                text: catchedMood)
                          ]),
                      onChanged: edit
                          ? (newValue) {
                              setState(() {
                                mood = newValue;
                                print(mood);
                                print(mood.runtimeType);
                              });
                            }
                          : null,
                      items:
                          moods.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          alignment: AlignmentDirectional.center,
                          value: value,
                          child: Center(child: Text(value)),
                        );
                      }).toList()),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: TextformfieldWidget(
                      labelfontSize: 20.0,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      maxLines: 14,
                      textFieldController: contentcontroller,
                      enabled: edit,
                      onChanged: (val) {
                        catchedContent = val;
                      },
                      radius: 10,
                      isObscure: false,
                      label: catchedId,
                      colorFill: Colors.black12,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ButtonWidget(
                      borderRadius: 20,
                      onPressed: () {
                        save();
                      },
                      buttonHeight: 53,
                      buttonWidth: 182,
                      textWidget: const NormalTextWidget(
                          color: Colors.white, fontSize: 18, text: 'Save')),
                  const SizedBox(
                    height: 250,
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
