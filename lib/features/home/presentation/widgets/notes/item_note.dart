import 'package:bingo_firebase_example/core/helper/spacing.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:bingo_firebase_example/core/theming/text_styles.dart';
import 'package:bingo_firebase_example/core/utils/app_consts.dart';
import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/features/home/domain/entities/note_entity.dart';
import 'package:bingo_firebase_example/features/home/presentation/providers/delete_note_notifier_provider.dart';
import 'package:bingo_firebase_example/features/home/presentation/widgets/add/bottom_sheet_add_note.dart';
import 'package:bingo_firebase_example/features/home/presentation/widgets/delete/delete_note_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemNote extends StatelessWidget {
  final NoteEntity note;

  const ItemNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppDimensions.padding_5,
        AppDimensions.padding_2,
        AppDimensions.padding_5,
        AppDimensions.padding_10,
      ),
      child: GestureDetector(
        onTap: () {
          updateNote(note, context);
        },
        child: Consumer(
          builder: (context, ref, child) {
            return Dismissible(
              key: Key(note.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                color: ColorsManager.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.padding_20,
                ),
                child: Icon(
                  Icons.delete,
                  color: ColorsManager.lightBlue,
                  size: AppDimensions.width_30,
                ),
              ),

              confirmDismiss: (direction) async {
                bool cancelDelete = false;
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(_buidlSnackBar(() => cancelDelete = true));
                await Future.delayed(
                  const Duration(seconds: AppConsts.snackBarDealy),
                );
                if (cancelDelete) {
                  return false;
                }
                deleteNoteById(ref, note.id.toString());
                return true;
              },

              child: Card(
                elevation: AppDimensions.width_10,
                child: Row(
                  children: [
                    Hero(
                      tag: "${note.id}",
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppDimensions.radius_16),
                          topLeft: Radius.circular(AppDimensions.radius_16),
                        ),
                        child: Image.network(
                          note.imagePath ?? '',
                          height: AppDimensions.height_150,
                          width: AppDimensions.width_130,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: AppDimensions.height_150,
                              width: AppDimensions.width_130,
                              color: Colors.grey.shade200,
                              child: Icon(
                                Icons.broken_image,
                                size: AppDimensions.width_40,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.height_10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note.title ?? '',
                              style: TextStyles.font20BlackSemiBold,
                            ),
                            verticalSpace(AppDimensions.height_8),
                            Text(
                              note.description ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.font16BlackMedium,
                            ),
                            verticalSpace(AppDimensions.height_12),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                note.createdAt?.toString() ?? '',
                                style: TextStyles.font14BlueMedium,
                              ),
                            ),
                            DeleteNoteListener(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void updateNote(NoteEntity note, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radius_16),
          topRight: Radius.circular(AppDimensions.radius_16),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            child: SingleChildScrollView(child: BottomSheetAddNote(note: note)),
          ),
        );
      },
    );
  }

  SnackBar _buidlSnackBar(VoidCallback onCancel) {
    return SnackBar(
      backgroundColor: ColorsManager.green,
      elevation: AppDimensions.elevation_5,
      content: Text(
        AppStrings.snackBardeleteWarning,
        style: TextStyles.font15LightWhiteRegular,
      ),

      duration: Duration(seconds: AppConsts.snackBarDealy),
      action: SnackBarAction(
        label: AppStrings.cancel,
        backgroundColor: ColorsManager.white,
        onPressed: onCancel,
      ),
      behavior: SnackBarBehavior.floating,
    );
  }

  void deleteNoteById(WidgetRef ref, String noteId) {
    ref.watch(deleteNoteNotifierProvider.notifier).deleteNote(noteId, false);
  }
}
