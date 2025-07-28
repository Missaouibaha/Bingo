import 'package:bingo_firebase_example/core/services/firebase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fireBaseServiceProvider = Provider<AppFirebaseService>((ref) {
  return AppFirebaseService.instance;
});

final checkUserLoggedInProvider = Provider<bool>((ref) {
  final authService = ref.watch(fireBaseServiceProvider);
  return authService.isUserLoggedIn();
});
