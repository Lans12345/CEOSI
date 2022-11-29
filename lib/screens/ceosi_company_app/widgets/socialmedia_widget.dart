import 'package:flutter/material.dart';

class SocialMediaWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Color containerColor;
  final IconData icon;
  final Color iconColor;

  const SocialMediaWidget({
    super.key,
    required this.onTap,
    required this.containerColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            color: containerColor,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          )), //
    );
  }
}
