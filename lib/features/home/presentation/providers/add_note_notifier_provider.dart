import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bingo_firebase_example/features/home/domain/providers/note_domain_providers.dart';
import 'package:bingo_firebase_example/features/home/domain/useCases/add_note_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNoteNotifierProvider extends AutoDisposeAsyncNotifier<Unit> {
  AddNoteUsecase? _addNoteUsecase;
  @override
  FutureOr<Unit> build() async {
    _addNoteUsecase = await ref.read(addNoteUseCaseProvider.future);
    return unit;
  }

  Future<void> addNote(
    String noteTitle,
    String noteDescription,
    File? noteImageFile,
    Uint8List? webImageBytes,
  ) async {
    state = AsyncValue.loading();

    final result = await _addNoteUsecase?.call(
      noteTitle,
      noteDescription,
      noteImageFile,
      webImageBytes,
    );

    result?.fold(
      (exception) {
        state = AsyncValue.error(
          exception.message ?? exception.toString(),
          StackTrace.current,
        );
      },
      (_) {
        state = AsyncValue.data(unit);
      },
    );
  }
}

final addNoteNotifierProvider =
    AsyncNotifierProvider.autoDispose<AddNoteNotifierProvider, Unit>(() {
      return AddNoteNotifierProvider();
    });
