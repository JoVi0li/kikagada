sealed class AuthError extends Error {
  final String error;
  final String? message;

  AuthError({
    required this.error,
    this.message,
  }) : assert(error.isNotEmpty, 'message property can not be empty');
}

final class GenericAuthError extends AuthError {
  GenericAuthError({
    required super.error,
    super.message,
  });
}

final class GenericFirebaseAuthError extends AuthError {
  GenericFirebaseAuthError({
    required super.error,
    super.message,
  });
}
