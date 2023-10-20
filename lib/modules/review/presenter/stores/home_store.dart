import 'package:flutter/foundation.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/usecases/get_reviews_usecase/get_reviews_usecase.dart';
import 'package:kikagada/modules/review/presenter/states/home_state.dart';

abstract interface class IHomeStore extends ValueListenable<HomeState> {
  Future<void> getReviews(ReviewEntity? startAfter, int? limit);
}

final class HomeStore extends ValueNotifier<HomeState> implements IHomeStore {
  HomeStore(this.getReviewsUsecase) : super(HomeLoadingState()) {
    getReviews(null, null);
  }

  late final IGetReviewsUsecase getReviewsUsecase;

  @override
  Future<void> getReviews(ReviewEntity? startAfter, int? limit) async {
    value = HomeLoadingState();

    final (reviewsList, error) = await getReviewsUsecase(startAfter, limit);

    if (error != null) {
      value = HomeErrorState(error: error);
      return;
    }

    if (reviewsList != null && reviewsList.isEmpty) {
      value = HomeEmptyState();
      return;
    }

    if (reviewsList != null && reviewsList.isNotEmpty) {
      value = HomeSuccessState(reviews: reviewsList);
      return;
    }
  }
}
