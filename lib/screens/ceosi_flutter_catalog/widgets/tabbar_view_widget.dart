import 'package:code_editor/code_editor.dart';
import 'package:flutter/material.dart';

import '../../../widgets/button_widget.dart';
import '../../../widgets/text_widget.dart';

class TabBarViewWidget extends StatelessWidget {
  const TabBarViewWidget({
    super.key,
    required this.editorModel,
    required this.onPressed,
    required this.uploadBtnLabel,
    this.codeTextController,
  });

  final EditorModel editorModel;
  final VoidCallback onPressed;
  final String uploadBtnLabel;
  final TextEditingController? codeTextController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.2,
      child: TabBarView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: CodeEditor(
                  model: editorModel,
                  edit: true,
                  onSubmit: (language, value) {},
                  disableNavigationbar: true,
                  textEditingController: codeTextController,
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
              child: ButtonWidget(
                buttonHeight: 75.0,
                buttonWidth: 150.0,
                borderRadius: 10.0,
                onPressed: onPressed,
                textWidget: BoldTextWidget(
                  color: Colors.white,
                  fontSize: 12.0,
                  text: uploadBtnLabel,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
