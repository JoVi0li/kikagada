import 'package:kikagada/shared/exceptions/base_exception.dart';

abstract base class LoginState {}

final class LoginInitialState implements LoginState {}

final class LoginLoadingState implements LoginState {}

final class LoginSuccessState implements LoginState {}

final class LoginErrorState implements LoginState {
  final BaseException error;
  LoginErrorState({required this.error});
}
