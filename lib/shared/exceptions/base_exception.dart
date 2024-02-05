sealed class BaseException implements Exception {
  final Exception exception;
  final StackTrace? stackTrace;
  final String? message;

  BaseException({
    required this.exception,
    this.stackTrace,
    this.message,
  });


  factory BaseException.basicException({
    required final Exception exception,
    final StackTrace? stackTrace,
    final String? message,
  }) {
    return BasicException(
      exception: exception,
      stackTrace: stackTrace,
      message: message,
    );
  }

  factory BaseException.firebaseException({
    required final Exception exception,
    final StackTrace? stackTrace,
    final String? message,
  }) {
    return FirebaseException(
      exception: exception,
      stackTrace: stackTrace,
      message: message,
    );
  }
}

final class BasicException extends BaseException {
  BasicException({
    required super.exception,
    super.stackTrace,
    super.message,
  });
}

final class FirebaseException extends BaseException {
  FirebaseException({
    required super.exception,
    super.stackTrace,
    super.message,
  });
}
