import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/presenter/widgets/create_review_widgets/create_review_initial_widget.dart';
import 'package:kikagada/shared/components/button_component.dart';
import 'package:kikagada/shared/components/dialog_component.dart';

class CreateReviewErrorWidget extends StatelessWidget {
  const CreateReviewErrorWidget({super.key, required this.error});

  final ReviewError error;

  void onPressed(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      return showAdaptiveDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return DialogComponent(
            title: 'Erro ao criar a review',
            content: error.error,
            actions: [
              ButtonComponent(
                onPressed: () => onPressed(context),
                label: 'Ok',
              ),
            ],
          );
        },
      );
    });

    return const CreateReviewInitialWidget();
  }
}
