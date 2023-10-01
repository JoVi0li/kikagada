import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';

sealed class LoginState {}

class InitialLoginState implements LoginState {}

class LoadingLoginState implements LoginState {}

class SuccessLoginState implements LoginState {
  final UserEntity user;
  SuccessLoginState({required this.user});
}

class ErrorLoginState implements LoginState {
  final AuthError error;
  ErrorLoginState({required this.error});
}
