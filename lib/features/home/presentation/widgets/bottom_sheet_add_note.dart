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
  File? _imageFile;
  String? _webImagePath;
  bool imageAdded = false;
  Uint8List? _webImageBytes;

  final TextEditingController noteTitle = TextEditingController();
  final TextEditingController noteDescription = TextEditingController();
  @override
  void dispose() {
    noteTitle.dispose();
    noteDescription.dispose();
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
          TextField(
            decoration: InputDecoration(
              hintText: AppStrings.noteTitle,
              hintStyle: TextStyles.font18GreySemiBold,
            ),
            enabled: true,
            style: TextStyles.font18BlackSemiBold,
            textAlign: TextAlign.center,
            controller: noteTitle,
            autofocus: true,
            maxLength: AppConsts.noteTitleMaxLength,
          ),
          SizedBox(
            height: AppDimensions.height_100,
            child: TextField(
              maxLines: null,
              expands: true,

              textAlign: TextAlign.start,
              controller: noteDescription,

              decoration: InputDecoration(
                hintText: AppStrings.noteDescription,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          verticalSpace(AppDimensions.height_15),
          if (!imageAdded)
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
              onTap: () {
                _imagePicker(context);
              },
            ),
          if (imageAdded)
            SizedBox(
              width: AppDimensions.width_170,
              height: AppDimensions.height_150,
              child: Stack(
                children: [
                  Image(
                    image:
                        kIsWeb
                            ? (_webImagePath != null
                                ? NetworkImage(_webImagePath!)
                                : AssetImage(AppAssets.bingoPanda)
                                    as ImageProvider)
                            : (_imageFile != null
                                ? FileImage(_imageFile!)
                                : AssetImage(AppAssets.bingoPanda)
                                    as ImageProvider),
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    top: AppDimensions.verticalPadding_5,
                    right: AppDimensions.padding_5,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          imageAdded = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(AppDimensions.padding_4),
                        decoration: BoxDecoration(
                          color: ColorsManager.darkGrey,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.delete,
                          size: AppDimensions.width_25,
                          color: ColorsManager.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: AppDimensions.verticalPadding_5,
                    right: AppDimensions.width_40,
                    child: GestureDetector(
                      onTap: () {
                        _imagePicker(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(AppDimensions.padding_4),
                        decoration: BoxDecoration(
                          color: ColorsManager.darkGrey,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.change_circle,
                          size: AppDimensions.width_25,
                          color: ColorsManager.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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

  void _imagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              _buildListTileImagePicker(
                Icons.camera_alt,
                AppStrings.takePhoto,
                () async => pickedImage(ImageSource.camera),
              ),
              _buildListTileImagePicker(
                Icons.photo_album_outlined,
                AppStrings.chooseFromGallery,
                () async => pickedImage(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListTileImagePicker(
    IconData iconData,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title, style: TextStyles.font14DarckBlueMedium),
      onTap: onTap,
    );
  }

  Future pickedImage(ImageSource source) async {
    try {
      final picked = await ImagePicker().pickImage(source: source);
      if (picked != null) {
        if (kIsWeb) {
          final bytes = await picked.readAsBytes(); // Await before setState
          Future.microtask(() {
            setState(() {
              _webImageBytes = bytes;
              _webImagePath = picked.path;
              imageAdded = true;
            });
          });
        } else {
          setState(() {
            _imageFile = File(picked.path);
            imageAdded = true;
          });
        }
      }
    } catch (e, s) {
      debugPrint("${AppStrings.cameraError} $e\n$s");
    }
    context.pop();
  }

  void _addNote(WidgetRef ref) {
    if (_checkEntredData()) {
      ref
          .watch(addNoteNotifierProvider.notifier)
          .addNote(
            noteTitle.text,
            noteDescription.text,
            _imageFile,
            _webImageBytes,
          );
    }
  }

  bool _checkEntredData() {
    String? message;
    if (noteTitle.text.isNullOrEmpty() ||
        noteTitle.text.length < AppConsts.noteTitleMaxLength) {
      message = AppStrings.enterValidNoteTitle;
    } else if (noteDescription.text.isNullOrEmpty() ||
        noteDescription.text.length < AppConsts.noteDescriptionMaxLength) {
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
