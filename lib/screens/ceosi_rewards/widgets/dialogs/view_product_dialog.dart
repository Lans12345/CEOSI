import 'package:ceosi_app/constants/colors.dart';
import 'package:flutter/material.dart';

class ViewProductDialog extends StatelessWidget {
  final String imageURL;

  const ViewProductDialog({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 450,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                IconButton(
                  onPressed: (() {
                    Navigator.of(context).pop();
                  }),
                  icon: const Icon(
                    Icons.close,
                    color: CustomColors.secondary,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Image.network(
                imageURL,
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
