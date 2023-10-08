import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_apple_usecase/login_with_apple_usecase.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_google_usecase/login_with_google_usecase.dart';
import 'package:kikagada/modules/auth/presenter/states/login_state.dart';
import 'package:kikagada/shared/components/error_dialog_component.dart';

class LoginStore extends ValueNotifier<LoginState> {
  final ILoginWithGoogleUsecase _loginWithGoogleUsecase;
  final ILoginWithAppleUsecase _loginWithAppleUsecase;

  LoginStore(this._loginWithGoogleUsecase, this._loginWithAppleUsecase)
      : super(LoginInitialState());

  Future<void> loginWithGoogle(
    BuildContext context,
    void Function(UserEntity user) onLogin,
  ) async {
    value = LoginLoadingState();

    final (user, error) = await _loginWithGoogleUsecase();

    if (error != null) {
      value = LoginErrorState(error: error);
      showDialog(
        context: context,
        builder: (BuildContext ctx) => ErrorDialogComponent(
          errorMessage: error.message ?? error.error,
        ),
      );
    }

    if (user != null) {
      value = LoginSuccessState(user: user);
      onLogin(user);
    }
  }

  Future<void> loginWithApple(
    BuildContext context,
    void Function(UserEntity user) onLogin,
  ) async {
    value = LoginLoadingState();

    final (user, error) = await _loginWithAppleUsecase();

    if (error != null) {
      value = LoginErrorState(error: error);
    }

    if (user != null) {
      value = LoginSuccessState(user: user);
      onLogin(user);
    }
  }

  void verifyAuthState(void Function(UserEntity user) onAuthenticated) {
    FirebaseAuth.instance.authStateChanges().listen((User? fireUser) async {
      if (fireUser != null) {
        onAuthenticated(UserEntity(
          id: fireUser.uid,
          email: fireUser.email!,
          name: fireUser.displayName!,
          photo: fireUser.photoURL,
        ));
      }
    });
  }
}
