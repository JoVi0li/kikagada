import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';
import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';
import 'package:kikagada/modules/review/domain/usecases/create_review_usecase/create_review_usecase.dart';
import 'package:mocktail/mocktail.dart';

class ReviewRepositoryMock extends Mock implements IReviewRepository {}

void main() {
  late final ReviewRepositoryMock repository;
  late final ReviewEntity review;
  late final BaseException error;
  late final ICreateReviewUsecase usecase;

  setUpAll(() {
    repository = ReviewRepositoryMock();
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
    usecase = CreateReviewUsecase(repository: repository);
    registerFallbackValue(review);
  });

  group('create review usecase tests', () {
    test('should return a ReviewEntity instance', () async {
      when(() => repository.create(any())).thenAnswer(
        (_) => Future(() => (review, null)),
      );

      final (success, error) = await usecase(review);

      expect(error, isNull);
      expect(success, isNotNull);
      expect(success, isA<ReviewEntity>());
      expect(success!.authorId, '01');
    });

    test('should return a BaseException instance', () async {
      when(() => repository.create(any())).thenAnswer(
        (_) => Future(() => (null, error)),
      );

      final (success, failure) = await usecase(review);

      expect(success, isNull);
      expect(failure, isNotNull);
      expect(failure, isA<BaseException>());
      expect(failure!.exception.toString(), 'Exception: error');
    });
  });
}
