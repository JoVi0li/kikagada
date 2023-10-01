import 'package:kikagada/modules/rank/domain/entities/relevance_vote_entity.dart';
import 'package:kikagada/modules/review/domain/entities/note_entity.dart';

class ReviewRankEntity {
  final String id;
  final String reviewId;
  final List<RelevanceVoteEntity> relevanceVotes;
  final List<NoteEntity> notes;

  ReviewRankEntity({
    required this.id,
    required this.reviewId,
    required this.relevanceVotes,
    required this.notes,
  })  : assert(id.isNotEmpty, 'id property can not be empty'),
        assert(reviewId.isNotEmpty, 'reviewId property can not be empty');
}
