import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/rank/domain/entities/review_rank_entity.dart';
import 'package:kikagada/modules/rank/domain/errors/rank_errors.dart';
import 'package:kikagada/modules/rank/domain/repositories/rank_repository.dart';
import 'package:kikagada/modules/rank/domain/usecases/get_ranks_usecase.dart';
import 'package:mocktail/mocktail.dart';

class RankRepositoryMock extends Mock implements IRankRepository {}

void main() {
  late final RankRepositoryMock repository;
  late final ReviewRankEntity rank;
  late final RankError error;
  late final IGetRanksUsecase usecase;

  setUpAll(() {
    repository = RankRepositoryMock();
    rank = ReviewRankEntity(
      id: '01',
      reviewId: '01',
      reviewTitle: 'title',
      relevanceVotes: [],
      notes: [],
    );
    error = GenericRankError(error: 'error');
    usecase = GetRanksUsecase(repository: repository);
    registerFallbackValue(0);
    registerFallbackValue(rank);
  });

  group('get ranks usecase tests', () {
    test('should return a list of ReviewRankEntity', () async {
      when(() => repository.getRanks(any(), any())).thenAnswer(
        (_) => Future(() => ([rank], null)),
      );

      final (success, error) = await usecase(rank, 0);

      expect(error, isNull);
      expect(success, isNotNull);
      expect(success, isA<List<ReviewRankEntity>>());
      expect(success![0].reviewTitle, 'title');
    });

    test('should return an RankError instance', () async {
      when(() => repository.getRanks(any(), any())).thenAnswer(
        (_) => Future(() => (null, error)),
      );

      final (success, failure) = await usecase(rank, 0);

      expect(success, isNull);
      expect(failure, isNotNull);
      expect(failure, isA<RankError>());
      expect(failure!.error, 'error');
    });
  });
}
