import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/review/presenter/states/home_state.dart';
import 'package:kikagada/modules/review/presenter/stores/home_store.dart';
import 'package:kikagada/modules/review/presenter/widgets/home_widgets/home_error_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/home_widgets/home_widget.dart';
import 'package:kikagada/shared/services/google_ad_service.dart';

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
    ad.$2();
    super.dispose();
  }

  void tryAgain() async {
    return await _store.getReviews(null, null);
  }

  final ad =
      GoogleAdService.loadBannerAd("ca-app-pub-1971148572039667/5633503381");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Home', style: Theme.of(context).textTheme.titleMedium),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _store,
              builder: (ctx, state, _) {
                return switch (state) {
                  HomeEmptyState() => HomeWidget.notFound(),
                  HomeLoadingState() => HomeWidget.loading(),
                  (HomeSuccessState success) =>
                    HomeWidget.listReviews(success.reviews),
                  (HomeErrorState error) =>
                    HomeErrorWidget(error.error, tryAgain: tryAgain),
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
