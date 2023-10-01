import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_apple_usecase.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:kikagada/modules/auth/presenter/states/login_state.dart';
import 'package:kikagada/shared/components/error_dialog_component.dart';
import 'package:kikagada/shared/routes/home_routes.dart';

class LoginStore extends ValueNotifier<LoginState> {
  LoginStore(this._loginWithGoogleUsecase, this._loginWithAppleUsecase)
      : super(InitialLoginState());

  final LoginWithGoogleUsecase _loginWithGoogleUsecase;
  final LoginWithAppleUsecase _loginWithAppleUsecase;

  Future<void> loginWithGoogle(BuildContext context) async {
    value = LoadingLoginState();

    final (user, error) = await _loginWithGoogleUsecase();

    if (error != null) {
      value = ErrorLoginState(error: error);
      showDialog(
        context: context,
        builder: (BuildContext ctx) => ErrorDialogComponent(
          errorMessage: error.message ?? error.error,
        ),
      );
    }

    if (user != null) {
      value = SuccessLoginState(user: user);
      navigateToHomeScreen(context, user);
    }
  }

  Future<void> loginWithApple(BuildContext context) async {
    value = LoadingLoginState();

    final (user, error) = await _loginWithAppleUsecase();

    if (error != null) {
      value = ErrorLoginState(error: error);
      showDialog(
        context: context,
        builder: (BuildContext ctx) => ErrorDialogComponent(
          errorMessage: error.message ?? error.error,
        ),
      );
    }

    if (user != null) {
      value = SuccessLoginState(user: user);
      navigateToHomeScreen(context, user);
    }
  }

  void verifyAuthState(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        await navigateToHomeScreen(context, null);
      }
    });
  }

  Future<void> navigateToHomeScreen(
    BuildContext context,
    UserEntity? user,
  ) async {
    return await Navigator.pushNamedAndRemoveUntil<void>(
      context,
      HomeRoutes.home,
      (route) => false,
      arguments: user,
    );
  }
}
