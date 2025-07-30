import 'package:bingo_firebase_example/features/home/domain/entities/note_entity.dart';
import 'package:bingo_firebase_example/features/home/domain/providers/note_domain_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteStreamNotifier extends AutoDisposeStreamNotifier<List<NoteEntity>> {
  @override
  Stream<List<NoteEntity>> build() async* {
    final watchNoteUsecase = await ref.watch(watchNotesUseCaseProvider.future);
    yield* watchNoteUsecase.call().asyncMap((either) {
      return either.fold(
        (failure) {
          throw failure.message;
        },
        (notes) {
          return notes;
        },
      );
    });
  }
}

final notesStreamProvider =
    AutoDisposeStreamNotifierProvider<NoteStreamNotifier, List<NoteEntity>>(
      () => NoteStreamNotifier(),
    );
