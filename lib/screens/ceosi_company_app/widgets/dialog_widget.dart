import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  final VoidCallback imageFromGallery;
  final VoidCallback imageFromCamera;
  const DialogWidget(
      {super.key,
      required this.imageFromGallery,
      required this.imageFromCamera});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('From where do you want to take the photo? '),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: imageFromGallery),
              ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: imageFromCamera),
            ],
          ),
        ));
  }
}
