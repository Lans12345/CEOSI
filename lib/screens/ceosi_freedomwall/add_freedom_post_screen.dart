import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/services/navigation.dart';
import 'package:ceosi_app/widgets/sidebar_navigation_column_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/button_widget.dart';
import 'widgets/dropdown_button_form_field_widget.dart';
import '../../widgets/sidebar_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/textformfield_widget.dart';

class AddFreedomPostScreen extends StatefulWidget {
  const AddFreedomPostScreen({super.key});

  @override
  State<AddFreedomPostScreen> createState() => _AddFreedomPostScreenState();
}

class _AddFreedomPostScreenState extends State<AddFreedomPostScreen> {
  final contentController = TextEditingController();
  final addFreedomPostformKey = GlobalKey<FormState>();
  Future addItem(String mood, String content, String anonName, DateTime created,
      DateTime expiration) async {
    final freedomPostsref = FirebaseFirestore.instance
        .collection('CEOSI-FREEDOMWALL-FREEDOMPOSTS')
        .doc();

    var data = {
      'id': freedomPostsref.id,
      'user_id': FirebaseAuth.instance.currentUser!.uid,
      'mood': mood,
      'content': content,
      'anon_name': anonName,
      'created': created,
      'expiration': expiration
    };
    if (data.isNotEmpty) {
      Navigation(context).goToFreedomPostsScreen();
    }

    await freedomPostsref.set(data);
  }

  final moods = [
    'Enjoyment\u{1F60A}',
    'Sadness\u{1F60A}',
    'Anger\u{1F621}',
    'Disgust\u{1F616}',
    'Fear\u{1F628}',
  ];

  Object? mood;
  String anonNames = '';

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  Future addFreedomPost() async {
    if (addFreedomPostformKey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection('CEOSI-USERS-NEW')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((snapshot) async {
        if (snapshot.exists) {
          setState(() {
            anonNames = snapshot.data()!['anon_name'];
          });
        }
      }).whenComplete(() {
        addItem(mood.toString(), contentController.text, anonNames,
            DateTime.now(), DateTime.now().add(const Duration(days: 30)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              key: addFreedomPostformKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  DropDownButtonFormFieldWidget(
                      enabled: true,
                      dropdownbackgroundcolor: Colors.black12,
                      dropdownitemcolor: Colors.black,
                      padding: const EdgeInsets.fromLTRB(37, 12, 37, 0),
                      label: '',
                      value: mood,
                      hint: const Center(
                          child: NormalTextWidget(
                              color: Colors.black,
                              fontSize: 20,
                              text: 'Select Mood')),
                      onChanged: (newValue) {
                        setState(() {
                          mood = newValue;
                          print(mood);
                          print(mood.runtimeType);
                        });
                      },
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
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      maxLines: 14,
                      hintText: 'What\'s on your mind?',
                      radius: 10,
                      isObscure: false,
                      textFieldController: contentController,
                      label: 'Content',
                      colorFill: Colors.black12,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ButtonWidget(
                      borderRadius: 20,
                      onPressed: () {
                        addFreedomPost();
                      },
                      buttonHeight: 53,
                      buttonWidth: 182,
                      textWidget: const NormalTextWidget(
                          color: Colors.white, fontSize: 18, text: 'Add Post')),
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
