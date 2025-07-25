import 'package:bingo_firebase_example/features/splash/domain/repository/splash_repository.dart';

class IsLoggedInUseCase {
  final SplashRepository _splashRepository;

  IsLoggedInUseCase(this._splashRepository);

  Future<bool> call() {
    return _splashRepository.isLoggedIn();
  }
}
