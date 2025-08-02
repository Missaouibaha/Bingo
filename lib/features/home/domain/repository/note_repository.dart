import 'dart:io';
import 'dart:typed_data';

import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:bingo_firebase_example/features/home/domain/entities/note_entity.dart';
import 'package:dartz/dartz.dart';

abstract class NoteRepository {
  Future<Either<AppFirebaseFailure, Unit>> addNote(
    String noteTitle,
    String noteDescription,
    File? noteImageFile,
    Uint8List? webImageBytes,
  );

  Future<Either<AppFirebaseFailure, List<NoteEntity>?>> getNotes();
  Stream<Either<AppFirebaseFailure, List<NoteEntity>>> watchNotes();
  Future<Either<AppFirebaseFailure, Unit>> update(NoteEntity note);
  Future<Either<AppFirebaseFailure,Unit>>delete(String noteId, bool deleteAll ) ;
}
