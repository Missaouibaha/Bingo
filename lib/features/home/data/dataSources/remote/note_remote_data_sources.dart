import 'dart:io';
import 'dart:typed_data';

import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:bingo_firebase_example/features/home/data/dataSources/models/note_model.dart';
import 'package:dartz/dartz.dart';

abstract class NoteRemoteDataSources {
  Future<Either<AppFirebaseFailure, Unit>> addNote(
    String noteTitle,
    String noteDescription,
    File? noteImageFile,
    Uint8List? webImageBytes,
  );

  Future<Either<AppFirebaseFailure, List<NoteModel>?>> getNotes();
  Stream<Either<AppFirebaseFailure, List<NoteModel>>> watchNotes();
  Future<Either<AppFirebaseFailure,Unit>> updateNote(NoteModel note);
    Future<Either<AppFirebaseFailure, Unit>> deleteNote(String noteId, bool deleteAll);

}
