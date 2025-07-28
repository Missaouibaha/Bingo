import 'dart:io';
import 'dart:typed_data';

import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:bingo_firebase_example/features/home/data/dataSources/remote/note_remote_data_sources.dart';
import 'package:bingo_firebase_example/features/home/domain/repository/note_repository.dart';
import 'package:dartz/dartz.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteRemoteDataSources _remote;
  NoteRepositoryImpl(this._remote);

  @override
  Future<Either<AppFirebaseFailure, Unit>> addNote(
    String noteTitle,
    String noteDescription,
    File? noteImageFile,
    Uint8List? webImageBytes,
  ) async {
    return await _remote.addNote(noteTitle, noteDescription, noteImageFile,webImageBytes);
  }
}
