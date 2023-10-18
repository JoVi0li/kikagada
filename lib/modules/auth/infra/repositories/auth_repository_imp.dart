import 'package:firebase_auth/firebase_auth.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/infra/datasources/auth_datasource.dart';

final class AuthRepositoryImp implements IAuthRepository {
  final IAuthDatasource _datasource;

  AuthRepositoryImp({required IAuthDatasource datasource})
      : _datasource = datasource;

  @override
  Future<(UserEntity? user, AuthError? error)> loginWithApple() async {
    try {
      final result = await _datasource.loginWithApple();
      return (result, null);
    } on FirebaseAuthException catch (e) {
      return (
        null,
        GenericFirebaseAuthError(
          error: e.code,
          message: e.message,
        ),
      );
    } catch (e) {
      return (
        null,
        GenericAuthError(
          error: e.toString(),
          message: null,
        ),
      );
    }
  }

  @override
  Future<(UserEntity? user, AuthError? error)> loginWithGoogle() async {
    try {
      final result = await _datasource.loginWithGoogle();
      return (result, null);
    } on FirebaseAuthException catch (e) {
      return (
        null,
        GenericFirebaseAuthError(
          error: e.code,
          message: e.message,
        ),
      );
    } catch (e) {
      return (
        null,
        GenericAuthError(
          error: e.toString(),
          message: null,
        ),
      );
    }
  }

  @override
  Future<(UserEntity?, AuthError?)> deleteAccount() async {
    try {
      final result = await _datasource.deleteAccount();
      return (result, null);
    } on FirebaseAuthException catch (e) {
      return (
        null,
        GenericFirebaseAuthError(
          error: e.code,
          message: e.message,
        ),
      );
    } catch (e) {
      return (
        null,
        GenericAuthError(
          error: e.toString(),
          message: null,
        ),
      );
    }
  }

  @override
  Future<(UserEntity?, AuthError?)> getUser() async {
    try {
      final result = await _datasource.getUser();
      return (result, null);
    } on FirebaseAuthException catch (e) {
      return (
        null,
        GenericFirebaseAuthError(
          error: e.code,
          message: e.message,
        ),
      );
    } catch (e) {
      return (
        null,
        GenericAuthError(
          error: e.toString(),
          message: null,
        ),
      );
    }
  }
}
