import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../widgets/text_widget.dart';

class LogoutPromptDialogWidget extends StatelessWidget {
  const LogoutPromptDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CustomColors.primary,
      title: const Center(
        child: Icon(
          Icons.warning_rounded,
          color: Colors.white,
          size: 102,
        ),
      ),
      content: const NormalTextWidget(
          color: Colors.white,
          fontSize: 14,
          text: 'Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const NormalTextWidget(
              color: Colors.white, fontSize: 12, text: 'Close'),
        ),
        TextButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            // final preferences = await SharedPreferences.getInstance();
            // await preferences.clear();

            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, '/loginscreen');
          },
          child: const NormalTextWidget(
              color: Colors.white, fontSize: 12, text: 'Continue'),
        ),
      ],
    );
  }
}
