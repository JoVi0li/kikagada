import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kikagada/firebase_options.dart';
import 'package:kikagada/shared/inject/inject.dart';
import 'package:kikagada/shared/routes/app.routes.dart';
import 'package:kikagada/shared/routes/auth_routes.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF402319)),
        scaffoldBackgroundColor: const Color(0xFF402319),
        useMaterial3: true,
        textTheme: CustomTextTheme.theme(),
      ),
      routes: AppRoutes.routes(context),
      initialRoute: AuthRoutes.login,
    );
  }
}
