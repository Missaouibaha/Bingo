import 'package:bingo_firebase_example/features/auth/data/providers/auth_data_provider.dart';
import 'package:bingo_firebase_example/features/auth/domain/usecases/register_use_case.dart';
import 'package:bingo_firebase_example/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authSignInUseCaseProvider = FutureProvider<SignInUseCase>((ref) async {
  final repository = await ref.read(repositoryProvider.future);
  return SignInUseCase(repository);
});
final authRegisterUseCaseProvider = FutureProvider<RegisterUseCase>((
  ref,
) async {
  final repository = await ref.read(repositoryProvider.future);
  return RegisterUseCase(repository);
});
