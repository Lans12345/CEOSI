import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

// ignore: must_be_immutable
class SubmitButtonWidget extends StatefulWidget {
  final VoidCallback onPressed;
  final double buttonWidth;
  final double buttonHeight;
  final double borderRadius;
  final Widget textWidget;
  final Color color;
  final Key? formKey;
  final bool isProcessing;

  const SubmitButtonWidget({
    super.key,
    required this.onPressed,
    this.formKey,
    required this.isProcessing,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.textWidget,
    this.borderRadius = 0,
    this.color = CustomColors.primary,
  });

  @override
  State<SubmitButtonWidget> createState() => _SubmitButtonWidgetState();
}

class _SubmitButtonWidgetState extends State<SubmitButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: widget.buttonWidth,
      height: widget.buttonHeight,
      color: widget.color,
      onPressed: widget.isProcessing ? null : widget.onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius)),
      child: widget.textWidget,
    );
  }
}
