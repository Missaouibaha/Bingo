import 'dart:io';
import 'dart:typed_data';

import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:bingo_firebase_example/features/home/data/dataSources/mappers/note_mapper.dart';
import 'package:bingo_firebase_example/features/home/data/dataSources/remote/note_remote_data_sources.dart';
import 'package:bingo_firebase_example/features/home/domain/entities/note_entity.dart';
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
    return await _remote.addNote(
      noteTitle,
      noteDescription,
      noteImageFile,
      webImageBytes,
    );
  }

  @override
  Future<Either<AppFirebaseFailure, List<NoteEntity>?>> getNotes() async {
    final notesModels = await _remote.getNotes();

    return notesModels.fold(
      (fireBaseFailure) {
        return Left(fireBaseFailure);
      },
      (notes) {
        final notesEntities =
            notes?.map((note) {
              return note.toDomain();
            }).toList() ??
            [];

        return Right(notesEntities);
      },
    );
  }

  @override
  Stream<Either<AppFirebaseFailure, List<NoteEntity>>> watchNotes() {
    return _remote.watchNotes().map((either) {
      return either.fold(
        (failure) {
          return Left(failure);
        },
        (notes) {
          return Right(notes.map((note) => note.toDomain()).toList());
        },
      );
    });
  }

  @override
  Future<Either<AppFirebaseFailure, Unit>> update(NoteEntity note) {
    return _remote.updateNote(note.toNoteModel());
  }

  @override
  Future<Either<AppFirebaseFailure, Unit>> delete(String noteId,bool deleteAll) {
    return _remote.deleteNote(noteId, deleteAll);
  }
}
