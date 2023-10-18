
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';

abstract interface class IGetUserUsecase {
  Future<(UserEntity? deletedUser, AuthError? failure)> call();
}