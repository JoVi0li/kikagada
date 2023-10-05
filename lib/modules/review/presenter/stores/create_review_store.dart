import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/domain/usecases/create_review_usecase/create_review_usecase.dart';
import 'package:kikagada/modules/review/domain/usecases/upload_photos_usecase/upload_photos_usecase.dart';
import 'package:kikagada/modules/review/presenter/states/create_review_state.dart';
import 'package:kikagada/shared/routes/review_routes.dart';

abstract interface class ICreateReviewStore
    extends ValueListenable<CreateReviewState> {
  Future<void> createReview(ReviewEntity review, BuildContext context);
}

final class CreateReviewStore extends ValueNotifier<CreateReviewState>
    implements ICreateReviewStore {
  CreateReviewStore(this._createReviewUsecase, this._uploadPhotosUsecase)
      : super(CreateReviewInitialState());

  final ICreateReviewUsecase _createReviewUsecase;
  final IUploadPhotosUsecase _uploadPhotosUsecase;

  @override
  Future<void> createReview(ReviewEntity review, BuildContext context) async {
    value = CreateReviewLoadingState();

    final (photos, uploadError) = await _uploadPhotosUsecase(review.photos);

    if (uploadError != null) {
      value = CreateReviewErrorState(error: uploadError);
      return;
    }

    if (photos == null || photos.isEmpty) {
      value = CreateReviewErrorState(
        error: GenericReviewError(
          error: 'Não foi possível realizar o upload das fotos',
          message: null,
        ),
      );
    }

    final (success, error) =
        await _createReviewUsecase(review.copyWith(photos: photos));

    if (error != null) {
      value = CreateReviewErrorState(error: error);
      return;
    }

    if (success != null) {
      await navigateToFeed(context);
      return;
    }

    value = CreateReviewInitialState();
  }

  Future<void> navigateToFeed(BuildContext context) async {
    return await Navigator.pushNamedAndRemoveUntil<void>(
      context,
      ReviewRoutes.feed,
      (_) => false,
    );
  }
}
