import 'package:flutter/material.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/shared/routes/review_routes.dart';

class LoginController {
  Future<void> navigateToHomeScreen(
    BuildContext context,
    UserEntity? user,
  ) async {
    return await Navigator.pushNamedAndRemoveUntil<void>(
      context,
      ReviewRoutes.feed,
      (route) => false,
      arguments: user,
    );
  }
}
