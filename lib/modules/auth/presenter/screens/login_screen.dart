import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/auth/presenter/components/login_button.dart';
import 'package:kikagada/modules/auth/presenter/controllers/login_controller.dart';
import 'package:kikagada/modules/auth/presenter/stores/login_store.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GetIt _getIt;
  late final LoginStore _store;
  late final LoginController _controller;

  @override
  void initState() {
    super.initState();
    _getIt = GetIt.I;
    _store = _getIt<LoginStore>();
    _controller = LoginController();
    _store.verifyAuthState(
      (user) async => await _controller.navigateToHomeScreen(context, user),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _getIt.resetLazySingleton<LoginStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF402319),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 100,
          bottom: 70,
          left: 24,
          right: 24,
        ),
        child: Column(
          children: [
            Text(
              "Kikagada",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              "Compartilhe suas experiências e faça ranks dos melhores aos piores banheiros",
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            defaultTargetPlatform == TargetPlatform.android
                ? LoginButton(
                    icon: 'lib/shared/assets/icons/google.svg',
                    label: "Entrar com o Google",
                    onPressed: () => _store.loginWithGoogle(
                      context,
                      (user) async =>
                          await _controller.navigateToHomeScreen(context, user),
                    ),
                  )
                : LoginButton(
                    icon: 'lib/shared/assets/icons/apple.svg',
                    label: "Entrar com a Apple",
                    onPressed: () => _store.loginWithApple(
                      context,
                      (user) async =>
                          await _controller.navigateToHomeScreen(context, user),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
