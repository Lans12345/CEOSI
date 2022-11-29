import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget flutterCatalogAppbarWidget({
  required String title,
  List<Widget>? actions,
}) {
  return AppBar(
    elevation: 0,
    title: BoldTextWidget(color: Colors.white, fontSize: 14.0, text: title),
    centerTitle: true,
    backgroundColor: CustomColors.primary,
    actions: actions,
  );
}
