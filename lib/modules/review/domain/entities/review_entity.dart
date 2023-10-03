class ReviewEntity {
  final String id;
  final String authorId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final String body;
  final List<String> photos;

  ReviewEntity({
    required this.id,
    required this.authorId,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.body,
    required this.photos,
  })  : assert(photos.isNotEmpty, 'Required one photo least'),
        assert(title.isNotEmpty, 'Title can not be empty'),
        assert(body.isNotEmpty, 'Body can not be empty');

  ReviewEntity copyWith({
    String? id,
    String? authorId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    String? body,
    List<String>? photos,
  }) {
    return ReviewEntity(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      body: body ?? this.body,
      photos: photos ?? this.photos,
    );
  }
}
