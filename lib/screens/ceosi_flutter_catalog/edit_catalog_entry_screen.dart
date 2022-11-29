import 'package:ceosi_app/screens/ceosi_flutter_catalog/source_code_screen.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/widgets/flutter_catalog_appbar_widget.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/widgets/flutter_catalog_text_formfield_widget.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/widgets/tabbar_view_widget.dart';
import 'package:code_editor/code_editor.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/labels.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';

class EditCatalogEntryScreen extends StatelessWidget {
  const EditCatalogEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EditCatalogEntryArguments;
    final TextEditingController titleController =
        TextEditingController(text: args.title);
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController codeController = TextEditingController();
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

    return Scaffold(
      appBar: flutterCatalogAppbarWidget(title: args.title),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: FlutterCatalogTextFormField(
                  controller: titleController, labelText: Labels.title),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: FlutterCatalogTextFormField(
                  controller: descriptionController,
                  labelText: Labels.description,
                  keyboardType: TextInputType.multiline,
                  maxLines: null),
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
                        onPressed: () {},
                        uploadBtnLabel: Labels.uploadImage,
                        codeTextController: codeController,
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
                  text: Labels.save,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
