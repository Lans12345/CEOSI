import 'package:flutter/material.dart';

class ErrorBuilderWidget extends StatelessWidget {
  const ErrorBuilderWidget({
    super.key,
    required this.label,
    this.textAlign,
    this.style,
  });

  final String label;
  final TextAlign? textAlign;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        textAlign: textAlign,
        style: style,
      ),
    );
  }
}
