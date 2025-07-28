import 'dart:io';
import 'dart:typed_data';

import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:bingo_firebase_example/core/services/firebase_service.dart';
import 'package:bingo_firebase_example/features/home/data/dataSources/remote/note_remote_data_sources.dart';
import 'package:dartz/dartz.dart';

class NoteRemoteDataSourcesImpl implements NoteRemoteDataSources {
  final AppFirebaseService _appFirebaseService;
  NoteRemoteDataSourcesImpl(this._appFirebaseService);

  @override
  Future<Either<AppFirebaseFailure, Unit>> addNote(
    String noteTitle,
    String noteDescription,
    File? noteImageFile,
    Uint8List? webImageBytes
  ) async {
    return await _appFirebaseService.addNote(
      noteDescription,
      noteTitle,
      noteImageFile,
    webImageBytes
    );
  }
}
