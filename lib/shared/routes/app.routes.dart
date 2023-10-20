import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/presenter/screens/review_details_screen.dart';
import 'package:kikagada/shared/routes/review_routes.dart';

abstract class AppRoutes {
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
