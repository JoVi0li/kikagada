import 'package:flutter/material.dart';
import 'package:kikagada/modules/auth/presenter/screens/login_screen.dart';
import 'package:kikagada/modules/rank/presenter/screens/overview_screen.dart';
import 'package:kikagada/shared/routes/auth_routes.dart';
import 'package:kikagada/shared/routes/rank_routes.dart';

abstract class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes(
    BuildContext context,
  ) {
    return {
      AuthRoutes.login: (context) => const LoginScreen(),
      RankRoutes.overview: (context) =>  const OverviewScreen(),
    };
  }
}
