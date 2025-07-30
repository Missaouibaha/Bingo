import 'package:bingo_firebase_example/features/home/presentation/providers/watch_notes_stream_notifier.dart';
import 'package:bingo_firebase_example/features/home/presentation/widgets/notes/item_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteListWidget extends ConsumerWidget {
  const NoteListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesState = ref.watch(notesStreamProvider);

    return notesState.when(
      loading: () {
        return SizedBox();
      },
      data: (data) {
        final notes = data ?? [];
        return ListView.builder(
          itemCount: notes.length,
          scrollDirection: Axis.vertical,

          itemBuilder: (context, index) {
            return ItemNote(note: notes.elementAt(index));
          },
        );
      },
      error: (error, stackTrace) {
        return SizedBox();
      },
    );
  }
}
