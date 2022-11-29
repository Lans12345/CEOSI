import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/text_widget.dart';

class ErrorDialog extends StatelessWidget {
  final VoidCallback onPressed;
  final String caption;

  const ErrorDialog(
      {super.key, required this.caption, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomColors.primary,
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 350,
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            BoldTextWidget(color: Colors.white, fontSize: 18, text: caption),
            const SizedBox(
              height: 20,
            ),
            const Icon(
              Icons.close,
              size: 180,
              color: Colors.red,
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonWidget(
              borderRadius: 100,
              onPressed: onPressed,
              buttonHeight: 50,
              buttonWidth: 220,
              textWidget: const BoldTextWidget(
                  color: Colors.white, fontSize: 18, text: 'Close'),
              color: CustomColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
