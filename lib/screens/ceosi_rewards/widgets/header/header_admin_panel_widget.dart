import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../widgets/text_widget.dart';

class HeaderAdminPanelWidget extends StatelessWidget {
  const HeaderAdminPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.primary,
      width: double.infinity,
      height: 80,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              const BoldTextWidget(
                  color: Colors.white, fontSize: 24, text: 'ADMIN PANEL'),
              const SizedBox(
                width: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
