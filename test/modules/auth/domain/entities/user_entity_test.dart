import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';

void main() {
  group('user entity tests', () {
    test('should create an instance', () {
      expect(
        UserEntity(
          id: '01',
          name: 'João Vitor',
          email: 'joao@email.com',
          photo: null,
        ),
        isA<UserEntity>(),
      );
    });

    test('should create an instance from a Map', () {
      expect(
        UserEntity.fromMap({
          'id': '01',
          'name': 'João Vitor',
          'email': 'joao@email.com',
          'photo': null,
        }),
        isA<UserEntity>(),
      );
    });

    test('should create a copy of the instance', () {
      final originalInstance = UserEntity(
        id: '01',
        name: 'João Vitor',
        email: 'joao@email.com',
        photo: null,
      );

      final copyInstance = originalInstance.copyWith();

      expect(
        copyInstance,
        isA<UserEntity>(),
      );
    });

    test(
        'should thrown an assertion error when try create an instance with empty id ',
        () {
      expect(
        () => UserEntity(
          id: '',
          name: 'João Vitor',
          email: 'joao@email.com',
          photo: null,
        ),
        throwsAssertionError,
      );
    });

    test(
        'should thrown an assertion error when try create an instance with empty name ',
        () {
      expect(
        () => UserEntity(
          id: '01',
          name: '',
          email: 'joao@email.com',
          photo: null,
        ),
        throwsAssertionError,
      );
    });

    test(
        'should thrown an assertion error when try create an instance with empty email ',
        () {
      expect(
        () => UserEntity(
          id: '01',
          name: 'João Vitor',
          email: '',
          photo: null,
        ),
        throwsAssertionError,
      );
    });

    test(
        'should thrown an assertion error when try create an instance with invalid email',
        () {
      expect(
        () => UserEntity(
          id: '01',
          name: 'João Vitor',
          email: 'joaoemail.com',
          photo: null,
        ),
        throwsAssertionError,
      );
    });
  });
}
