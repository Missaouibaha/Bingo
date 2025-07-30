import 'package:bingo_firebase_example/core/helper/exteensions.dart';
import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerSheet extends StatelessWidget {
  final void Function(ImageSource source) onPick;

  const ImagePickerSheet({super.key, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt_outlined),
          title: const Text(AppStrings.takePhoto),
          onTap: () => _pick(context, ImageSource.camera),
        ),
        ListTile(
          leading: const Icon(Icons.photo_library_outlined),
          title: const Text(AppStrings.chooseFromGallery),
          onTap: () => _pick(context, ImageSource.gallery),
        ),
      ],
    );
  }

  void _pick(BuildContext context, ImageSource source) {
    context.pop();
    onPick(source);
  }
}
