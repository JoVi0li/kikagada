import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:kikagada/modules/auth/infra/repositories/auth_repository_imp.dart';
import 'package:mocktail/mocktail.dart';

class AuthDatasourceMock extends Mock implements IAuthDatasource {}

void main() {
  late final IAuthRepository repository;
  late final IAuthDatasource datasource;
  late final UserEntity entity;
  late final AuthError error;

  setUpAll(() {
    datasource = AuthDatasourceMock();
    repository = AuthRepositoryImp(datasource: datasource);
    entity = UserEntity(
      id: '01',
      name: 'João Vitor',
      email: 'joao@gmail.com',
      photo: null,
    );
    error = GenericAuthError(error: 'Error');
  });

  group('auth repository imp tests', () {
    test('should return a success value when login with apple', () async {
      when(() => datasource.loginWithApple()).thenAnswer(
        (_) => Future.value(entity),
      );

      final (success, failure) = await repository.loginWithApple();

      expect(failure, isNull);
      expect(success, isA<UserEntity>());
    });

    test('should return a failure value when login with apple', () async {
      when(() => datasource.loginWithApple()).thenThrow(
        (_) => Future.value(error),
      );

      final (success, failure) = await repository.loginWithApple();

      expect(success, isNull);
      expect(failure, isA<AuthError>());
    });

    test('should return a success value when login with google', () async {
      when(() => datasource.loginWithGoogle()).thenAnswer(
        (_) => Future.value(entity),
      );

      final (success, failure) = await repository.loginWithGoogle();

      expect(failure, isNull);
      expect(success, isA<UserEntity>());
    });

    test('should return a failure value when login with google', () async {
      when(() => datasource.loginWithGoogle()).thenThrow(
        (_) => Future.value(error),
      );

      final (success, failure) = await repository.loginWithGoogle();

      expect(success, isNull);
      expect(failure, isA<AuthError>());
    });
  });
}
