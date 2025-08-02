import 'package:bingo_firebase_example/core/services/app_firebase_failure.dart';
import 'package:bingo_firebase_example/features/home/domain/entities/note_entity.dart';
import 'package:bingo_firebase_example/features/home/domain/repository/note_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateNoteUseCase {
  final NoteRepository _noteRepository;
  UpdateNoteUseCase(this._noteRepository);

  Future<Either<AppFirebaseFailure, Unit>> call(NoteEntity note) async {
    return await _noteRepository.update(note);
  }
}
