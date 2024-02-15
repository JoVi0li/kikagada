import 'package:flutter/material.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';
import 'package:kikagada/modules/review/presenter/widgets/create_review_widgets/create_review_error_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/create_review_widgets/create_review_initial_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/create_review_widgets/create_review_loading_widget.dart';
import 'package:kikagada/shared/components/button_component.dart';
import 'package:kikagada/shared/components/dialog_component.dart';

sealed class CreateReviewWidget {
  static Widget initial() {
    return const CreateReviewInitialWidget();
  }

  static Widget error(BaseException error) {
    return CreateBaseExceptionWidget(error: error);
  }

  static Widget loading() {
    return const CreateReviewLoadingWidget();
  }

  static Widget hasNoPhoto(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      return await showAdaptiveDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return DialogComponent(
            title: 'Erro ao criar a review',
            content: 'Selecione ao menos uma foto',
            actions: [
              ButtonComponent(
                onPressed: () {
                  Navigator.pop(context);
                },
                label: 'Ok',
              ),
            ],
          );
        },
      );
    });
    return initial();
  }

  static Widget success(BuildContext context, void Function() resetValues) {
    resetValues();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      return await showAdaptiveDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return DialogComponent(
            title: 'Review criada com sucesso!',
            content: 'Acompanhe suas review na\ntela Minhas Reviews',
            actions: [
              ButtonComponent(
                onPressed: () {
                  Navigator.pop(context);
                },
                label: 'Ok',
              ),
            ],
          );
        },
      );
    });
    return initial();
  }
}
