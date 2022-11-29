import 'package:ceosi_app/services/navigation.dart';
import 'package:ceosi_app/widgets/button_widget.dart';
import 'package:ceosi_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../constants/labels.dart';

class SidebarNavigationColumnWidget extends StatelessWidget {
  const SidebarNavigationColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ButtonWidget(
          onPressed: () => Navigation(context).goToCatalogEntriesScreen(),
          buttonHeight: 55.0,
          buttonWidth: 203.0,
          borderRadius: 10.0,
          textWidget: const BoldTextWidget(
              color: Colors.white,
              fontSize: 12.0,
              text: Labels.ceosiFlutterCatalog),
        ),
        const SizedBox(height: 25.0),
        ButtonWidget(
          onPressed: () => Navigation(context).goToFreedomPostsScreen(),
          buttonHeight: 55.0,
          buttonWidth: 203.0,
          borderRadius: 10.0,
          textWidget: const BoldTextWidget(
              color: Colors.white,
              fontSize: 12.0,
              text: Labels.ceosiFreedomWall),
        ),
        const SizedBox(height: 25.0),
        ButtonWidget(
          onPressed: () => Navigation(context).goToAnnouncementScreen(),
          buttonHeight: 55.0,
          buttonWidth: 203.0,
          borderRadius: 10.0,
          textWidget: const BoldTextWidget(
              color: Colors.white,
              fontSize: 12.0,
              text: Labels.ceosiCompanyApp),
        ),
        const SizedBox(height: 25.0),
        ButtonWidget(
          onPressed: () => Navigation(context).goToRewardHomeScreen(),
          buttonHeight: 55.0,
          buttonWidth: 203.0,
          borderRadius: 10.0,
          textWidget: const BoldTextWidget(
              color: Colors.white, fontSize: 12.0, text: Labels.ceosiRewards),
        ),
      ],
    );
  }
}
