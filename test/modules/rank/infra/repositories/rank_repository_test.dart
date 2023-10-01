import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/rank/domain/entities/relevance_vote_entity.dart';
import 'package:kikagada/modules/rank/domain/entities/review_rank_entity.dart';
import 'package:kikagada/modules/rank/domain/errors/rank_errors.dart';
import 'package:kikagada/modules/rank/domain/repositories/rank_repository.dart';
import 'package:kikagada/modules/rank/infra/datasources/rank_datasource.dart';
import 'package:kikagada/modules/rank/infra/repositories/rank_repository.dart';
import 'package:mocktail/mocktail.dart';

class RankDatasourceMock extends Mock implements IRankDatasource {}

void main() {
  late final IRankDatasource datasource;
  late final IRankRepository repository;
  late final ReviewRankEntity rank;
  late final RelevanceVoteEntity relevance;
  late final RankError error;

  setUpAll(() {
    datasource = RankDatasourceMock();
    repository = RankRepository(datasource: datasource);
    relevance = RelevanceVoteEntity(id: '01', userId: '01', isRelevant: true);
    rank = ReviewRankEntity(
      id: '01',
      reviewId: '01',
      reviewTitle: 'title',
      relevanceVotes: [],
      notes: [],
    );
    error = GenericRankError(error: 'error');
    registerFallbackValue(0);
    registerFallbackValue(relevance);
    registerFallbackValue(rank);
  });

  group('rank repository tests', () {
    test('should return a list of ReviewRankEntity', () async {
      when(() => datasource.getRanks(any(), any())).thenAnswer(
        (_) => Future(() => [rank]),
      );

      final (success, error) = await repository.getRanks(rank, 0);

      expect(error, isNull);
      expect(success, isNotNull);
      expect(success, isA<List<ReviewRankEntity>>());
      expect(success![0].reviewTitle, 'title');
    });

    test('should return an error after try get ranks', () async {
      when(() => datasource.getRanks(any(), any())).thenThrow(error);

      final (success, failure) = await repository.getRanks(rank, 0);

      expect(success, isNull);
      expect(failure, isNotNull);
      expect(failure, isA<RankError>());
      expect(failure!.error, isNotEmpty);
    });

    test('should not has return if its sucesss', () async {
      when(() => datasource.voteRelevance(any())).thenAnswer(
        (_) => Future(() => (null, null)),
      );

      final (_, error) = await repository.voteRelevance(relevance);

      expect(error, isNull);
    });

    test('should return an error after try get ranks', () async {
      when(() => datasource.voteRelevance(any())).thenThrow(error);

      final (_, failure) = await repository.voteRelevance(relevance);

      expect(failure, isNotNull);
      expect(failure, isA<RankError>());
      expect(failure!.error, isNotEmpty);
    });
  });
}
