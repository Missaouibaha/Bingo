import 'package:bingo_firebase_example/core/base/base_providers.dart';
import 'package:bingo_firebase_example/features/home/data/dataSources/remote/note_remote_data_sources.dart';
import 'package:bingo_firebase_example/features/home/data/dataSources/remote/note_remote_data_sources_impl.dart';
import 'package:bingo_firebase_example/features/home/data/repository/note_repository_impl.dart';
import 'package:bingo_firebase_example/features/home/domain/repository/note_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noteRemoteDataProvider = FutureProvider<NoteRemoteDataSources>((
  ref,
) async {
  final appFireBaseService = ref.read(fireBaseServiceProvider);
  return NoteRemoteDataSourcesImpl(appFireBaseService);
});

final noteRepositoryProvider = FutureProvider<NoteRepository>((ref) async {
  final noteRemote = await ref.read(noteRemoteDataProvider.future);
  return NoteRepositoryImpl(noteRemote);
});
