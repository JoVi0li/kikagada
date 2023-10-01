import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/review/domain/entities/note_entity.dart';

void main() {
  late final NoteEntity note;

  setUpAll(() {
    note = NoteEntity(
      id: "01",
      authorId: "01",
      reviewId: "01",
      note: 10,
    );
  });
  group('note entity tests', () {
    test('should create a NoteEntity instance correctly', () {
      expect(note, isA<NoteEntity>());
    });

    test('should thrown assertion error if note is out of the range', () {
      expect(() => note.copyWith(note: 20), throwsAssertionError);
    });

    test('should return a copy of NoteEntity', () {
      NoteEntity myNote = note;

      expect(myNote.note, 10);

      myNote = myNote.copyWith(note: 5);

      expect(myNote.note, 5);
    });
  });
}
