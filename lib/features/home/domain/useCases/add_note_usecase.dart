import 'dart:io';
import 'dart:typed_data';

import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:bingo_firebase_example/features/home/domain/repository/note_repository.dart';
import 'package:dartz/dartz.dart';

class AddNoteUsecase {
  final NoteRepository _noteRepository;
  AddNoteUsecase(this._noteRepository);

  Future<Either<AppFirebaseFailure, Unit>> call(
    String noteTitle,
    String noteDescription,
    File? noteImageFile,
    Uint8List? webImageBytes,
  )async {
    return  await _noteRepository.addNote(noteTitle, noteDescription, noteImageFile,webImageBytes);
  }
}
