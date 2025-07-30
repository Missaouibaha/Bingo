import 'dart:io';

import 'package:bingo_firebase_example/core/helper/exteensions.dart';
import 'package:bingo_firebase_example/core/helper/spacing.dart';
import 'package:bingo_firebase_example/core/theming/app_assets.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:bingo_firebase_example/core/theming/text_styles.dart';
import 'package:bingo_firebase_example/core/utils/app_consts.dart';
import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/core/widgets/app_custom_dialog.dart';
import 'package:bingo_firebase_example/core/widgets/app_rounded_button.dart';
import 'package:bingo_firebase_example/features/home/presentation/providers/add_note_notifier_provider.dart';
import 'package:bingo_firebase_example/features/home/presentation/widgets/add_note_listener.dart';
import 'package:bingo_firebase_example/features/home/presentation/widgets/imagepicker/image_picker_sheet.dart';
import 'package:bingo_firebase_example/features/home/presentation/widgets/imagepicker/image_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class BottomSheetAddNote extends StatefulWidget {
  const BottomSheetAddNote({super.key});

  @override
  State<BottomSheetAddNote> createState() => _BottomSheetAddNoteState();
}

class _BottomSheetAddNoteState extends State<BottomSheetAddNote> {
  String? _webImagePath;
  bool imageAdded = false;
  Uint8List? _webImageBytes;
  File? _pickedImageFile;

  final TextEditingController noteTitleController = TextEditingController();
  final TextEditingController noteDescriptionController =
      TextEditingController();
  @override
  void dispose() {
    noteTitleController.dispose();
    noteDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.padding_10,
        vertical: AppDimensions.verticalPadding_5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitleField(),
          _buildDescriptionField(),
          verticalSpace(AppDimensions.height_15),
           if (!imageAdded)
            GestureDetector(
              onTap: _showImagePickerBottomSheet,
              child: Row(
                children: [
                  Icon(
                    Icons.image,
                    size: AppDimensions.width_35,
                    color: ColorsManager.darckBlue,
                  ),
                  horizontalSpace(AppDimensions.width_8),
                  Text(
                    AppStrings.notePhotos,
                    style: TextStyles.font18BlackSemiBold,
                  ),
                ],
              ),
            ),
          if (imageAdded)
            NoteImagePreview(
              webImagePath: _webImagePath,
              pickedImageFile: _pickedImageFile,
              onDelete: () => setState(() => imageAdded = false),
              onChange: _showImagePickerBottomSheet,
            ),

          verticalSpace(AppDimensions.height_15),

          Consumer(
            builder: (context, ref, child) {
              return AppRoundedButton(
                textButton: AppStrings.add,
                textStyle: TextStyles.font24WhiteMedium,
                onPressed: () {
                  _addNote(ref);
                },
              );
            },
          ),
          verticalSpace(AppDimensions.height_15),
          AddNoteListener(),
        ],
      ),
    );
  }

  Widget _buildTitleField() => TextField(
    decoration: InputDecoration(
      hintText: AppStrings.noteTitle,
      hintStyle: TextStyles.font18GreySemiBold,
    ),
    style: TextStyles.font18BlackSemiBold,
    textAlign: TextAlign.center,
    controller: noteTitleController,
    autofocus: true,
    maxLength: AppConsts.noteTitleMaxLength,
  );
  Widget _buildDescriptionField() => SizedBox(
    height: AppDimensions.height_100,
    child: TextField(
      maxLines: null,
      expands: true,
      textAlign: TextAlign.start,
      controller: noteDescriptionController,
      decoration: InputDecoration(
        hintText: AppStrings.noteDescription,
        border: OutlineInputBorder(),
      ),
    ),
  );

  Future<void> _showImagePickerBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      builder: (_) => ImagePickerSheet(onPick: _pickImage),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      if (kIsWeb) {
        _webImageBytes = await picked.readAsBytes();

        setState(() {
          _webImagePath = picked.path;
        });
      } else {
        setState(() => _pickedImageFile = File(picked.path));
      }
      imageAdded = true;
    }
  }

  void _addNote(WidgetRef ref) {
    if (_checkEntredData()) {
      ref
          .watch(addNoteNotifierProvider.notifier)
          .addNote(
            noteTitleController.text,
            noteDescriptionController.text,
            _pickedImageFile,
            _webImageBytes,
          );
    }
  }

  bool _checkEntredData() {
    String? message;
    if (noteTitleController.text.isNullOrEmpty() ||
        noteTitleController.text.length < AppConsts.noteTitleMinLength) {
      message = AppStrings.enterValidNoteTitle;
    } else if (noteDescriptionController.text.isNullOrEmpty() ||
        noteDescriptionController.text.length <
            AppConsts.noteDescriptionMinLength) {
      message = AppStrings.enterValidNoteDescription;
    } else {
      return true;
    }
    AppCustomDialog.show(
      context: context,
      okTextButton: AppStrings.ok,
      message: message,
      okAction: () {},
    );
    return false;
  }
}
