import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/review/presenter/states/home_state.dart';
import 'package:kikagada/modules/review/presenter/stores/home_store.dart';
import 'package:kikagada/modules/review/presenter/widgets/home_widgets/home_error_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/home_widgets/loading_reviews_widgets.dart';
import 'package:kikagada/modules/review/presenter/widgets/home_widgets/reviews_list_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/home_widgets/reviews_not_found_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final GetIt _getIt;
  late final IHomeStore _store;

  @override
  void initState() {
    super.initState();
    _getIt = GetIt.I;
    _store = _getIt<IHomeStore>();
  }

  @override
  void dispose() {
    _getIt.resetLazySingleton<IHomeStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Home', style: Theme.of(context).textTheme.titleMedium),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: ValueListenableBuilder(
        valueListenable: _store,
        builder: (ctx, state, widget) {
          switch (state) {
            case HomeEmptyState():
              return const ReviewsNotFoundWidget();
            case HomeLoadingState():
              return const LoadingReviewsWidget();
            case HomeSuccessState():
              return ReviewsListWidget(state.reviews);
            case HomeErrorState():
              return HomeErrorWidget(state.error,
                  tryAgain: () => _store.getReviews(null, null));
            default:
              return const LoadingReviewsWidget();
          }
        },
      ),
    );
  }
}
