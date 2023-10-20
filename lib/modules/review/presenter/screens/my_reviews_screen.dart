import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/review/presenter/states/my_reviews_state.dart';
import 'package:kikagada/modules/review/presenter/stores/my_reviews_store.dart';
import 'package:kikagada/modules/review/presenter/widgets/my_reviews_widgets/loadind_my_reviews_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/my_reviews_widgets/my_reviews_error_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/my_reviews_widgets/my_reviews_list_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/my_reviews_widgets/without_reviews_widget.dart';

class MyReviewsScreen extends StatefulWidget {
  const MyReviewsScreen({super.key});

  @override
  State<MyReviewsScreen> createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends State<MyReviewsScreen> {
  late final GetIt _getIt;
  late final IMyReviewsStore _store;

  @override
  void initState() {
    super.initState();
    _getIt = GetIt.I;
    _store = _getIt<IMyReviewsStore>();
  }

  @override
  void dispose() {
    _getIt.resetLazySingleton<IMyReviewsStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Minhas reviews',
            style: Theme.of(context).textTheme.titleMedium),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: ValueListenableBuilder(
        valueListenable: _store,
        builder: (ctx, state, widget) {
          switch (state) {
            case MyReviewsWithoutDataState():
              return const WithoutReviewsWidget();
            case MyReviewsLoadingState():
              return const LoadinMyReviewsWidget();
            case MyReviewsSuccessState():
              return MyReviewsListWidget(state.reviews);
            case MyReviewsErrorState():
              return MyReviewsErrorWidget(state.error,
                  tryAgain: () => _store.getMyReviews(null, null));
            default:
              return const LoadinMyReviewsWidget();
          }
        },
      ),
    );
  }
}
