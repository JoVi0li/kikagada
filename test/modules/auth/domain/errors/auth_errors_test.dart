import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';

void main() {
  group('auth errors tests...', () {

    test('Should create correctly a GenericAuthError entity', () {
      expect(GenericAuthError(error: 'Error'), isA<GenericAuthError>());
    });
    
    test('Should create correctly a GenericFirebaseAuthError entity', () {
      expect(GenericFirebaseAuthError(error: 'Error'), isA<GenericFirebaseAuthError>());
    });

    test(
        'Should thrown an assertion error when GenericAuthError.error is empty',
        () {
      expect(() => GenericAuthError(error: ''), throwsAssertionError);
    });

    test(
        'Should thrown an assertion error when GenericFirebaseAuthError.error is empty',
        () {
      expect(() => GenericFirebaseAuthError(error: ''), throwsAssertionError);
    });
  });
}
