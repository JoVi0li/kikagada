import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kikagada/firebase_options.dart';
import 'package:kikagada/shared/inject/inject.dart';
import 'package:kikagada/shared/routes/app.routes.dart';
import 'package:kikagada/shared/routes/auth_routes.dart';
import 'package:kikagada/shared/themes/app_bar_theme.dart';
import 'package:kikagada/shared/themes/color_theme.dart';
import 'package:kikagada/shared/themes/dialog_theme.dart';
import 'package:kikagada/shared/themes/text_button_theme.dart';
import 'package:kikagada/shared/themes/text_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Inject.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kikagada',
      theme: ThemeData(
        colorScheme: CustomColorTheme.theme(),
        scaffoldBackgroundColor: const Color(0xFF402319),
        useMaterial3: true,
        textTheme: CustomTextTheme.theme(),
        appBarTheme: CustomAppBarTheme.theme(),
        dialogTheme: CustomDialogTheme.theme(),
        textButtonTheme: CustomTextButtonTheme.theme(),
      ),
      routes: AppRoutes.routes(context),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: AuthRoutes.login,
    );
  }
}
