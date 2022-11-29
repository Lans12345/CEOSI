import 'package:flutter/material.dart';

class PostButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final double buttonWidth;
  final double buttonHeight;
  final double borderRadius;
  final Widget textWidget;
  final Color color;

  const PostButtonWidget({
    super.key,
    required this.onPressed,
    required this.color,
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
      color: color,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
      child: textWidget,
    );
  }
}
