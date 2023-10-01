import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';

abstract class AuthDatasource {
  Future<UserEntity> loginWithGoogle();
  Future<UserEntity> loginWithApple();
}
