import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/constants/labels.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog {
  ConfirmationDialog(this.context);

  BuildContext context;

  dialog({required String title, required VoidCallback onPressed}) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialogWidget(
          title: title,
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Text(
                Labels.yes,
                style: TextStyle(color: CustomColors.secondary),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(
                Labels.no,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
    return confirm;
  }
}

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget(
      {super.key, required this.title, required this.actions});

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: CustomColors.primary,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 14.0),
      ),
      actions: actions,
    );
  }
}
