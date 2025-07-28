import 'package:bingo_firebase_example/features/home/data/providers/note_data_providers.dart';
import 'package:bingo_firebase_example/features/home/domain/useCases/add_note_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addNoteUseCaseProvider = FutureProvider<AddNoteUsecase>((ref) async {
  final noteRepository = await ref.read(noteRepositoryProvider.future);
  return AddNoteUsecase(noteRepository);
});
