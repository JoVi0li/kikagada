import 'package:flutter/foundation.dart';
import 'package:kikagada/modules/rank/domain/entities/relevance_vote_entity.dart';
import 'package:kikagada/modules/rank/domain/entities/review_rank_entity.dart';
import 'package:kikagada/modules/rank/domain/usecases/get_ranks_usecase.dart';
import 'package:kikagada/modules/rank/domain/usecases/vote_relevance_usecase.dart';
import 'package:kikagada/modules/rank/presenter/states/overview_state.dart';

abstract interface class IOverviewStore extends ValueListenable<OverviewState> {
  Future<void> getRanks(ReviewRankEntity? startAfter);
  Future<void> voteRelevance(RelevanceVoteEntity entity);
}

class OverviewStore extends ValueNotifier<OverviewState>
    implements IOverviewStore {
  OverviewStore(this._getRanksUsecase, this._voteRelevanceUsecase)
      : super(OverviewInitialState());

  final IGetRanksUsecase _getRanksUsecase;
  final IVoteRelevanceUsecase _voteRelevanceUsecase;

  @override
  Future<void> getRanks(ReviewRankEntity? startAfter) async {
    value = OverviewLoadingState();

    final (ranks, error) = await _getRanksUsecase(startAfter, 25);

    if (error != null) {
      value = OverviewErrorState(error: error);
      return;
    }

    if (ranks != null) {
      value = OverviewSuccessState<List<ReviewRankEntity>>(
        type: OverviewSuccessStateEnum.getRanks,
        value: ranks,
      );
      return;
    }
  }

  @override
  Future<void> voteRelevance(RelevanceVoteEntity entity) async {
    value = OverviewLoadingState();

    final (_, error) = await _voteRelevanceUsecase(entity);

    if (error != null) {
      value = OverviewErrorState(error: error);
      return;
    }

    value = OverviewSuccessState<void>(
      type: OverviewSuccessStateEnum.voteRelevance,
      value: null,
    );
  }
}
