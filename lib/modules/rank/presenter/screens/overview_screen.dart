import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/rank/presenter/components/rank_card_component.dart';
import 'package:kikagada/modules/rank/presenter/stores/overview_store.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  late final GetIt _getIt;
  late final IOverviewStore _store;

  @override
  void initState() {
    super.initState();
    _getIt = GetIt.I;
    _store = _getIt<IOverviewStore>();
    _store.getRanks(null);
  }

  @override
  void dispose() {
    _getIt.resetLazySingleton<IOverviewStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) {
          return RankCardComponent(
            title: 'teste $index',
            onRatingUpdate: (rating) {},
            onVoteRelevance: (isRelevant) {},
            typeVoteRelevance: index % 2 == 0
                ? TypeVoteRelevance.relevant
                : TypeVoteRelevance.notRelevant,
          );
        },
      ),
    );
  }
}
