import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

abstract interface class IAuthRepository {
  Future<(UserEntity? user, BaseException? error)> loginWithGoogle();
  Future<(UserEntity? user, BaseException? error)> loginWithApple();
  Future<(UserEntity? deletedUser, BaseException? failure)> getUser();
  Future<(UserEntity? deletedUser, BaseException? failure)> deleteAccount();
}
