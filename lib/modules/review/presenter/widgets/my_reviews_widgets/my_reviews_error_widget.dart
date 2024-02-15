import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/presenter/widgets/my_reviews_widgets/loading_my_reviews_widget.dart';
import 'package:kikagada/shared/components/button_component.dart';
import 'package:kikagada/shared/components/dialog_component.dart';

class MyReviewsErrorWidget extends StatelessWidget {
  const MyReviewsErrorWidget(this.error, {super.key, required this.tryAgain});

  final ReviewError error;
  final void Function() tryAgain;

  void onPressed(BuildContext context) {
    Navigator.pop(context);
    tryAgain();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      return showAdaptiveDialog<void>(
        context: context,
        builder: (ctx) {
          return DialogComponent(
            title: 'Erro ao recuperar as suas reviews',
            content: error.error,
            actions: [
              ButtonComponent(
                onPressed: () => onPressed(context),
                label: 'Tentar novamente',
              ),
            ],
          );
        },
      );
    });
    return const LoadingMyReviewsWidget();
  }
}
