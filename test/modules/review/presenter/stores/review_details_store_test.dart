import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/domain/usecases/get_review_by_id_usecase/get_review_by_id.dart';
import 'package:kikagada/modules/review/domain/usecases/update_review_usecase/update_review_usecase.dart';
import 'package:kikagada/modules/review/presenter/states/review_details_state.dart';
import 'package:kikagada/modules/review/presenter/stores/review_details_store.dart';
import 'package:mocktail/mocktail.dart';

class GetReviewByIdUsecaseMock extends Mock implements IGetReviewByIdUsecase {}

class UpdateReviewUsecaseMock extends Mock implements IUpdateReviewUsecase {}

void main() {
  late final IGetReviewByIdUsecase getReviewByIdUsecase;
  late final IUpdateReviewUsecase updateReviewUsecase;
  late final ReviewEntity review;
  late final ReviewError error;
  late final ReviewDetailsStore store;

  setUpAll(() {
    getReviewByIdUsecase = GetReviewByIdUsecaseMock();
    updateReviewUsecase = UpdateReviewUsecaseMock();
    store = ReviewDetailsStore(getReviewByIdUsecase, updateReviewUsecase);
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
    registerFallbackValue("01");
    registerFallbackValue(review);
  });
  group('review details store tests', () {
    test('should return initial state on create store', () {
      expect(store.value, isA<InitialReviewDetailsState>());
    });

    test('should return loading state while execute tasks', () async {
      when(() => getReviewByIdUsecase(any()))
          .thenAnswer((_) => Future.value((review, null)));

      final getById = store.getById('01');

      expect(store.value, isA<LoadingReviewDetailsState>());

      await getById;
    });

    test('should return success state on getById', () async {
      when(() => getReviewByIdUsecase(any()))
          .thenAnswer((_) => Future.value((review, null)));

      await store.getById("01");

      expect(store.value, isA<SuccessReviewDetailsState>());
    });

    test('should return error state on getById', () async {
      when(() => getReviewByIdUsecase(any()))
          .thenAnswer((_) => Future.value((null, error)));

      await store.getById("01");

      expect(store.value, isA<ErrorReviewDetailsState>());
    });

    test('should return success state on update', () async {
      when(() => updateReviewUsecase(any()))
          .thenAnswer((_) => Future.value((review, null)));

      await store.update(review);

      expect(store.value, isA<SuccessReviewDetailsState>());
    });

    test('should return error state on update', () async {
      when(() => updateReviewUsecase(any()))
          .thenAnswer((_) => Future.value((null, error)));

      await store.update(review);

      expect(store.value, isA<ErrorReviewDetailsState>());
    });
  });
}
