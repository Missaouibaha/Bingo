import 'package:bingo_firebase_example/features/splash/data/providers/splash_data_provider.dart';
import 'package:bingo_firebase_example/features/splash/domain/usecase/is_logged_in_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoggedInUseCaseProvider = FutureProvider<IsLoggedInUseCase>((
  ref,
) async {
  final spalshRepo = await ref.read(splashRepositoryProvider.future);
  return IsLoggedInUseCase(spalshRepo);
});
