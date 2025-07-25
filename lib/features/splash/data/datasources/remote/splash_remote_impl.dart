import 'package:bingo_firebase_example/core/services/auth_service.dart';
import 'package:bingo_firebase_example/features/splash/data/datasources/remote/splash_remote.dart';

class SplashRemoteImpl implements SplashRemote {
  final AuthService _authService;
  SplashRemoteImpl(this._authService);
  @override
  Future<bool> isLoggedIn() async {
    return _authService.isUserLoggedIn();
  }
}
