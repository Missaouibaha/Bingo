import 'package:bingo_firebase_example/core/helper/exteensions.dart';
import 'package:bingo_firebase_example/core/utils/app_consts.dart';
import 'package:bingo_firebase_example/features/home/data/dataSources/models/note_model.dart';
import 'package:bingo_firebase_example/features/home/domain/entities/note_entity.dart';

extension NoteMapper on NoteModel {
  NoteEntity toDomain() {
    return NoteEntity(
      id: id,
      title: title,
      description: desciprion,
      userId: userId,
      createdAt: createdAt,
      imagePath:
          imagePath.isNullOrEmpty()
              ? AppConsts.fakePhotoNote
              : imagePath!,
    );
  }
}

extension NoteDomain on NoteEntity {
  NoteModel toNoteModel() {
    return NoteModel(
      id: id ?? '',
      title: title,
      desciprion: description,
      userId: userId ?? '',
      createdAt: createdAt ?? '',
    );
  }
}
