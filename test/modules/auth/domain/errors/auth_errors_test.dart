import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

void main() {
  group('auth errors tests...', () {
    test('Should create correctly a BasicException entity', () {
      expect(
        BaseException.basicException(exception: Exception(), message: 'Error'),
        isA<BasicException>(),
      );
    });

    test('Should create correctly a FirebaseException entity', () {
      expect(
        BaseException.firebaseException(exception: Exception(), message: 'Error'),
        isA<FirebaseException>(),
      );
    });
  });
}
