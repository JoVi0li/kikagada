import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/external/extensions/note_entity_extension.dart';

extension ReviewEntityExtension on ReviewEntity {
  static Map<String, dynamic> toMap(ReviewEntity review) {
    return {
      'id': review.id,
      'authorId': review.authorId,
      'createdAt': review.createdAt,
      'updatedAt': review.updatedAt,
      'title': review.title,
      'body': review.body,
      'note': review.note,
      'photos': review.photos,
    };
  }

  static ReviewEntity fromMap(Map<String, dynamic> review) {
    return ReviewEntity(
      id: review['id'],
      authorId: review['authorId'],
      createdAt: DateTime.parse(review['createdAt']),
      updatedAt: DateTime.parse(review['updatedAt']),
      title: review['title'],
      body: review['body'],
      note: NoteEntityExtension.fromMap(review['note']),
      photos: List<String>.from(review['photos']),
    );
  }
}
