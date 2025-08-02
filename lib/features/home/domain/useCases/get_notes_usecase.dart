import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:bingo_firebase_example/features/home/domain/entities/note_entity.dart';
import 'package:bingo_firebase_example/features/home/domain/repository/note_repository.dart';
import 'package:dartz/dartz.dart';

class GetNotesUsecase {
  final NoteRepository _noteRepository;
  GetNotesUsecase(this._noteRepository);

  Future<Either<AppFirebaseFailure, List<NoteEntity>?>> call() async {
    return await _noteRepository.getNotes();
  }
}
