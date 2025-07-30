import 'package:bingo_firebase_example/core/helper/spacing.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/text_styles.dart';
import 'package:bingo_firebase_example/features/home/domain/entities/note_entity.dart';
import 'package:flutter/material.dart';

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
      child: Card(
        elevation: AppDimensions.width_10,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppDimensions.radius_16),
                topLeft: Radius.circular(AppDimensions.radius_16),
              ),
              child: Image.network(
                note.imagePath ?? '',
                height: AppDimensions.height_150,
                width: AppDimensions.width_130,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.height_10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note?.title ?? '',
                      style: TextStyles.font20BlackSemiBold,
                    ),
                    verticalSpace(AppDimensions.height_8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        note?.description ?? '',
                        style: TextStyles.font16BlackMedium,
                      ),
                    ),
                    verticalSpace(AppDimensions.height_12),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        note?.createdAt?.toString() ?? '',
                        style: TextStyles.font14BlueMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
