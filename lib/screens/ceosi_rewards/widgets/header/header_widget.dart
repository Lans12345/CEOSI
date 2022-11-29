import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../widgets/text_widget.dart';

// ignore: must_be_immutable
class HeaderWidget extends StatelessWidget {
  late String headerTitle;

  HeaderWidget({super.key, required this.headerTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.primary,
      width: double.infinity,
      height: 150,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
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
              BoldTextWidget(
                  color: Colors.white, fontSize: 28, text: headerTitle),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
