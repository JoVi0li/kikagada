import 'package:flutter/foundation.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/usecases/get_reviews_usecase/get_reviews_usecase.dart';
import 'package:kikagada/modules/review/presenter/states/feed_state.dart';

abstract interface class IFeedStore extends ValueListenable<FeedState> {
  Future<void> getReviews(ReviewEntity? startAfter, int? limit);
}

final class FeedStore extends ValueNotifier<FeedState> implements IFeedStore {
  FeedStore(this.getReviewsUsecase) : super(FeedLoadingState()) {
    getReviews(null, null);
  }

  late final IGetReviewsUsecase getReviewsUsecase;

  @override
  Future<void> getReviews(ReviewEntity? startAfter, int? limit) async {
    value = FeedLoadingState();

    final (success, error) = await getReviewsUsecase(startAfter, limit);

    if (error != null) {
      value = FeedErrorState(error: error);
      return;
    }

    if (success != null && success.isEmpty) {
      value = FeedEmptyState();
      return;
    }

    if (success != null && success.isNotEmpty) {
      value = FeedSuccessState(value: success);
      return;
    }
  }
}
