import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:kikagada/modules/auth/infra/repositories/auth_repository_imp.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';
import 'package:mocktail/mocktail.dart';

class AuthDatasourceMock extends Mock implements IAuthDatasource {}

void main() {
  late final IAuthRepository repository;
  late final IAuthDatasource datasource;
  late final UserEntity entity;

  setUpAll(() {
    datasource = AuthDatasourceMock();
    repository = AuthRepositoryImp(datasource: datasource);
    entity = UserEntity(
      id: '01',
      name: 'João Vitor',
      email: 'joao@gmail.com',
      photo: null,
    );
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

    test(
        'should return a failure value when catch a generic exception while login with apple',
        () async {
      when(() => datasource.loginWithApple()).thenThrow(Exception(['error']));

      final (success, failure) = await repository.loginWithApple();

      expect(success, isNull);
      expect(failure, isA<BaseException>());
    });

    test(
        'should return a failure value when catch a firebase auth exception while login with apple',
        () async {
      when(() => datasource.loginWithApple()).thenThrow(
        FirebaseAuthException(code: 'error'),
      );

      final (success, failure) = await repository.loginWithApple();

      expect(success, isNull);
      expect(failure, isA<BaseException>());
    });

    test('should return a success value when login with google', () async {
      when(() => datasource.loginWithGoogle()).thenAnswer(
        (_) => Future.value(entity),
      );

      final (success, failure) = await repository.loginWithGoogle();

      expect(failure, isNull);
      expect(success, isA<UserEntity>());
    });

    test(
        'should return a failure value when catch a generic exception while login with google',
        () async {
      when(() => datasource.loginWithGoogle()).thenThrow(Exception(['error']));

      final (success, failure) = await repository.loginWithGoogle();

      expect(success, isNull);
      expect(failure, isA<BaseException>());
    });

    test(
        'should return a failure value when catch a firebase auth exception while login with google',
        () async {
      when(() => datasource.loginWithGoogle()).thenThrow(
        FirebaseAuthException(code: 'error'),
      );

      final (success, failure) = await repository.loginWithGoogle();

      expect(success, isNull);
      expect(failure, isA<BaseException>());
    });

    test('should return a success value when delete account', () async {
      when(() => datasource.deleteAccount()).thenAnswer(
        (_) => Future.value(entity),
      );

      final (success, failure) = await repository.deleteAccount();

      expect(failure, isNull);
      expect(success, isA<UserEntity>());
    });

    test(
        'should return a failure value when catch a generic exception while delete account',
        () async {
      when(() => datasource.deleteAccount()).thenThrow(
        Exception('error'),
      );

      final (success, failure) = await repository.deleteAccount();

      expect(success, isNull);
      expect(failure, isA<BaseException>());
    });

    test(
        'should return a failure value when catch a firebase auth exception while delete account',
        () async {
      when(() => datasource.deleteAccount()).thenThrow(
        FirebaseAuthException(code: 'error'),
      );

      final (success, failure) = await repository.deleteAccount();

      expect(success, isNull);
      expect(failure, isA<BaseException>());
    });

    test('should return a success value when get user', () async {
      when(() => datasource.getUser()).thenAnswer(
        (_) => Future.value(entity),
      );

      final (success, failure) = await repository.getUser();

      expect(failure, isNull);
      expect(success, isA<UserEntity>());
    });

    test(
        'should return a failure value when catch a generic exception while get user',
        () async {
      when(() => datasource.getUser()).thenThrow(Exception('error'));

      final (success, failure) = await repository.getUser();

      expect(success, isNull);
      expect(failure, isA<BaseException>());
    });

    test(
        'should return a failure value when catch a firebase auth exception while get user',
        () async {
      when(() => datasource.getUser()).thenThrow(
        FirebaseAuthException(code: 'error'),
      );

      final (success, failure) = await repository.getUser();

      expect(success, isNull);
      expect(failure, isA<BaseException>());
    });
  });
}
