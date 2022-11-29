import 'dart:io';

import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/widgets/flutter_catalog_appbar_widget.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/widgets/tabbar_view_widget.dart';
import 'package:ceosi_app/widgets/button_widget.dart';
import 'package:ceosi_app/widgets/text_widget.dart';
import 'package:code_editor/code_editor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/labels.dart';

class AddCatalogEntryScreen extends StatelessWidget {
  AddCatalogEntryScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<FileEditor> files = [
      FileEditor(
        name: 'add_entry.dart',
        language: 'dart',
        code: <String>[].join('\n'),
      ),
    ];

    EditorModel editorModel = EditorModel(
      files: files,
      styleOptions: EditorModelStyleOptions(
        fontSize: 10.0,
        toolbarOptions: const ToolbarOptions(
          copy: true,
          paste: true,
          cut: true,
          selectAll: true,
        ),
        editButtonTextColor: CustomColors.primary,
        editorToolButtonColor: Colors.white,
        editorToolButtonTextColor: CustomColors.primary,
      ),
    );

    var scaffoldMessenger = ScaffoldMessenger.of(context);

    Future<void> uploadImage() async {
      final imagePicker = ImagePicker();
      PickedFile image;
      PermissionStatus status = await Permission.photos.request();

      if (status == PermissionStatus.granted) {
        image = (await imagePicker.pickImage(source: ImageSource.gallery))
            as PickedFile;
        var file = File(image.path);
        print('File Path: $file');
      } else {
        scaffoldMessenger.showSnackBar(
            const SnackBar(content: Text(Labels.permissionRecommended)));
      }
    }

    return Scaffold(
      appBar: flutterCatalogAppbarWidget(title: Labels.addCatalogEntry),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: TextFormField(
                controller: titleController,
                autofocus: true,
                maxLength: 50,
                cursorRadius: const Radius.circular(20.0),
                cursorColor: CustomColors.primary,
                toolbarOptions: const ToolbarOptions(
                    copy: true, cut: true, paste: true, selectAll: true),
                validator: (value) {
                  return '';
                },
                decoration: InputDecoration(
                  isDense: true,
                  label: const Text(
                    Labels.title,
                    style: TextStyle(
                      color: CustomColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 1.0, color: CustomColors.primary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 1.0, color: CustomColors.primary),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 1.0, color: CustomColors.greyAccent),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: TextFormField(
                controller: descriptionController,
                cursorRadius: const Radius.circular(20.0),
                cursorColor: CustomColors.primary,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                toolbarOptions: const ToolbarOptions(
                    copy: true, cut: true, paste: true, selectAll: true),
                validator: (value) {
                  return '';
                },
                decoration: InputDecoration(
                  isDense: false,
                  label: const Text(
                    Labels.description,
                    style: TextStyle(
                      color: CustomColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 1.0, color: CustomColors.primary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 1.0, color: CustomColors.primary),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 1.0, color: CustomColors.greyAccent),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: const Border(
                        left: BorderSide(color: CustomColors.primary),
                        top: BorderSide(color: CustomColors.primary),
                        right: BorderSide(color: CustomColors.primary),
                        bottom: BorderSide(color: CustomColors.primary))),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const TabBar(
                        indicatorColor: CustomColors.secondary,
                        indicatorWeight: 5,
                        padding: EdgeInsets.all(10.0),
                        tabs: [
                          Tab(
                            icon: Icon(
                              Icons.code,
                              color: CustomColors.primary,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              Icons.image,
                              color: CustomColors.primary,
                            ),
                          ),
                        ],
                      ),
                      TabBarViewWidget(
                        editorModel: editorModel,
                        onPressed: () {
                          uploadImage();
                        },
                        uploadBtnLabel: Labels.uploadImage,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
              child: ButtonWidget(
                onPressed: () {},
                buttonHeight: 50.0,
                buttonWidth: 100.0,
                borderRadius: 10.0,
                textWidget: const BoldTextWidget(
                  color: Colors.white,
                  fontSize: 12.0,
                  text: Labels.submit,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
