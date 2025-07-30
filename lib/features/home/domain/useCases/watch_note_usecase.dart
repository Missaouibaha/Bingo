import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:bingo_firebase_example/features/home/domain/entities/note_entity.dart';
import 'package:bingo_firebase_example/features/home/domain/repository/note_repository.dart';
import 'package:dartz/dartz.dart';

class WatchNoteUsecase {
  final NoteRepository _noteRepository;
  WatchNoteUsecase(this._noteRepository);

  Stream<Either<AppFirebaseFailure, List<NoteEntity>>> call() {
    return _noteRepository.watchNotes();
  }
}
