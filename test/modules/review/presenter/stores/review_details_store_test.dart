import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';
import 'package:kikagada/modules/review/domain/usecases/get_photos_download_url_usecase/get_photos_download_url_usecase.dart';
import 'package:kikagada/modules/review/domain/usecases/get_review_by_id_usecase/get_review_by_id.dart';
import 'package:kikagada/modules/review/domain/usecases/update_review_usecase/update_review_usecase.dart';
import 'package:kikagada/modules/review/presenter/states/review_details_state.dart';
import 'package:kikagada/modules/review/presenter/stores/review_details_store.dart';
import 'package:mocktail/mocktail.dart';

class GetReviewByIdUsecaseMock extends Mock implements IGetReviewByIdUsecase {}

class UpdateReviewUsecaseMock extends Mock implements IUpdateReviewUsecase {}

class GetPhotosDownloadURLMock extends Mock implements IGetPhotosDownloadURL {}

void main() {
  late final IGetReviewByIdUsecase getReviewByIdUsecase;
  late final IUpdateReviewUsecase updateReviewUsecase;
  late final IGetPhotosDownloadURL getPhotosDownloadURL;
  late final ReviewEntity review;
  late final BaseException error;
  late final ReviewDetailsStore store;

  setUpAll(() {
    getReviewByIdUsecase = GetReviewByIdUsecaseMock();
    updateReviewUsecase = UpdateReviewUsecaseMock();
    getPhotosDownloadURL = GetPhotosDownloadURLMock();
    store = ReviewDetailsStore(
      getReviewByIdUsecase,
      updateReviewUsecase,
      getPhotosDownloadURL,
    );
    review = ReviewEntity(
      id: "01",
      authorId: "01",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      title: "Post 01",
      body: "Post body",
      photos: ["https://photo"],
    );
    error = BaseException.firebaseException(exception: Exception('error'), message: null);
    registerFallbackValue("01");
    registerFallbackValue(review);
    registerFallbackValue([""]);
  });
  group('review details store tests', () {
    test('should return loading state on create store', () {
      expect(store.value, isA<ReviewDetailsLoadingState>());
    });

    test('should return loading state while execute tasks', () async {
      when(() => getReviewByIdUsecase(any()))
          .thenAnswer((_) => Future.value((review, null)));
      when(() => getPhotosDownloadURL(any()))
          .thenAnswer((_) => Future.value(([''], null)));

      final getById = store.getById('01');

      expect(store.value, isA<ReviewDetailsLoadingState>());

      await getById;
    });

    test('should return success state on getById', () async {
      when(() => getReviewByIdUsecase(any()))
          .thenAnswer((_) => Future.value((review, null)));
      when(() => getPhotosDownloadURL(any()))
          .thenAnswer((_) => Future.value(([''], null)));

      await store.getById("01");

      expect(store.value, isA<ReviewDetailsSuccessState>());
    });

    test('should return error state on getById', () async {
      when(() => getReviewByIdUsecase(any()))
          .thenAnswer((_) => Future.value((null, error)));

      await store.getById("01");

      expect(store.value, isA<ReviewDetailsErrorState>());
    });

    test(
        'should return error state on getById after tried get the photos download url',
        () async {
      when(() => getReviewByIdUsecase(any()))
          .thenAnswer((_) => Future.value((review, null)));
      when(() => getPhotosDownloadURL(any()))
          .thenAnswer((_) => Future.value((null, error)));
      await store.getById("01");

      expect(store.value, isA<ReviewDetailsErrorState>());
    });

    test('should return success state on update', () async {
      when(() => updateReviewUsecase(any()))
          .thenAnswer((_) => Future.value((review, null)));

      await store.update(review);

      expect(store.value, isA<ReviewDetailsSuccessState>());
    });

    test('should return error state on update', () async {
      when(() => updateReviewUsecase(any()))
          .thenAnswer((_) => Future.value((null, error)));

      await store.update(review);

      expect(store.value, isA<ReviewDetailsErrorState>());
    });
  });
}
