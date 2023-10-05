import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/presenter/controllers/create_review_controller.dart';
import 'package:kikagada/modules/review/presenter/states/create_review_state.dart';
import 'package:kikagada/modules/review/presenter/stores/create_review_store.dart';
import 'package:kikagada/modules/review/presenter/widgets/create_review_widgets/create_review_error_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/create_review_widgets/create_review_initial_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/create_review_widgets/create_review_loading_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/create_review_widgets/create_review_success_widget.dart';
import 'package:kikagada/shared/components/app_bar_component.dart';
import 'package:uuid/uuid.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  late final GetIt _getIt;
  late final ICreateReviewController _controller;
  late final ICreateReviewStore _store;

  @override
  void initState() {
    super.initState();
    _getIt = GetIt.I;
    _controller = CreateReviewController();
    _controller.initController();
    _store = _getIt<ICreateReviewStore>();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.disposeController();
    _getIt.resetLazySingleton<ICreateReviewStore>();
  }

  Future<void> createReview() async {
    const uuid = Uuid();
    final date = DateTime.now();
    if (!(_controller.formKey.currentState!.validate())) return;
    final review = ReviewEntity(
      id: uuid.v4(),
      authorId: '',
      createdAt: date,
      updatedAt: date,
      title: _controller.titleController.text,
      body: _controller.bodyController.text,
      photos: _controller.photos.map((file) => file.path).toList(),
    );
    await _store.createReview(review);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 60),
        child: const AppBarComponent(
          title: 'Criar review',
          hasBackButton: true,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _store,
        builder: (ctx, state, widget) {
          switch (state) {
            case CreateReviewInitialState():
              return CreateReviewInitialWidget(
                _controller,
                onPressed: createReview,
              );
            case CreateReviewLoadingState():
              return const CreateReviewLoadingWidget();
            case CreateReviewSuccessState():
              return const CreateReviewSuccessWidget();
            case CreateReviewErrorState():
              return CreateReviewErrorWidget(error: state.error);
            default:
              return CreateReviewInitialWidget(
                _controller,
                onPressed: createReview,
              );
          }
        },
      ),
    );
  }
}
