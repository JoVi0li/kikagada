import 'package:firebase_auth/firebase_auth.dart';
import 'package:kikagada/modules/rank/domain/entities/relevance_vote_entity.dart';
import 'package:kikagada/modules/rank/domain/entities/review_rank_entity.dart';
import 'package:kikagada/modules/rank/domain/errors/rank_errors.dart';
import 'package:kikagada/modules/rank/domain/repositories/rank_repository.dart';
import 'package:kikagada/modules/rank/infra/datasources/rank_datasource.dart';

class RankRepository implements IRankRepository {
  RankRepository({required IRankDatasource datasource})
      : _datasource = datasource;

  final IRankDatasource _datasource;

  @override
  Future<(List<ReviewRankEntity>?, RankError?)> getRanks(
    ReviewRankEntity? starterAfter,
    int? limit,
  ) async {
    try {
      return (await _datasource.getRanks(starterAfter, limit), null);
    } on FirebaseException catch (e) {
      return (
        null,
        FirebaseRankError(
          error: e.code,
          message: e.message,
          trace: e.stackTrace,
        ),
      );
    } catch (e) {
      return (null, GenericRankError(error: e.toString()));
    }
  }

  @override
  Future<(void, RankError?)> voteRelevance(
    RelevanceVoteEntity relevance,
  ) async {
    try {
      await _datasource.voteRelevance(relevance);
      return (null, null);
    } on FirebaseException catch (e) {
      return (
        null,
        FirebaseRankError(
          error: e.code,
          message: e.message,
          trace: e.stackTrace,
        ),
      );
    } catch (e) {
      return (null, GenericRankError(error: e.toString()));
    }
  }
}
