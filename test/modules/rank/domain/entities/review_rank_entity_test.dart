import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/rank/domain/entities/review_rank_entity.dart';

void main() {
  group('review rank entity tests', () {
    test('should throw an assertion error when id property is empty', () {
      void createReviewRankEntity() {
        ReviewRankEntity(id: '', reviewId: '01', reviewTitle: 'title', relevanceVotes: [], notes: [],);
      }

      expect(createReviewRankEntity, throwsAssertionError);
    });

    test('should throw an assertion error when reviewId property is empty', () {
      void createReviewRankEntity() {
        ReviewRankEntity(id: '01', reviewId: '', reviewTitle: 'title', relevanceVotes: [], notes: [],);
      }

      expect(createReviewRankEntity, throwsAssertionError);
    });

    test('should throw an assertion error when reviewTitle property is empty', () {
      void createReviewRankEntity() {
        ReviewRankEntity(id: '01', reviewId: '01', reviewTitle: '', relevanceVotes: [], notes: [],);
      }

      expect(createReviewRankEntity, throwsAssertionError);
    });

    test('should create an instance of ReviewRankEntity', () {
      expect(
          ReviewRankEntity(id: '01', reviewId: '01', reviewTitle: 'title', relevanceVotes: [], notes: []),
          isA<ReviewRankEntity>());
    });
  });
}
