import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/review/domain/entities/note_entity.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';
import 'package:kikagada/modules/review/domain/usecases/get_review_by_id_usecase/get_review_by_id.dart';
import 'package:mocktail/mocktail.dart';

class ReviewRepositoryMock extends Mock implements IReviewRepository {}

void main() {
  late final ReviewRepositoryMock repository;
  late final NoteEntity note;
  late final ReviewEntity review;
  late final ReviewError error;
  late final IGetReviewByIdUsecase usecase;

  setUpAll(() {
    repository = ReviewRepositoryMock();
    note = NoteEntity(
      id: "01",
      authorId: "01",
      reviewId: "01",
      note: 10,
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
    error = GenericReviewError(error: 'error', message: null);
    usecase = GetReviewByIdUsecase(repository: repository);
    registerFallbackValue("01");
  });

  group('create review usecase tests', () {
    test('should return a ReviewEntity instance', () async {
      when(() => repository.getById(any())).thenAnswer(
        (_) => Future(() => (review, null)),
      );

      final (success, error) = await usecase('01');

      expect(error, isNull);
      expect(success, isNotNull);
      expect(success, isA<ReviewEntity>());
      expect(success!.authorId, '01');
    });

    test('should return a ReviewError instance', () async {
      when(() => repository.getById(any())).thenAnswer(
        (_) => Future(() => (null, error)),
      );

      final (success, failure) = await usecase('01');

      expect(success, isNull);
      expect(failure, isNotNull);
      expect(failure, isA<ReviewError>());
      expect(failure!.error, 'error');
    });
  });
}