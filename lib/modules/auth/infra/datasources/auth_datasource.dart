import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';

abstract interface class IAuthDatasource {
  Future<UserEntity> loginWithGoogle();
  Future<UserEntity> loginWithApple();
  Future<UserEntity> getUser();
  Future<UserEntity> deleteAccount();
}
