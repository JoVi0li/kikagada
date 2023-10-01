import 'package:firebase_auth/firebase_auth.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/infra/datasources/auth_datasource.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthDatasource _datasource;

  AuthRepositoryImp({required AuthDatasource datasource})
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
}
