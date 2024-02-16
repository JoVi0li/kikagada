import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/review/presenter/states/my_reviews_state.dart';
import 'package:kikagada/modules/review/presenter/stores/my_reviews_store.dart';
import 'package:kikagada/modules/review/presenter/widgets/my_reviews_widgets/my_reviews_widget.dart';
import 'package:kikagada/shared/services/google_ad_service.dart';

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
    ad.$2();
    super.dispose();
  }

  void tryLoadReviewsAgain() async {
    return await _store.getMyReviews(null, null);
  }

  final ad =
      GoogleAdService.loadBannerAd("ca-app-pub-1971148572039667/3712071145");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Minhas reviews',
            style: Theme.of(context).textTheme.titleMedium),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _store,
              builder: (ctx, state, widget) {
                return switch (state) {
                  MyReviewsWithoutDataState() => MyReviewsWidget.noData(),
                  MyReviewsLoadingState() => MyReviewsWidget.loading(),
                  MyReviewsSuccessState() =>
                    MyReviewsWidget.listReviews(state.reviews),
                  MyReviewsErrorState() =>
                    MyReviewsWidget.error(state.error, tryLoadReviewsAgain),
                };
              },
            ),
          ),
          ad.$1,
        ],
      ),
    );
  }
}
