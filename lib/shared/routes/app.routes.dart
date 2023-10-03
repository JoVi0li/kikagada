import 'package:flutter/material.dart';
import 'package:kikagada/modules/auth/presenter/screens/login_screen.dart';
import 'package:kikagada/modules/review/presenter/screens/feeed_screen.dart';
import 'package:kikagada/modules/review/presenter/screens/review_details_screen.dart';
import 'package:kikagada/shared/routes/auth_routes.dart';
import 'package:kikagada/shared/routes/review_routes.dart';

abstract class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes(
    BuildContext context,
  ) {
    return {
      AuthRoutes.login: (context) => const LoginScreen(),
      ReviewRoutes.details: (context) => const ReviewDetailsScreen(),
      ReviewRoutes.feed: (context) => const FeedScreen(),
    };
  }
}
