import 'package:ceosi_app/screens/ceosi_flutter_catalog/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../../../constants/labels.dart';
import '../../../services/navigation.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/text_widget.dart';

class FlutterCatalogNavigationColumnWidget extends StatelessWidget {
  const FlutterCatalogNavigationColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ButtonWidget(
          onPressed: () => ConfirmationDialog(context).dialog(
            title: Labels.goToHomeScreenConfirmationTitle,
            onPressed: () => Navigation(context).goToHomeScreen(),
          ),
          buttonHeight: 55.0,
          buttonWidth: 203.0,
          borderRadius: 10.0,
          textWidget: const BoldTextWidget(
              color: Colors.white, fontSize: 12.0, text: Labels.home),
        ),
        const SizedBox(height: 25.0),
        ButtonWidget(
          onPressed: () => Navigation(context).goToCatalogEntriesScreen(),
          buttonHeight: 55.0,
          buttonWidth: 203.0,
          borderRadius: 10.0,
          textWidget: BoldTextWidget(
              color: Colors.white,
              fontSize: 12.0,
              text: Labels.catalogEntries.titleCase),
        ),
        const SizedBox(height: 25.0),
        ButtonWidget(
          onPressed: () => Navigation(context).goToUserContributionsScreen(),
          buttonHeight: 55.0,
          buttonWidth: 203.0,
          borderRadius: 10.0,
          textWidget: BoldTextWidget(
              color: Colors.white,
              fontSize: 12.0,
              text: Labels.userContributions.titleCase),
        ),
      ],
    );
  }
}
