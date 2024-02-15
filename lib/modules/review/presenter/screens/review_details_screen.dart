import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/review/presenter/states/review_details_state.dart';
import 'package:kikagada/modules/review/presenter/stores/review_details_store.dart';
import 'package:kikagada/modules/review/presenter/widgets/review_details_widgets/review_details_widget.dart';

class ReviewDetailsScreen extends StatefulWidget {
  const ReviewDetailsScreen({super.key, required this.reviewId});

  final String reviewId;

  @override
  State<ReviewDetailsScreen> createState() => _ReviewDetailsScreenState();
}

class _ReviewDetailsScreenState extends State<ReviewDetailsScreen> {
  late final GetIt _getIt;
  late final IReviewDetailsStore _store;

  @override
  void initState() {
    super.initState();
    _getIt = GetIt.I;
    _store = _getIt<IReviewDetailsStore>();
    _store.getById(widget.reviewId);
  }

  @override
  void dispose() {
    super.dispose();
    _getIt.resetLazySingleton<IReviewDetailsStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Review', style: Theme.of(context).textTheme.titleMedium),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _store,
          builder: (context, state, child) {
            return switch (state) {
              ReviewDetailsLoadingState() => ReviewDetailsWidget.loading(),
              ReviewDetailsSuccessState() =>
                ReviewDetailsWidget.success(state.review),
              ReviewDetailsErrorState() =>
                ReviewDetailsWidget.error(state.error),
            };
          },
        ),
      ),
    );
  }
}
