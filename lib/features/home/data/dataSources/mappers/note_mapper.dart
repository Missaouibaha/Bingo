import 'package:bingo_firebase_example/core/helper/exteensions.dart';
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
              ? "https://avatars.githubusercontent.com/u/38219480?s=400&u=fb8d4c882e4754f571c37355037f1cca6e88d7a7&v=4"
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
