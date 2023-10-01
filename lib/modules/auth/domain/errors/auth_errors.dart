sealed class AuthError extends Error {
  final String error;
  final String? message;

  AuthError({
    required this.error,
    this.message,
  });
}

class GenericAuthError extends AuthError {
  GenericAuthError({
    required super.error,
    required super.message,
  });
}

class GenericFirebaseAuthError extends AuthError {
  GenericFirebaseAuthError({
    required super.error,
    required super.message,
  });
}
