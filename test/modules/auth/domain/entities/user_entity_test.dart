import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';

void main() {
  late final UserEntity user;

  setUpAll(() {
    user = UserEntity(
      id: '01',
      name: 'João Vitor de Oliveira',
      email: 'jaguatirica.0123@gmail.com',
      photo: null,
    );
  });

  group('user entity tests...', () {
    test('Should create correctly a entity copy from UserEntity', () {
      expect(user.copyWith(), isA<UserEntity>());
    });

    test('Should thrown an assertion error when id is empty', () {
      expect(() => user.copyWith(id: ''), throwsAssertionError);
    });

    test('Should thrown an assertion error when name is empty', () {
      expect(() => user.copyWith(name: ''), throwsAssertionError);
    });

    test('Should thrown an assertion error when email is empty', () {
      expect(() => user.copyWith(email: ''), throwsAssertionError);
    });

    test(
        'Should thrown an assertion error when email does not contain a @ character',
        () {
      expect(
          () => user.copyWith(email: 'joao_email.com'), throwsAssertionError);
    });
  });
}
