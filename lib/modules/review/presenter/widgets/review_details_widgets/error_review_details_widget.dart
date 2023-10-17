import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/presenter/screens/home_screen.dart';
import 'package:kikagada/modules/review/presenter/widgets/review_details_widgets/review_details_loading_widget.dart';
import 'package:kikagada/shared/components/button_component.dart';
import 'package:kikagada/shared/components/dialog_component.dart';

class ErrorReviewDetailsWidget extends StatelessWidget {
  const ErrorReviewDetailsWidget({super.key, required this.error});
  final ReviewError error;

  void onPressed(BuildContext context) async {
    return await Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute(builder: (ctx) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      return showAdaptiveDialog<void>(
        context: context,
        builder: (ctx) {
          return DialogComponent(
            title: 'Erro ao carregar a review',
            content: error.error,
            actions: [
              ButtonComponent(
                onPressed: () => onPressed(context),
                label: 'Voltar para tela inicial',
              ),
            ],
          );
        },
      );
    });
    return const ReviewDetailsLoadingWidget();
  }
}
