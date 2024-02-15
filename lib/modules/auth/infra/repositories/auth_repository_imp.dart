import 'package:firebase_auth/firebase_auth.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

final class AuthRepositoryImp implements IAuthRepository {
  final IAuthDatasource _datasource;

  AuthRepositoryImp({required IAuthDatasource datasource})
      : _datasource = datasource;

  @override
  Future<(UserEntity? user, BaseException? error)> loginWithApple() async {
    try {
      final result = await _datasource.loginWithApple();
      return (result, null);
    } on FirebaseAuthException catch (e, s) {
      return (
        null,
        BaseException.firebaseException(
          stackTrace: s,
          exception: e,
          message: e.message,
        ),
      );
    } catch (e, s) {
      return (
        null,
        BaseException.basicException(
          stackTrace: s,
          exception: e as Exception,
        ),
      );
    }
  }

  @override
  Future<(UserEntity? user, BaseException? error)> loginWithGoogle() async {
    try {
      final result = await _datasource.loginWithGoogle();
      return (result, null);
    } on FirebaseAuthException catch (e, s) {
      return (
        null,
        BaseException.firebaseException(
          stackTrace: s,
          exception: e,
          message: e.message,
        ),
      );
    } catch (e, s) {
      return (
        null,
        BaseException.basicException(
          stackTrace: s,
          exception: e as Exception,
        ),
      );
    }
  }

  @override
  Future<(UserEntity?, BaseException?)> deleteAccount() async {
    try {
      final result = await _datasource.deleteAccount();
      return (result, null);
    } on FirebaseAuthException catch (e, s) {
      return (
        null,
        BaseException.firebaseException(
          stackTrace: s,
          exception: e,
          message: e.message,
        ),
      );
    } catch (e, s) {
      return (
        null,
        BaseException.basicException(
          stackTrace: s,
          exception: e as Exception,
        ),
      );
    }
  }

  @override
  Future<(UserEntity?, BaseException?)> getUser() async {
    try {
      final result = await _datasource.getUser();
      return (result, null);
    } on FirebaseAuthException catch (e, s) {
      return (
        null,
        BaseException.firebaseException(
          stackTrace: s,
          exception: e,
          message: e.message,
        ),
      );
    } catch (e, s) {
      return (
        null,
        BaseException.basicException(
          stackTrace: s,
          exception: e as Exception,
        ),
      );
    }
  }
}
