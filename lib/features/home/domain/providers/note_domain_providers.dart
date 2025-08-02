import 'package:bingo_firebase_example/features/home/data/providers/note_data_providers.dart';
import 'package:bingo_firebase_example/features/home/domain/useCases/add_note_usecase.dart';
import 'package:bingo_firebase_example/features/home/domain/useCases/delete_note_usecase.dart';
import 'package:bingo_firebase_example/features/home/domain/useCases/get_notes_usecase.dart';
import 'package:bingo_firebase_example/features/home/domain/useCases/update_note_usecase.dart';
import 'package:bingo_firebase_example/features/home/domain/useCases/watch_note_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addNoteUseCaseProvider = FutureProvider<AddNoteUsecase>((ref) async {
  final noteRepository = await ref.read(noteRepositoryProvider.future);
  return AddNoteUsecase(noteRepository);
});

final getNotesUseCaseProvider = FutureProvider<GetNotesUsecase>((ref) async {
  final noteRepository = await ref.read(noteRepositoryProvider.future);
  return GetNotesUsecase(noteRepository);
});

final watchNotesUseCaseProvider = FutureProvider<WatchNoteUsecase>((ref) async {
  final noteRepository = await ref.watch(noteRepositoryProvider.future);
  return WatchNoteUsecase(noteRepository);
});

final updateNoteUseCaseProvider = FutureProvider<UpdateNoteUseCase>((
  ref,
) async {
  final noteRepository = await ref.read(noteRepositoryProvider.future);
  return UpdateNoteUseCase(noteRepository);
});


final deleteNoteUseCaseProvider = FutureProvider<DeleteNoteUsecase>((
  ref,
) async {
  final noteRepository = await ref.read(noteRepositoryProvider.future);
  return DeleteNoteUsecase(noteRepository);
});
