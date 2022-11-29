import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final TextAlign? textAlign;
  final Function()? onTap;
  const NormalTextWidget({
    super.key,
    required this.color,
    this.onTap,
    this.textAlign,
    required this.fontSize,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        maxLines: 2,
        text,
        textAlign: textAlign,
        style: GoogleFonts.nunito(color: color, fontSize: fontSize),
      ),
    );
  }
}

class BoldTextWidget extends StatelessWidget {
  final TextAlign? textAlign;
  final String text;
  final double fontSize;
  final Color color;
  final TextDecoration? decoration;
  const BoldTextWidget({
    super.key,
    this.textAlign,
    required this.color,
    required this.fontSize,
    required this.text,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: GoogleFonts.nunitoSans(
          fontWeight: FontWeight.w900,
          color: color,
          fontSize: fontSize,
          decoration: decoration),
    );
  }
}
