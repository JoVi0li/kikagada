import 'package:flutter/foundation.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/usecases/get_photos_download_url_usecase/get_photos_download_url_usecase.dart';
import 'package:kikagada/modules/review/domain/usecases/get_review_by_id_usecase/get_review_by_id.dart';
import 'package:kikagada/modules/review/domain/usecases/update_review_usecase/update_review_usecase.dart';
import 'package:kikagada/modules/review/presenter/states/review_details_state.dart';

abstract interface class IReviewDetailsStore
    extends ValueListenable<ReviewDetailsState> {
  Future<void> getById(String id);
  Future<void> update(ReviewEntity review);
}

class ReviewDetailsStore extends ValueNotifier<ReviewDetailsState>
    implements IReviewDetailsStore {
  ReviewDetailsStore(
    this._getReviewByIdUsecase,
    this._updateReviewUsecase,
    this._getPhotosDownloadURL,
  ) : super(ReviewDetailsLoadingState());

  final IGetReviewByIdUsecase _getReviewByIdUsecase;
  final IUpdateReviewUsecase _updateReviewUsecase;
  final IGetPhotosDownloadURL _getPhotosDownloadURL;

  @override
  Future<void> getById(String id) async {
    value = ReviewDetailsLoadingState();

    final (review, baseException) = await _getReviewByIdUsecase(id);

    if (baseException != null) {
      value = ReviewDetailsErrorState(error: baseException);
      return;
    }

    final (urls, urlsError) = await _getPhotosDownloadURL(review!.photos);

    if (urlsError != null) {
      value = ReviewDetailsErrorState(error: urlsError);
      return;
    }

    value = ReviewDetailsSuccessState(review: review.copyWith(photos: urls));
  }

  @override
  Future<void> update(ReviewEntity review) async {
    value = ReviewDetailsLoadingState();

    final (success, failure) = await _updateReviewUsecase(review);

    if (failure != null) {
      value = ReviewDetailsErrorState(error: failure);
      return;
    }

    if (success != null) {
      value = ReviewDetailsSuccessState(review: success);
      return;
    }
  }
}
