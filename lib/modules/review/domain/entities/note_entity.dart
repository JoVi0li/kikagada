class NoteEntity {
  final String id;
  final String authorId;
  final String reviewId;
  final int note;

  NoteEntity({
    required this.id,
    required this.authorId,
    required this.reviewId,
    required this.note,
  }) : assert(note >= 0 && note <= 10, 'Out of range note');

  NoteEntity copyWith({
    String? id,
    String? authorId,
    String? reviewId,
    int? note,
  }) {
    return NoteEntity(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      reviewId: reviewId ?? this.reviewId,
      note: note ?? this.note,
    );
  }
}
