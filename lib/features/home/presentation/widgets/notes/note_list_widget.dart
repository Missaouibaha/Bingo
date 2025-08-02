import 'package:bingo_firebase_example/core/utils/app_strings.dart';
import 'package:bingo_firebase_example/core/widgets/app_loading_indicator.dart';
import 'package:bingo_firebase_example/features/home/presentation/providers/filtred_note_provider.dart';
import 'package:bingo_firebase_example/features/home/presentation/widgets/notes/item_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteListWidget extends ConsumerWidget {
  const NoteListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredNotesAsync = ref.watch(filteredNotesProvider);

    return filteredNotesAsync.when(
      loading: () => const AppLoadingIndicator(),
      error:
          (error, stack) =>
              Center(child: Text(' ${AppStrings.error} : $error')),
      data: (notes) {
        if (notes.isEmpty) return const Center(child: Text(AppStrings.noNotes));
        return ListView.builder(
          itemCount: notes.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => ItemNote(note: notes[index]),
        );
      },
    );
  }
}
