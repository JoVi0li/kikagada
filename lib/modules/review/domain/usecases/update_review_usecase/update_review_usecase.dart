import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

abstract interface class IUpdateReviewUsecase {
  Future<(ReviewEntity? success, BaseException? error)> call(
      ReviewEntity review);
}

class UpdateReviewUsecase implements IUpdateReviewUsecase {
  UpdateReviewUsecase({required IReviewRepository repository})
      : _repository = repository;

  final IReviewRepository _repository;

  @override
  Future<(ReviewEntity?, BaseException?)> call(ReviewEntity review) async {
    return await _repository.update(review);
  }
}
