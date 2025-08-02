import 'dart:async';

import 'package:bingo_firebase_example/features/home/domain/providers/note_domain_providers.dart';
import 'package:bingo_firebase_example/features/home/domain/useCases/delete_note_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteNoteNotifierProvider extends AsyncNotifier<Unit> {
  late DeleteNoteUsecase _deleteNoteUsecase;

  @override
  FutureOr<Unit> build() async {
    _deleteNoteUsecase = await ref.read(deleteNoteUseCaseProvider.future);
    return unit;
  }

  Future<void> deleteNote(String noteId , bool deleteAll) async {
    final response = await _deleteNoteUsecase.call(noteId,deleteAll);
    state = AsyncValue.loading();
    response.fold(
      (failure) {
        AsyncValue.error(failure.message, StackTrace.current);
      },
      (success) {
        AsyncValue.data(success);
      },
    );
  }
}

final deleteNoteNotifierProvider =
    AsyncNotifierProvider<DeleteNoteNotifierProvider, Unit>(() {
      return DeleteNoteNotifierProvider();
    });
