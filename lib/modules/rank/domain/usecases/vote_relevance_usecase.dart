import 'package:kikagada/modules/rank/domain/entities/relevance_vote_entity.dart';
import 'package:kikagada/modules/rank/domain/errors/rank_errors.dart';
import 'package:kikagada/modules/rank/domain/repositories/rank_repository.dart';

abstract interface class IVoteRelevanceUsecase {
  Future<(void success, RankError? error)> call(RelevanceVoteEntity relevance);
}

class VoteRelevanceUsecase implements IVoteRelevanceUsecase {
  VoteRelevanceUsecase({required IRankRepository repository})
      : _repository = repository;

  final IRankRepository _repository;

  @override
  Future<(void, RankError?)> call(RelevanceVoteEntity relevance) async {
    return _repository.voteRelevance(relevance);
  }
}
