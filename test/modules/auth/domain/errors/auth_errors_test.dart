import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

void main() {
  group('auth errors tests...', () {
    test('Should create correctly a BasicException entity', () {
      expect(
     BaseException.basicException(exception: Exception("error"), stackTrace: StackTrace.fromString("")),
        isA<BasicException>(),
      );
    });

    test('Should create correctly a FirebaseException entity', () {
      expect(
        BaseException.firebaseException(exception: Exception(), message: 'Error', stackTrace: StackTrace.fromString("")),
        isA<FirebaseException>(),
      );
    });
  });
}
