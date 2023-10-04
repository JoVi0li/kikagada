import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/review/presenter/controllers/feed_controller.dart';
import 'package:kikagada/modules/review/presenter/states/feed_state.dart';
import 'package:kikagada/modules/review/presenter/stores/feed_store.dart';
import 'package:kikagada/modules/review/presenter/widgets/feed_widgets/feed_error_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/feed_widgets/feed_empty_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/feed_widgets/feed_loading_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/feed_widgets/feed_success_widget.dart';
import 'package:kikagada/shared/components/app_bar_component.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late final GetIt _getIt;
  late final IFeedStore _store;
  late final IFeedController _controller;

  @override
  void initState() {
    super.initState();
    _getIt = GetIt.I;
    _store = _getIt<IFeedStore>();
    _controller = FeedController();
  }

  @override
  void dispose() {
    _getIt.resetLazySingleton<IFeedStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 60),
        child: const AppBarComponent(title: 'Kikagada'),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _store,
          builder: (ctx, state, widget) {
            switch (state) {
              case FeedEmptyState():
                return const FeedEmptyWidget();
              case FeedLoadingState():
                return const FeedLoadingWidget();
              case FeedSuccessState():
                return FeedSuccessWidget(
                  reviews: state.value,
                  onClick: (reviewId) async {
                    await _controller.navigateToReviewDetails(
                      context,
                      reviewId,
                    );
                    debugPrint(reviewId + ' reviewId');
                  },
                );
              case FeedErrorState():
                return FeedErrorWidget(error: state.error);
              default:
                return const FeedEmptyWidget();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.navigateToCreateReview(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
