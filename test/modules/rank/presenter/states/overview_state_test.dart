import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/rank/domain/errors/rank_errors.dart';
import 'package:kikagada/modules/rank/presenter/states/overview_state.dart';

void main() {
  group('overview state tests', () {
    test('OverviewInitialState should be a subclass from OverviewState', () {
      expect(OverviewInitialState(), isA<OverviewState>());
    });

    test('OverviewLoadingState should be a subclass from OverviewState', () {
      expect(OverviewLoadingState(), isA<OverviewState>());
    });

    test('OverviewSuccessState should be a subclass from OverviewState', () {
      expect(
        OverviewSuccessState<List<dynamic>>(
          type: OverviewSuccessStateEnum.getRanks,
          value: [],
        ),
        isA<OverviewState>(),
      );
    });

    test('OverviewErrorState should be a subclass from OverviewState', () {
      expect(
        OverviewErrorState(error: GenericRankError(error: 'error')),
        isA<OverviewState>(),
      );
    });
  });
}
