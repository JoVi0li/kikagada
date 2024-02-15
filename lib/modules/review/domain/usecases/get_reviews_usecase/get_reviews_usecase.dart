import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

abstract interface class IGetReviewsUsecase {
  Future<(List<ReviewEntity>? success, BaseException? error)> call(
    ReviewEntity? starterAfter,
    int? limit,
  );
}

class GetReviewsUsecase implements IGetReviewsUsecase {
  GetReviewsUsecase({required IReviewRepository repository})
      : _repository = repository;

  final IReviewRepository _repository;

  @override
  Future<(List<ReviewEntity>?, BaseException?)> call(
    ReviewEntity? starterAfter,
    int? limit,
  ) async {
    return await _repository.getReviews(starterAfter, limit);
  }
}
