import 'package:kikagada/modules/review/domain/entities/note_entity.dart';

extension NoteEntityExtension on NoteEntity {
  static NoteEntity fromMap(Map<String, dynamic> note) {
    return NoteEntity(
      id: note['id'],
      authorId: note['authorId'],
      reviewId: note['reviewId'],
      note: note['note'],
    );
  }
}
