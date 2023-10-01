import 'package:kikagada/modules/rank/domain/errors/rank_errors.dart';

enum OverviewSuccessStateEnum { getRanks, voteRelevance }

abstract base class OverviewState {}

final class OverviewInitialState extends OverviewState {}

final class OverviewLoadingState extends OverviewState {}

final class OverviewSuccessState<T> extends OverviewState {
  OverviewSuccessState({required this.type, required this.value});
  final OverviewSuccessStateEnum type;
  final T value;
}

final class OverviewErrorState extends OverviewState {
  OverviewErrorState({required this.error});
  final RankError error;
}
