import 'package:ceosi_app/constants/colors.dart';
import 'package:flutter/material.dart';

class AddtextformfieldWidget extends StatelessWidget {
  final String label;
  final Color colorFill;
  final Widget? suffixIcon;
  final TextEditingController textFieldController;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLine;

  const AddtextformfieldWidget(
      {super.key,
      required this.label,
      this.onTap,
      this.colorFill = Colors.white,
      this.suffixIcon,
      required this.textFieldController,
      this.readOnly = false,
      this.maxLine = 1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: TextFormField(
          controller: textFieldController,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            errorStyle: const TextStyle(color: Colors.red),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: colorFill,
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 2, color: CustomColors.primary),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 2, color: CustomColors.primary),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 2, color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 2, color: Colors.red)),
            hintText: label,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 12.0,
            ),
          ),
          onTap: onTap,
          readOnly: readOnly,
          maxLines: maxLine,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label is required';
            }
            return null;
          }),
    );
  }
}
