import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/auth/presenter/components/login_button.dart';
import 'package:kikagada/modules/auth/presenter/states/login_state.dart';
import 'package:kikagada/modules/auth/presenter/stores/login_store.dart';
import 'package:kikagada/modules/review/presenter/screens/home_screen.dart';
import 'package:kikagada/shared/components/dialog_component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GetIt _getIt;
  late final LoginStore _store;

  @override
  void initState() {
    super.initState();
    _getIt = GetIt.I;
    _store = _getIt<LoginStore>();
  }

  @override
  void dispose() {
    _getIt.resetLazySingleton<LoginStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 100,
          bottom: 100,
          left: 40,
          right: 40,
        ),
        child: ValueListenableBuilder(
          valueListenable: _store,
          builder: (context, state, child) {
            if (state is LoginErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                return showAdaptiveDialog<void>(
                  barrierDismissible: false,
                  context: context,
                  builder: (ctx) {
                    return DialogComponent(
                      title: 'Erro ao realizar login',
                      content: state.exception.message ?? "",
                    );
                  },
                );
              });
            }

            if (state is LoginSuccessState) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                return await Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute(builder: (ctx) => const HomeScreen()),
                  (route) => false,
                );
              });
            }
            return child!;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kikagada",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 24),
              Text(
                "O ponto de encontro para\nquem tem história no\nbanheiro.",
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.left,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [LoginButton(onPressed: _store.login)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
