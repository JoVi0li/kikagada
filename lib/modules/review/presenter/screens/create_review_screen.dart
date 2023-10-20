import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/review/presenter/states/create_review_state.dart';
import 'package:kikagada/modules/review/presenter/stores/create_review_store.dart';
import 'package:kikagada/modules/review/presenter/widgets/create_review_widgets/create_review_error_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/create_review_widgets/create_review_initial_widget.dart';
import 'package:kikagada/shared/components/button_component.dart';
import 'package:kikagada/shared/components/dialog_component.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  late final GetIt _getIt;
  late final CreateReviewStore _store;
  late final CreateReviewInitialWidget createReviewInitialWidget;

  @override
  void initState() {
    super.initState();
    _getIt = GetIt.I;
    _store = _getIt<CreateReviewStore>();
    createReviewInitialWidget = const CreateReviewInitialWidget();
  }

  @override
  void dispose() {
    _getIt.resetLazySingleton<CreateReviewStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Criar review',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: ValueListenableBuilder(
        valueListenable: _store,
        builder: (ctx, state, child) {
          switch (state) {
            case CreateReviewInitialState():
              return createReviewInitialWidget;
            case CreateReviewLoadingState():
              return const Center(
                  child: CircularProgressIndicator(
                backgroundColor: Color(0xFFD9A28F),
              ));
            case CreateReviewErrorState():
              return CreateReviewErrorWidget(error: state.error);
            case CreateReviewHasNoPhotosState():
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
              return createReviewInitialWidget;
            case CreateReviewSuccessState():
              _store.resetValues();
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
              return createReviewInitialWidget;
            default:
              return createReviewInitialWidget;
          }
        },
      ),
    );
  }
}
