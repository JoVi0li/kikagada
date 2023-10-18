import 'package:flutter/foundation.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/usecases/get_my_reviews_usecase/get_my_reviews_usecase.dart';
import 'package:kikagada/modules/review/presenter/states/my_reviews_state.dart';

abstract interface class IMyReviewsStore
    extends ValueListenable<MyReviewsState> {
  Future<void> getMyReviews(ReviewEntity? startAfter, int? limit);
}

class MyReviewsStore extends ValueNotifier<MyReviewsState>
    implements IMyReviewsStore {
  MyReviewsStore(this.getMyReviewsUsecase) : super(MyReviewsLoadingState()) {
    getMyReviews(null, null);
  }

  final IGetMyReviewsUsecase getMyReviewsUsecase;

  @override
  Future<void> getMyReviews(ReviewEntity? startAfter, int? limit) async {
    value = MyReviewsLoadingState();

    final (reviewsList, error) = await getMyReviewsUsecase(startAfter, limit);

    if (error != null) {
      value = MyReviewsErrorState(error: error);
      return;
    }

    if (reviewsList != null && reviewsList.isEmpty) {
      value = MyReviewsWithoutDataState();
      return;
    }

    if (reviewsList != null && reviewsList.isNotEmpty) {
      value = MyReviewsSuccessState(reviews: reviewsList);
      return;
    }
  }
}
