import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:bingo_firebase_example/features/home/domain/repository/note_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteNoteUsecase {
  final NoteRepository _noteRepository;

  DeleteNoteUsecase(this._noteRepository);

  Future<Either<AppFirebaseFailure, Unit>> call(String noteId, bool deleteAll) async {
    return await _noteRepository.delete(noteId,deleteAll);
  }
}
