import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';
import 'package:kikagada/modules/review/presenter/states/review_details_state.dart';

void main() {
  late final ReviewEntity review;
  late final BaseException error;

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
    error = BaseException.basicException(exception: Exception("error"), stackTrace: StackTrace.fromString(""));
  });

  group('review details state tests', () {
    test(
      'LoadingReviewDetailsState should be a subclass from ReviewDetailsState',
      () {
        expect(ReviewDetailsLoadingState(), isA<ReviewDetailsState>());
      },
    );
    test(
      'SuccessReviewDetailsState should be a subclass from ReviewDetailsState',
      () {
        expect(ReviewDetailsSuccessState(review: review),
            isA<ReviewDetailsState>());
      },
    );
    test(
      'ErrorReviewDetailsState should be a subclass from ReviewDetailsState',
      () {
        expect(
            ReviewDetailsErrorState(error: error), isA<ReviewDetailsState>());
      },
    );
  });
}
