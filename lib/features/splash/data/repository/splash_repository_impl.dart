import 'package:bingo_firebase_example/features/splash/data/datasources/remote/splash_remote.dart';
import 'package:bingo_firebase_example/features/splash/domain/repository/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashRemote _splashRemote;
  SplashRepositoryImpl(this._splashRemote);
  @override
  Future<bool> isLoggedIn() {
    return _splashRemote.isLoggedIn();
  }
}
