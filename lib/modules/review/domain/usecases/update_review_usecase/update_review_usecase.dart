import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';

abstract interface class IUpdateReviewUsecase {
  Future<(ReviewEntity? success, ReviewError? error)> call(ReviewEntity review);
}

class UpdateReviewUsecase implements IUpdateReviewUsecase {
  UpdateReviewUsecase({required IReviewRepository repository})
      : _repository = repository;

  final IReviewRepository _repository;

  @override
  Future<(ReviewEntity?, ReviewError?)> call(ReviewEntity review) async {
    return await _repository.update(review);
  }
}
