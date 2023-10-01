import 'package:kikagada/modules/rank/domain/entities/relevance_vote_entity.dart';

extension RelevanceVoteExtension on RelevanceVoteEntity {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'isRelevant': isRelevant,
    };
  }
}
