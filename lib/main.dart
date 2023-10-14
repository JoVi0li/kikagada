import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kikagada/firebase_options.dart';
import 'package:kikagada/modules/auth/presenter/screens/login_screen.dart';
import 'package:kikagada/modules/review/presenter/screens/feed_screen.dart';
import 'package:kikagada/shared/inject/inject.dart';
import 'package:kikagada/shared/routes/app.routes.dart';
import 'package:kikagada/shared/themes/app_theme.dart';

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
      theme: AppTheme.theme(),
      routes: AppRoutes.routes(context),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          /// TODO: Implement hasError case
          /// Example: if(snapshot.hasError) return const ErrorScreen();
          if (snapshot.hasData) return const FeedScreen();
          return const LoginScreen();
        },
      ),
    );
  }
}
