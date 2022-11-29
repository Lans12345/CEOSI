import 'package:ceosi_app/constants/colors.dart';
import 'package:flutter/material.dart';

class AddButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isProcessing;
  final Function() validated;
  final double buttonWidth;
  final double buttonHeight;
  final double borderRadius;
  final Widget textWidget;

  const AddButtonWidget({
    super.key,
    required this.formKey,
    required this.isProcessing,
    required this.validated,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.textWidget,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: buttonWidth,
      height: buttonHeight,
      color: CustomColors.primary,
      onPressed: isProcessing ? null : validated,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
      child: textWidget,
    );
  }
}
