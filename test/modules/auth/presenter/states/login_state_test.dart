import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';
import 'package:kikagada/modules/auth/presenter/states/login_state.dart';

void main() {
  late final UserEntity entity;
  late final AuthError error;

  setUpAll(() {
    entity = UserEntity(
      id: '01',
      name: 'João Vitor',
      email: 'joao@gmail.com',
      photo: null,
    );
    error = GenericAuthError(error: 'Error');
  });

  group('login state tests', () {
    test('LoginInitialState should be a subclass of LoginState', () {
      expect(LoginInitialState(), isA<LoginState>());
    });

    test('LoginLoadingState should be a subclass of LoginState', () {
      expect(LoginLoadingState(), isA<LoginState>());
    });

    test('LoginSuccessState should be a subclass of LoginState', () {
      expect(LoginSuccessState(user: entity), isA<LoginState>());
    });

    test('LoginErrorState should be a subclass of LoginState', () {
      expect(LoginErrorState(error: error), isA<LoginState>());
    });
  });
}
