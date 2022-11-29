import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MasonryTextWidget extends StatefulWidget {
  final String text;
  final TextAlign? textAlign;
  final double? fontSize;
  final String? fontFamily;
  final List<double>? presetFontSizes;
  final TextStyle? style;

  const MasonryTextWidget({
    super.key,
    this.textAlign,
    this.presetFontSizes,
    this.style,
    this.fontFamily,
    this.fontSize,
    required this.text,
  });

  @override
  State<MasonryTextWidget> createState() => _MasonryTextWidgetState();
}

class _MasonryTextWidgetState extends State<MasonryTextWidget> {
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      widget.text,
      style: widget.style,
      presetFontSizes: widget.presetFontSizes,
    );
  }
}
