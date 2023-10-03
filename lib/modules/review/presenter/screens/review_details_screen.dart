import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/review/presenter/states/review_details_state.dart';
import 'package:kikagada/modules/review/presenter/stores/review_details_store.dart';
import 'package:kikagada/modules/review/presenter/widgets/review_details_widgets/error_review_details_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/review_details_widgets/initial_review_details_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/review_details_widgets/loading_review_details_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/review_details_widgets/success_review_details_widget.dart';
import 'package:kikagada/shared/components/app_bar_component.dart';

class ReviewDetailsScreen extends StatefulWidget {
  const ReviewDetailsScreen({super.key});

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

    /// TODO: Remove hard code
    _store.getById('7oWfRpUq6u7voSWVhvbk');
  }

  @override
  void dispose() {
    super.dispose();
    _getIt.resetLazySingleton<IReviewDetailsStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 60),
        child: const AppBarComponent(title: 'Review'),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _store,
          builder: (context, state, child) {
            switch (state) {
              case InitialReviewDetailsState():
                return const InitialReviewDetailsWidget();
              case LoadingReviewDetailsState():
                return const LoadingReviewDetailsWidget();
              case SuccessReviewDetailsState():
                return SuccessReviewDetailsWidget(review: state.review);
              case ErrorReviewDetailsState():
                return ErrorReviewDetailsWidget(error: state.error);
              default:
                return const InitialReviewDetailsWidget();
            }
          },
        ),
      ),
    );
  }
}
