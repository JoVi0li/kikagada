import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kikagada/modules/rank/domain/entities/relevance_vote_entity.dart';
import 'package:kikagada/modules/rank/domain/entities/review_rank_entity.dart';
import 'package:kikagada/modules/rank/external/extensions/relevance_vote_extension.dart';
import 'package:kikagada/modules/rank/external/extensions/review_rank_extension.dart';
import 'package:kikagada/modules/rank/infra/datasources/rank_datasource.dart';

class FirestoreRankDatasource implements IRankDatasource {
  final FirebaseFirestore _firestore;

  FirestoreRankDatasource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<List<ReviewRankEntity>> getRanks(
      ReviewRankEntity? starterAfter, int? limit) async {
    if (starterAfter != null) {
      return await _firestore
          .collection('reviewRanks')
          .limit(limit ?? 25)
          .startAfter([starterAfter])
          .get()
          .then((querySnap) => querySnap.docs
              .map((queryDocSnap) =>
                  ReviewRankExtension.fromMap(queryDocSnap.data()))
              .toList());
    }

    return await _firestore
        .collection('reviewRanks')
        .limit(limit ?? 25)
        .get()
        .then((querySnap) => querySnap.docs
            .map((queryDocSnap) =>
                ReviewRankExtension.fromMap(queryDocSnap.data()))
            .toList());
  }

  @override
  Future<void> voteRelevance(RelevanceVoteEntity relevance) async {
    await _firestore
      .collection('reviewRanks')
      .doc(relevance.id)
      .set(relevance.toMap());
  }
}
