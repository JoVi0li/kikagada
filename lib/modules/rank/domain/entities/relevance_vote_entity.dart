class RelevanceVoteEntity {
  final String id;
  final String userId;
  final bool isRelevant;

  RelevanceVoteEntity({
    required this.id,
    required this.userId,
    required this.isRelevant,
  })  : assert(id.isNotEmpty, 'id property can not be empty'),
        assert(userId.isNotEmpty, 'userId can not be empty');
}
