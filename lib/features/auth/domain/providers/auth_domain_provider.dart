import 'package:bingo_firebase_example/features/auth/data/providers/auth_data_provider.dart';
import 'package:bingo_firebase_example/features/auth/domain/usecases/change_password_use_case.dart';
import 'package:bingo_firebase_example/features/auth/domain/usecases/get_user_use_case.dart';
import 'package:bingo_firebase_example/features/auth/domain/usecases/logout_use_case.dart';
import 'package:bingo_firebase_example/features/auth/domain/usecases/register_use_case.dart';
import 'package:bingo_firebase_example/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:bingo_firebase_example/features/auth/domain/usecases/update_name_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authSignInUseCaseProvider = FutureProvider<SignInUseCase>((ref) async {
  final repository = await ref.read(authRepositoryProvider.future);
  return SignInUseCase(repository);
});
final authRegisterUseCaseProvider = FutureProvider<RegisterUseCase>((
  ref,
) async {
  final repository = await ref.read(authRepositoryProvider.future);
  return RegisterUseCase(repository);
});

final getUserUseCaseProvider = FutureProvider<GetUserUseCase>((ref) async {
  final repository = await ref.read(authRepositoryProvider.future);
  return GetUserUseCase(repository);
});

final updateNameUseCaseProvider = FutureProvider<UpdateNameUseCase>((
  ref,
) async {
  final repo = await ref.read(authRepositoryProvider.future);
  return UpdateNameUseCase(repo);
});

final changePasswordUseCaseProvider = FutureProvider<ChangePasswordUseCase>((
  ref,
) async {
  final repo = await ref.read(authRepositoryProvider.future);
  return ChangePasswordUseCase(repo);
});

final logoutUseCaseProvider = FutureProvider<LogoutUseCase>((ref) async {
  final repo = await ref.read(authRepositoryProvider.future);
  return LogoutUseCase(repo);
});
