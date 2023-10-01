import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';

abstract interface class ICreateReviewUsecase {
  Future<(ReviewEntity? success, ReviewError? error)> call(ReviewEntity review);
}

class CreateReviewUsecase implements ICreateReviewUsecase {
  CreateReviewUsecase({required IReviewRepository repository})
      : _repository = repository;

  final IReviewRepository _repository;

  @override
  Future<(ReviewEntity?, ReviewError?)> call(ReviewEntity review) async {
    return await _repository.create(review);
  }
}
