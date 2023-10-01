import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/rank/domain/entities/relevance_vote_entity.dart';
import 'package:kikagada/modules/rank/domain/entities/review_rank_entity.dart';
import 'package:kikagada/modules/rank/domain/errors/rank_errors.dart';
import 'package:kikagada/modules/rank/domain/usecases/get_ranks_usecase.dart';
import 'package:kikagada/modules/rank/domain/usecases/vote_relevance_usecase.dart';
import 'package:kikagada/modules/rank/presenter/states/overview_state.dart';
import 'package:kikagada/modules/rank/presenter/stores/overview_store.dart';
import 'package:mocktail/mocktail.dart';

class GetRanksUsecaseMock extends Mock implements GetRanksUsecase {}

class VoteRelevanceUsecaseMock extends Mock implements VoteRelevanceUsecase {}

void main() {
  late final IGetRanksUsecase getRanksUsecase;
  late final IVoteRelevanceUsecase voteRelevanceUsecase;
  late final OverviewStore store;
  late final ReviewRankEntity reviewRank;
  late final RelevanceVoteEntity relevanceVote;
  late final RankError error;

  setUpAll(() {
    getRanksUsecase = GetRanksUsecaseMock();
    voteRelevanceUsecase = VoteRelevanceUsecaseMock();
    store = OverviewStore(getRanksUsecase, voteRelevanceUsecase);
    reviewRank = ReviewRankEntity(
      id: '01',
      reviewId: '01',
      reviewTitle: 'title',
      relevanceVotes: [],
      notes: [],
    );
    relevanceVote = RelevanceVoteEntity(
      id: '01',
      userId: '01',
      isRelevant: false,
    );
    error = GenericRankError(error: 'error');
    registerFallbackValue(reviewRank);
    registerFallbackValue(relevanceVote);
    registerFallbackValue(25);
  });

  group('overview store tests', () {
    test('should return initial state on create store', () {
      expect(store.value, isA<OverviewInitialState>());
    });

    test('should return loading state while execute getRanks', () async {
      when(() => getRanksUsecase(any(), 25)).thenAnswer(
        (_) => Future(() => ([reviewRank], null)),
      );

      final getRanks = store.getRanks(reviewRank);

      expect(store.value, isA<OverviewLoadingState>());

      await getRanks;
    });

    test('should return loading state while execute voteRelevance', () async {
      when(() => voteRelevanceUsecase(any())).thenAnswer(
        (_) => Future(() => (null, null)),
      );

      final getRanks = store.voteRelevance(relevanceVote);

      expect(store.value, isA<OverviewLoadingState>());

      await getRanks;
    });

    test('should return success state on getRanks', () async {
      when(() => getRanksUsecase(any(), 25)).thenAnswer(
        (_) => Future(() => ([reviewRank], null)),
      );

      await store.getRanks(reviewRank);

      expect(store.value, isA<OverviewSuccessState>());
    });

    test('should return success state on voteRelevance', () async {
      when(() => voteRelevanceUsecase(any())).thenAnswer(
        (_) => Future(() => (null, null)),
      );

      await store.voteRelevance(relevanceVote);

      expect(store.value, isA<OverviewSuccessState>());
    });

    test('should return error state on getRanks', () async {
      when(() => getRanksUsecase(any(), 25)).thenAnswer(
        (_) => Future(() => (null, error)),
      );

      await store.getRanks(reviewRank);

      expect(store.value, isA<OverviewErrorState>());
    });

    test('should return error state on voteRelevance', () async {
      when(() => voteRelevanceUsecase(any())).thenAnswer(
        (_) => Future(() => (null, error)),
      );

      await store.voteRelevance(relevanceVote);

      expect(store.value, isA<OverviewErrorState>());
    });
  });
}
