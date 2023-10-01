import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/rank/domain/errors/rank_errors.dart';

void main() {
  group('rank errors tests', () {
    test('should throw an assertion error when error property is empty', () {
      void createGenericRankError() {
        GenericRankError(error: '');
      }

      expect(createGenericRankError, throwsAssertionError);
    });

    test('should throw an assertion error when error property is empty', () {
      void createGenericRankError() {
        FirebaseRankError(error: '');
      }

      expect(createGenericRankError, throwsAssertionError);
    });

    test('should create an instance of GenericRankError', () {
      expect(GenericRankError(error: 'error'), isA<GenericRankError>());
    });

    test('should create an instance of FirebaseRankError', () {
      expect(FirebaseRankError(error: 'error'), isA<FirebaseRankError>());
    });
  });
}
