import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';

abstract base class LoginState {}

final class LoginInitialState implements LoginState {}

final class LoginLoadingState implements LoginState {}

final class LoginSuccessState implements LoginState {
  final UserEntity user;
  LoginSuccessState({required this.user});
}

final class LoginErrorState implements LoginState {
  final AuthError error;
  LoginErrorState({required this.error});
}
