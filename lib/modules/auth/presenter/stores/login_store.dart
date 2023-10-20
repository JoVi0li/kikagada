import 'package:flutter/foundation.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_apple_usecase/login_with_apple_usecase.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_google_usecase/login_with_google_usecase.dart';
import 'package:kikagada/modules/auth/presenter/states/login_state.dart';

class LoginStore extends ValueNotifier<LoginState> {
  final ILoginWithGoogleUsecase _loginWithGoogleUsecase;
  final ILoginWithAppleUsecase _loginWithAppleUsecase;

  LoginStore(this._loginWithGoogleUsecase, this._loginWithAppleUsecase)
      : super(LoginInitialState());

  Future<void> login() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return await _loginWithGoogle();
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return await _loginWithApple();
    }
  }

  Future<void> _loginWithGoogle() async {
    value = LoginLoadingState();

    final (user, error) = await _loginWithGoogleUsecase();

    if (error != null) {
      value = LoginErrorState(error: error);
    }

    if (user != null) {
      value = LoginSuccessState();
    }
  }

  Future<void> _loginWithApple() async {
    value = LoginLoadingState();

    final (user, error) = await _loginWithAppleUsecase();

    if (error != null) {
      value = LoginErrorState(error: error);
    }

    if (user != null) {
      value = LoginSuccessState();
    }
  }
}
