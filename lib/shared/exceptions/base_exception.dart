import 'package:get_it/get_it.dart';
import 'package:kikagada/shared/exceptions/crashlytics.dart';

sealed class BaseException implements Exception {
  final Exception exception;
  final StackTrace stackTrace;
  final String? message;

  BaseException({
    required this.exception,
    required this.stackTrace,
    this.message,
  });

  factory BaseException.basicException({
    required final Exception exception,
    required final StackTrace stackTrace,
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
    required final StackTrace stackTrace,
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
    required super.stackTrace,
    super.message,
  }) {
    GetIt.instance<ICrashlytics>().recordError(exception, stackTrace, null);
  }
}

final class FirebaseException extends BaseException {
  FirebaseException({
    required super.exception,
    required super.stackTrace,
    super.message,
  }) {
    GetIt.instance<ICrashlytics>().recordError(exception, stackTrace, null);
  }
}
