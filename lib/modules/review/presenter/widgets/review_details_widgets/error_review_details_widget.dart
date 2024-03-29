import 'package:flutter/material.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';
import 'package:kikagada/modules/review/presenter/widgets/review_details_widgets/review_details_loading_widget.dart';
import 'package:kikagada/shared/components/button_component.dart';
import 'package:kikagada/shared/components/dialog_component.dart';
import 'package:kikagada/shared/components/navigation_bar/navigation_bar_component.dart';

class ErrorReviewDetailsWidget extends StatelessWidget {
  const ErrorReviewDetailsWidget({super.key, required this.error});
  final BaseException error;

  void onPressed(BuildContext context) async {
    Navigator.pop(context);
    return await Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute(builder: (ctx) => const NavigationBarComponent()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      return showAdaptiveDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return DialogComponent(
            title: 'Erro ao carregar a review',
            content: error.exception.toString(),
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
