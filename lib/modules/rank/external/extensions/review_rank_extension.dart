import 'package:kikagada/modules/rank/domain/entities/review_rank_entity.dart';

extension ReviewRankExtension on ReviewRankEntity {
  static ReviewRankEntity fromMap(Map<String, dynamic> map) {
    return ReviewRankEntity(
      id: map['id'],
      reviewId: map['reviewId'],
      reviewTitle: map['reviewTitle'],
      relevanceVotes: map['relevanceVotes'],
      notes: map['notes'],
    );
  }
}
