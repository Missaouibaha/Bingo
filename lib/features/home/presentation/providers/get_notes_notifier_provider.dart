import 'dart:async';

import 'package:bingo_firebase_example/features/home/domain/entities/note_entity.dart';
import 'package:bingo_firebase_example/features/home/domain/providers/note_domain_providers.dart';
import 'package:bingo_firebase_example/features/home/domain/useCases/get_notes_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetNotesNotifierProvider
    extends AutoDisposeAsyncNotifier<List<NoteEntity>?> {
  GetNotesUsecase? _getNotesUsecase;

  @override
  FutureOr<List<NoteEntity>?> build() async {
    _getNotesUsecase = await ref.read(getNotesUseCaseProvider.future);
    return await getNotes();
  }

  Future<List<NoteEntity>?> getNotes() async {
    state = AsyncLoading();

    final result = await _getNotesUsecase?.call();

    return result?.fold(
      (appFirebaseFailure) {
        state = AsyncValue.error(
          appFirebaseFailure.message,
          StackTrace.current,
        );
        return [];
      },
      (notes) {
        state = AsyncValue.data(notes);
        return notes;
      },
    );
  }
}

final notesNotifierProvider = AsyncNotifierProvider.autoDispose<
  GetNotesNotifierProvider,
  List<NoteEntity>?
>(() {
  return GetNotesNotifierProvider();
});
