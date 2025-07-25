import 'package:bingo_firebase_example/core/base/base_providers.dart';
import 'package:bingo_firebase_example/features/splash/data/datasources/remote/splash_remote.dart';
import 'package:bingo_firebase_example/features/splash/data/datasources/remote/splash_remote_impl.dart';
import 'package:bingo_firebase_example/features/splash/data/repository/splash_repository_impl.dart';
import 'package:bingo_firebase_example/features/splash/domain/repository/splash_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashRemoteDataProvider = FutureProvider<SplashRemote>((ref) async {
  final authoService = ref.read(authServiceProvider);
  return SplashRemoteImpl(authoService);
});

final splashRepositoryProvider = FutureProvider<SplashRepository>((ref) async {
  final splashRemote = await ref.read(splashRemoteDataProvider.future);
  return SplashRepositoryImpl(splashRemote);
});
