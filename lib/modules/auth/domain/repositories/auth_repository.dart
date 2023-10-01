import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';

abstract class AuthRepository {
  Future<(UserEntity? user, AuthError? error)> loginWithGoogle();
  Future<(UserEntity? user, AuthError? error)> loginWithApple();
}
