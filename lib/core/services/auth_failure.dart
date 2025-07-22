class AuthFailure {
  final String message;

  AuthFailure._(this.message);

  factory AuthFailure.invalidEmail() => AuthFailure._("Invalid email address.");
  factory AuthFailure.userDisabled() =>
      AuthFailure._("User account is disabled.");
  factory AuthFailure.userNotFound() =>
      AuthFailure._("No user found with this email.");
  factory AuthFailure.wrongPassword() => AuthFailure._("Wrong password.");
  factory AuthFailure.networkError() =>
      AuthFailure._("No internet connection.");
  factory AuthFailure.tooManyRequests() =>
      AuthFailure._("Too many login attempts. Try again later.");
  factory AuthFailure.unknown(String message) =>
      AuthFailure._("Unexpected error: $message");
  factory AuthFailure.invalidCredential() =>
      AuthFailure._("Invalid or expired credentials. Please try again.");

  static AuthFailure fromCode(String code, [String? message]) {
    switch (code) {
      case 'invalid-email':
        return AuthFailure.invalidEmail();
      case 'user-disabled':
        return AuthFailure.userDisabled();
      case 'user-not-found':
        return AuthFailure.userNotFound();
      case 'wrong-password':
        return AuthFailure.wrongPassword();
      case 'invalid-credential':
        return AuthFailure.invalidCredential();
      case 'network-request-failed':
        return AuthFailure.networkError();
      case 'too-many-requests':
        return AuthFailure.tooManyRequests();
      default:
        return AuthFailure.unknown(message ?? 'Unknown error');
    }
  }
}
