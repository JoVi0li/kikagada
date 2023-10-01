import 'package:kikagada/modules/rank/domain/entities/relevance_vote_entity.dart';
import 'package:kikagada/modules/rank/domain/entities/review_rank_entity.dart';

abstract interface class IRankDatasource {
  Future<List<ReviewRankEntity>> getRanks(ReviewRankEntity? starterAfter, int? limit);
  Future<void> voteRelevance(RelevanceVoteEntity relevance);
}
