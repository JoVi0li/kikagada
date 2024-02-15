import 'package:flutter/material.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';
import 'package:kikagada/modules/review/presenter/widgets/home_widgets/reviews_not_found_widget.dart';
import 'package:kikagada/shared/components/button_component.dart';
import 'package:kikagada/shared/components/dialog_component.dart';

class HomeErrorWidget extends StatelessWidget {
  const HomeErrorWidget(this.error, {super.key, required this.tryAgain});

  final BaseException error;
  final void Function() tryAgain;

  void onPressed(BuildContext context) {
    Navigator.pop(context);
    tryAgain();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      return showAdaptiveDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return DialogComponent(
            title: 'Erro ao recuperar as reviews',
            content: error.exception.toString(),
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
    return const ReviewsNotFoundWidget();
  }
}
