sealed class AuthError extends Error {
  final String error;
  final String? message;

  AuthError({
    required this.error,
    this.message,
  });
}

final class GenericAuthError extends AuthError {
  GenericAuthError({
    required super.error,
    required super.message,
  });
}

final class GenericFirebaseAuthError extends AuthError {
  GenericFirebaseAuthError({
    required super.error,
    required super.message,
  });
}
