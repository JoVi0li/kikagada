import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

abstract interface class IDeleteReviewUsecase {
  Future<(ReviewEntity? success, BaseException? error)> call(String id);
}

class DeleteReviewUsecase implements IDeleteReviewUsecase {
  DeleteReviewUsecase({required IReviewRepository repository})
      : _repository = repository;

  final IReviewRepository _repository;

  @override
  Future<(ReviewEntity?, BaseException?)> call(String id) async {
    return await _repository.delete(id);
  }
}
