import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/review/presenter/states/create_review_state.dart';
import 'package:kikagada/modules/review/presenter/stores/create_review_store.dart';
import 'package:kikagada/modules/review/presenter/widgets/create_review_widgets/create_review_widget.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  late final GetIt _getIt;
  late final CreateReviewStore _store;

  @override
  void initState() {
    super.initState();
    _getIt = GetIt.I;
    _store = _getIt<CreateReviewStore>();
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
          return switch (state) {
            CreateReviewInitialState() => CreateReviewWidget.initial(),
            CreateReviewLoadingState() => CreateReviewWidget.loading(),
            CreateReviewErrorState() => CreateReviewWidget.error(state.error),
            CreateReviewHasNoPhotosState() =>
              CreateReviewWidget.hasNoPhoto(ctx),
            CreateReviewSuccessState() =>
              CreateReviewWidget.success(ctx, _store.resetValues)
          };
        },
      ),
    );
  }
}
