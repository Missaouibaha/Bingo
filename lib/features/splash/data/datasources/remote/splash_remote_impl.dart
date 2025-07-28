import 'package:bingo_firebase_example/core/services/firebase_service.dart';
import 'package:bingo_firebase_example/features/splash/data/datasources/remote/splash_remote.dart';

class SplashRemoteImpl implements SplashRemote {
  final AppFirebaseService _authService;
  SplashRemoteImpl(this._authService);
  @override
  Future<bool> isLoggedIn() async {
    return _authService.isUserLoggedIn();
  }
}
