import 'package:flutter/material.dart';
import 'package:kikagada/modules/auth/presenter/screens/login_screen.dart';
import 'package:kikagada/modules/review/presenter/screens/create_review_screen.dart';
import 'package:kikagada/modules/review/presenter/screens/feed_screen.dart';
import 'package:kikagada/modules/review/presenter/screens/review_details_screen.dart';
import 'package:kikagada/shared/routes/auth_routes.dart';
import 'package:kikagada/shared/routes/review_routes.dart';

abstract class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes(
    BuildContext context,
  ) {
    return {
      AuthRoutes.login: (context) => const LoginScreen(),
      ReviewRoutes.feed: (context) => const FeedScreen(),
      ReviewRoutes.create: (context) => const CreateReviewScreen(),
    };
  }

  static Route<dynamic>? onGenerateRoute(
    RouteSettings settings,
  ) {
    if (settings.name == ReviewRoutes.details) {
      return MaterialPageRoute(
        builder: (ctx) =>
            ReviewDetailsScreen(reviewId: settings.arguments as String),
      );
    }
    return null;
  }
}
