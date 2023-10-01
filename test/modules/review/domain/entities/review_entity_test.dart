import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/review/domain/entities/note_entity.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';

void main() {
  late final NoteEntity note;
  late final ReviewEntity review;

  setUpAll(() {
    note = NoteEntity(
      id: "01",
      authorId: "01",
      reviewId: "01",
      note: 5,
    );

    review = ReviewEntity(
      id: "01",
      authorId: "01",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      title: "Post 01",
      body: "Post body",
      note: note,
      photos: ["https://photo"],
    );
  });

  group('review entity tests', () {
    test('should create a ReviewEntity instance correctly', () {
      expect(review, isA<ReviewEntity>());
    });

    test('should not create a ReviewEntity instance if photos is empty', () {
      expect(() => review.copyWith(photos: []), throwsAssertionError);
    });

    test('should not create a ReviewEntity instance if title is empty', () {
      expect(() => review.copyWith(title: ""), throwsAssertionError);
    });

    test('should not create a ReviewEntity instance if body is empty', () {
      expect(() => review.copyWith(body: ""), throwsAssertionError);
    });

    test('should return a copy of reviewEntity', () {
      ReviewEntity myReview = review;

      expect(myReview.title, 'Post 01');

      myReview = myReview.copyWith(title: 'Copy 01');

      expect(myReview.title, 'Copy 01');
    });
  });
}
