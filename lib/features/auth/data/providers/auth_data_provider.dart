import 'package:bingo_firebase_example/core/base/base_providers.dart';
import 'package:bingo_firebase_example/features/auth/data/datasources/remote/auth_remote.dart';
import 'package:bingo_firebase_example/features/auth/data/datasources/remote/auth_remote_impl.dart';
import 'package:bingo_firebase_example/features/auth/data/repository/auth_repository_impl.dart';
import 'package:bingo_firebase_example/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final remoteAuthProvider = FutureProvider<AuthRemote>((ref) async {
  final authService = ref.read(authServiceProvider);
  return AuthRemoteImpl(authService);
});

final repositoryProvider = FutureProvider<AuthRepository>((ref) async {
  final remote = await ref.read(remoteAuthProvider.future);
  return AuthRepositoryImpl(remote);
});
