import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/presenter/states/review_details_state.dart';

void main() {
  late final ReviewEntity review;
  late final ReviewError error;

  setUpAll(() {
    review = ReviewEntity(
      id: "01",
      authorId: "01",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      title: "Post 01",
      body: "Post body",
      photos: ["https://photo"],
    );
    error = GenericFirestoreReviewError(error: 'error', message: null);
  });

  group('review details state tests', () {
    test(
      'InitialReviewDetailsState should be a subclass from ReviewDetailsState',
      () {
        expect(InitialReviewDetailsState(), isA<ReviewDetailsState>());
      },
    );
    test(
      'LoadingReviewDetailsState should be a subclass from ReviewDetailsState',
      () {
        expect(LoadingReviewDetailsState(), isA<ReviewDetailsState>());
      },
    );
    test(
      'SuccessReviewDetailsState should be a subclass from ReviewDetailsState',
      () {
        expect(SuccessReviewDetailsState(review: review),
            isA<ReviewDetailsState>());
      },
    );
    test(
      'ErrorReviewDetailsState should be a subclass from ReviewDetailsState',
      () {
        expect(ErrorReviewDetailsState(error: error), isA<ReviewDetailsState>());
      },
    );
  });
}
