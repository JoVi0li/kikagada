import 'package:flutter/material.dart';
import 'package:kikagada/modules/auth/presenter/screens/login_screen.dart';
import 'package:kikagada/modules/review/presenter/screens/review_details_screen.dart';
import 'package:kikagada/shared/routes/auth_routes.dart';
import 'package:kikagada/shared/routes/home_routes.dart';

abstract class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes(
    BuildContext context,
  ) {
    return {
      AuthRoutes.login: (context) => const LoginScreen(),
      HomeRoutes.home: (context) =>  const ReviewDetailsScreen(),
    };
  }
}
