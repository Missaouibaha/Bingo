import 'package:bingo_firebase_example/features/home/domain/entities/note_entity.dart';
import 'package:bingo_firebase_example/features/home/presentation/providers/watch_notes_stream_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredNotesProvider = Provider<AsyncValue<List<NoteEntity>>>((ref) {
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();
  final notesAsync = ref.watch(notesStreamProvider);

  return notesAsync.whenData((notes) {
    if (searchQuery.isEmpty || searchQuery.length < 2) return notes ?? [];

    return (notes ?? []).where((note) {
      final title = note.title?.toLowerCase() ?? '';
      final description = note.description?.toLowerCase() ?? '';
      return title.contains(searchQuery) || description.contains(searchQuery);
    }).toList();
  });
});
