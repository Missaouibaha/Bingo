import 'dart:io';

import 'package:bingo_firebase_example/core/theming/app_assets.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NoteImagePreview extends StatelessWidget {
  final String? webImagePath;
  final File? pickedImageFile;
  final VoidCallback onDelete;
  final VoidCallback onChange;

  const NoteImagePreview({
    super.key,
    required this.webImagePath,
    required this.pickedImageFile,
    required this.onDelete,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final image =
        kIsWeb
            ? (webImagePath != null
                ? NetworkImage(webImagePath!)
                : AssetImage(AppAssets.bingoPanda) as ImageProvider)
            : (pickedImageFile?.path != null
                ? FileImage(pickedImageFile!)
                : AssetImage(AppAssets.bingoPanda) as ImageProvider);

    return SizedBox(
      width: AppDimensions.width_170,
      height: AppDimensions.height_150,
      child: Stack(
        children: [
          Image(
            image: image,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: AppDimensions.verticalPadding_5,
            right: AppDimensions.padding_5,
            child: _buildIconButton(Icons.delete, onDelete),
          ),
          Positioned(
            top: AppDimensions.verticalPadding_5,
            right: AppDimensions.width_40,
            child: _buildIconButton(Icons.change_circle, onChange),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(AppDimensions.padding_4),
        decoration: BoxDecoration(
          color: ColorsManager.darkGrey,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: AppDimensions.width_25,
          color: ColorsManager.white,
        ),
      ),
    );
  }
}
