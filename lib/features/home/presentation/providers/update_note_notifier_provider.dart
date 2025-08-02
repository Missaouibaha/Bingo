import 'dart:async';

import 'package:bingo_firebase_example/features/home/domain/entities/note_entity.dart';
import 'package:bingo_firebase_example/features/home/domain/providers/note_domain_providers.dart';
import 'package:bingo_firebase_example/features/home/domain/useCases/update_note_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateNoteNotifierProvider extends AsyncNotifier<Unit> {
  late UpdateNoteUseCase _updateNoteUseCase;
  @override
  FutureOr<Unit> build() async {
    _updateNoteUseCase = await ref.read(updateNoteUseCaseProvider.future);
    return unit;
  }

  Future<void> updateNote(NoteEntity note) async {
    state = AsyncValue.loading();
    final result = await _updateNoteUseCase.call(note);
    result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (success) {
        state = AsyncValue.data(success);
      },
    );
  }
}

final updateNoteNotifierProvider =
    AsyncNotifierProvider<UpdateNoteNotifierProvider, Unit>(() {
      return UpdateNoteNotifierProvider();
    });
