class AppFirebaseFailure {
  final String message;

  AppFirebaseFailure._(this.message);

  // --- Auth-specific failures ---
  factory AppFirebaseFailure.invalidEmail() => AppFirebaseFailure._("Invalid email address.");
  factory AppFirebaseFailure.emailAlreadyInUse() =>
      AppFirebaseFailure._("This email is already in use.");
  factory AppFirebaseFailure.userDisabled() =>
      AppFirebaseFailure._("User account is disabled.");
  factory AppFirebaseFailure.userNotFound() =>
      AppFirebaseFailure._("No user found with this email.");
  factory AppFirebaseFailure.wrongPassword() => AppFirebaseFailure._("Wrong password.");
  factory AppFirebaseFailure.invalidCredential() =>
      AppFirebaseFailure._("Invalid or expired credentials.");
  factory AppFirebaseFailure.weakPassword() =>
      AppFirebaseFailure._("Password is too weak. Use at least 6 characters.");
  factory AppFirebaseFailure.operationNotAllowed() =>
      AppFirebaseFailure._("This operation is not allowed.");

  // --- Firestore/general failures ---
  factory AppFirebaseFailure.permissionDenied() =>
      AppFirebaseFailure._("You don't have permission to perform this operation.");
  factory AppFirebaseFailure.serverUnavailable() =>
      AppFirebaseFailure._("Server is unavailable. Please try again later.");
  factory AppFirebaseFailure.networkError() => AppFirebaseFailure._("No internet connection.");
  factory AppFirebaseFailure.notFound() =>
      AppFirebaseFailure._("Requested resource was not found.");
  factory AppFirebaseFailure.aborted() =>
      AppFirebaseFailure._("The operation was aborted. Try again.");
  factory AppFirebaseFailure.deadlineExceeded() =>
      AppFirebaseFailure._("The request took too long. Try again.");
  factory AppFirebaseFailure.invalidArgument() =>
      AppFirebaseFailure._("Invalid data provided.");

  factory AppFirebaseFailure.unknown(String message) =>
      AppFirebaseFailure._("Unexpected error: $message");

  static AppFirebaseFailure fromCode(String code, [String? message]) {
    switch (code) {
      // Auth codes
      case 'invalid-email':
        return AppFirebaseFailure.invalidEmail();
      case 'email-already-in-use':
        return AppFirebaseFailure.emailAlreadyInUse();
      case 'user-disabled':
        return AppFirebaseFailure.userDisabled();
      case 'user-not-found':
        return AppFirebaseFailure.userNotFound();
      case 'wrong-password':
        return AppFirebaseFailure.wrongPassword();
      case 'invalid-credential':
        return AppFirebaseFailure.invalidCredential();
      case 'weak-password':
        return AppFirebaseFailure.weakPassword();
      case 'operation-not-allowed':
        return AppFirebaseFailure.operationNotAllowed();

      // Common & Firestore codes
      case 'permission-denied':
        return AppFirebaseFailure.permissionDenied();
      case 'unavailable':
        return AppFirebaseFailure.serverUnavailable();
      case 'network-request-failed':
        return AppFirebaseFailure.networkError();
      case 'not-found':
        return AppFirebaseFailure.notFound();
      case 'aborted':
        return AppFirebaseFailure.aborted();
      case 'deadline-exceeded':
        return AppFirebaseFailure.deadlineExceeded();
      case 'invalid-argument':
        return AppFirebaseFailure.invalidArgument();

      default:
        return AppFirebaseFailure.unknown(message ?? 'Unknown error');
    }
  }
}
