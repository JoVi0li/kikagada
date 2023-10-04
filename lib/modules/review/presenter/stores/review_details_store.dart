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
  ) : super(LoadingReviewDetailsState());

  final IGetReviewByIdUsecase _getReviewByIdUsecase;
  final IUpdateReviewUsecase _updateReviewUsecase;
  final IGetPhotosDownloadURL _getPhotosDownloadURL;

  @override
  Future<void> getById(String id) async {
    value = LoadingReviewDetailsState();

    final (review, reviewError) = await _getReviewByIdUsecase(id);

    if (reviewError != null) {
      value = ErrorReviewDetailsState(error: reviewError);
      return;
    }

    final (urls, urlsError) = await _getPhotosDownloadURL(review!.photos);

    if (urlsError != null) {
      value = ErrorReviewDetailsState(error: urlsError);
      return;
    }

    value = SuccessReviewDetailsState(review: review.copyWith(photos: urls));
  }

  @override
  Future<void> update(ReviewEntity review) async {
    value = LoadingReviewDetailsState();

    final (success, failure) = await _updateReviewUsecase(review);

    if (failure != null) {
      value = ErrorReviewDetailsState(error: failure);
      return;
    }

    if (success != null) {
      value = SuccessReviewDetailsState(review: success);
      return;
    }
  }
}
