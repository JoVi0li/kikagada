import 'package:kikagada/modules/rank/domain/entities/review_rank_entity.dart';
import 'package:kikagada/modules/rank/domain/errors/rank_errors.dart';
import 'package:kikagada/modules/rank/domain/repositories/rank_repository.dart';

abstract interface class IGetRanksUsecase {
  Future<(List<ReviewRankEntity>? success, RankError? error)> call(
    ReviewRankEntity? starterAfter,
    int? limit,
  );
}

class GetRanksUsecase implements IGetRanksUsecase {
  GetRanksUsecase({required IRankRepository repository})
      : _repository = repository;

  final IRankRepository _repository;

  @override
  Future<(List<ReviewRankEntity>?, RankError?)> call(
    ReviewRankEntity? starterAfter,
    int? limit,
  ) async {
    return await _repository.getRanks(starterAfter, limit);
  }
}
