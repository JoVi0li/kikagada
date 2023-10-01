import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/rank/domain/entities/relevance_vote_entity.dart';
import 'package:kikagada/modules/rank/domain/errors/rank_errors.dart';
import 'package:kikagada/modules/rank/domain/repositories/rank_repository.dart';
import 'package:kikagada/modules/rank/domain/usecases/vote_relevance_usecase.dart';
import 'package:mocktail/mocktail.dart';

class RankRepositoryMock extends Mock implements IRankRepository {}

void main() {
  late final RankRepositoryMock repository;
  late final RelevanceVoteEntity relevance;
  late final RankError error;
  late final IVoteRelevanceUsecase usecase;

  setUpAll(() {
    repository = RankRepositoryMock();
    relevance = RelevanceVoteEntity(id: '01', userId: '01', isRelevant: true);
    error = GenericRankError(error: 'error');
    usecase = VoteRelevanceUsecase(repository: repository);
    registerFallbackValue(relevance);
  });
  group('vote relevance usecase tests', () {
    test('should vote review relevance whithout return an error', () async {
      when(() => repository.voteRelevance(any())).thenAnswer(
        (_) => Future(() => (null, null)),
      );

      final (_, error) = await usecase(relevance);

      expect(error, isNull);
    });

    test('should return an RankError instance', () async {
      when(() => repository.voteRelevance(any())).thenAnswer(
        (_) => Future(() => (null, error)),
      );

      final (_, failure) = await usecase(relevance);

      expect(failure, isNotNull);
      expect(failure, isA<RankError>());
      expect(failure!.error, 'error');
    });
  });
}
