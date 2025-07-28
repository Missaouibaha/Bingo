import 'dart:io';
import 'dart:typed_data';

import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:dartz/dartz.dart';

abstract class NoteRemoteDataSources {
  Future<Either<AppFirebaseFailure, Unit>> addNote(
    String noteTitle,
    String noteDescription,
    File? noteImageFile,
     Uint8List? webImageBytes,
  );
}
