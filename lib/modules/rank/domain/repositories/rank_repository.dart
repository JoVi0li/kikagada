import 'package:kikagada/modules/rank/domain/entities/relevance_vote_entity.dart';
import 'package:kikagada/modules/rank/domain/entities/review_rank_entity.dart';
import 'package:kikagada/modules/rank/domain/errors/rank_errors.dart';

abstract interface class IRankRepository {
  Future<(List<ReviewRankEntity>? success, RankError? error)> getRanks(
    ReviewRankEntity? starterAfter,
    int? limit,
  );
  Future<(void success, RankError? error)> voteRelevance(
    RelevanceVoteEntity relevance,
  );
}
