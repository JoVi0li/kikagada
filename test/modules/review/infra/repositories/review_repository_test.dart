import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';
import 'package:kikagada/modules/review/infra/datasources/review_datasource.dart';
import 'package:kikagada/modules/review/infra/repositories/review_repository.dart';
import 'package:mocktail/mocktail.dart';

class ReviewDatasourceMock extends Mock implements IReviewDatasource {}

void main() {
  late IReviewDatasource datasource;
  late IReviewRepository repository;
  late final ReviewEntity review;
  late final Exception error;
  late final FirebaseException firebaseError;

  setUpAll(() {
    datasource = ReviewDatasourceMock();
    repository = ReviewRepository(datasource: datasource);
    review = ReviewEntity(
      id: "01",
      authorId: "01",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      title: "Post 01",
      body: "Post body",
      photos: ["https://photo"],
    );
    error = Exception('error');
    firebaseError = FirebaseException(plugin: 'test');
    registerFallbackValue(review);
    registerFallbackValue("");
  });

  group('review repository tests', () {
    test('should return a ReviewEntity after created it', () async {
      when(() => datasource.create(any())).thenAnswer(
        (_) => Future(() => review),
      );

      final (success, error) = await repository.create(review);

      expect(error, isNull);
      expect(success, isNotNull);
      expect(success, isA<ReviewEntity>());
      expect(success!.id, '01');
    });
  });

  test('should return a GenericReviewError after tried create it', () async {
    when(() => datasource.create(any())).thenThrow(error);

    final (success, failure) = await repository.create(review);

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericReviewError>());
    expect(failure!.error, isNotEmpty);
  });

  test('should return a GenericFirebaseReviewError after tried create it',
      () async {
    when(() => datasource.create(any())).thenThrow(firebaseError);

    final (success, failure) = await repository.create(review);

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericFirebaseReviewError>());
    expect(failure!.error, isNotEmpty);
  });

  test('should return a ReviewEntity after get it', () async {
    when(() => datasource.getById(any())).thenAnswer(
      (_) => Future(() => review),
    );

    final (success, error) = await repository.getById('01');

    expect(error, isNull);
    expect(success, isNotNull);
    expect(success, isA<ReviewEntity>());
    expect(success!.id, '01');
  });

  test('should return a GenericReviewError after tried get it', () async {
    when(() => datasource.getById(any())).thenThrow(error);

    final (success, failure) = await repository.getById('01');

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericReviewError>());
    expect(failure!.error, isNotEmpty);
  });

  test('should return a GenericFirebaseReviewError after tried get it',
      () async {
    when(() => datasource.getById(any())).thenThrow(firebaseError);

    final (success, failure) = await repository.getById('01');

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericFirebaseReviewError>());
    expect(failure!.error, isNotEmpty);
  });

  test('should return a list of ReviewEntity after get yourself reviews',
      () async {
    when(() => datasource.getMyReviews(null, null)).thenAnswer(
      (_) => Future(() => [review]),
    );

    final (success, error) = await repository.getMyReviews(null, null);

    expect(error, isNull);
    expect(success, isNotNull);
    expect(success, isA<List<ReviewEntity>>());
    expect(success!.length, 1);
  });

  test('should return a GenericReviewError after tried get yourself reviews',
      () async {
    when(() => datasource.getMyReviews(null, null)).thenThrow(error);

    final (success, failure) = await repository.getMyReviews(null, null);

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericReviewError>());
    expect(failure!.error, isNotEmpty);
  });

  test(
      'should return a GenericFirebaseReviewError after tried get yourself reviews',
      () async {
    when(() => datasource.getMyReviews(null, null)).thenThrow(firebaseError);

    final (success, failure) = await repository.getMyReviews(null, null);

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericFirebaseReviewError>());
    expect(failure!.error, isNotEmpty);
  });

  test('should return a list of ReviewEntity after get a list of reviews',
      () async {
    when(() => datasource.getReviews(null, null)).thenAnswer(
      (_) => Future(() => [review]),
    );

    final (success, error) = await repository.getReviews(null, null);

    expect(error, isNull);
    expect(success, isNotNull);
    expect(success, isA<List<ReviewEntity>>());
    expect(success!.length, 1);
  });

  test('should return a GenericReviewError after tried get a list of reviews',
      () async {
    when(() => datasource.getReviews(null, null)).thenThrow(error);

    final (success, failure) = await repository.getReviews(null, null);

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericReviewError>());
    expect(failure!.error, isNotEmpty);
  });

  test(
      'should return a GenericFirebaseReviewError after tried get a list of reviews',
      () async {
    when(() => datasource.getReviews(null, null)).thenThrow(firebaseError);

    final (success, failure) = await repository.getReviews(null, null);

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericFirebaseReviewError>());
    expect(failure!.error, isNotEmpty);
  });

  test('should return a ReviewEntity after deleted it', () async {
    when(() => datasource.delete(any())).thenAnswer(
      (_) => Future(() => review),
    );

    final (success, error) = await repository.delete('01');

    expect(error, isNull);
    expect(success, isNotNull);
    expect(success, isA<ReviewEntity>());
    expect(success!.id, '01');
  });

  test('should return a GenericReviewError after tried delete it', () async {
    when(() => datasource.delete(any())).thenThrow(error);

    final (success, failure) = await repository.delete('01');

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericReviewError>());
    expect(failure!.error, isNotEmpty);
  });

  test('should return a GenericFirebaseReviewError after tried delete it',
      () async {
    when(() => datasource.delete(any())).thenThrow(firebaseError);

    final (success, failure) = await repository.delete('01');

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericFirebaseReviewError>());
    expect(failure!.error, isNotEmpty);
  });

  test('should return a ReviewEntity after updated it', () async {
    when(() => datasource.update(any())).thenAnswer(
      (_) => Future(() => review),
    );

    final (success, error) = await repository.update(review);

    expect(error, isNull);
    expect(success, isNotNull);
    expect(success, isA<ReviewEntity>());
    expect(success!.id, '01');
  });

  test('should return a GenericReviewError after tried update it', () async {
    when(() => datasource.update(any())).thenThrow(error);

    final (success, failure) = await repository.update(review);

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericReviewError>());
    expect(failure!.error, isNotEmpty);
  });

  test('should return a GenericFirebaseReviewError after tried update it',
      () async {
    when(() => datasource.update(any())).thenThrow(firebaseError);

    final (success, failure) = await repository.update(review);

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericFirebaseReviewError>());
    expect(failure!.error, isNotEmpty);
  });

  test('should return a list of photo paths after uploaded its', () async {
    when(() => datasource.uploadPhotos(any())).thenAnswer(
      (_) => Future(() => ['http://mock.photo']),
    );

    final (success, error) = await repository.uploadPhotos([]);

    expect(error, isNull);
    expect(success, isNotNull);
    expect(success, isA<List<String>>());
    expect(success!.length, 1);
  });

  test('should return a GenericReviewError after tried upload some photos',
      () async {
    when(() => datasource.uploadPhotos(any())).thenThrow(error);

    final (success, failure) = await repository.uploadPhotos([]);

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericReviewError>());
    expect(failure!.error, isNotEmpty);
  });

  test(
      'should return a GenericFirebaseReviewError after tried upload some photos',
      () async {
    when(() => datasource.uploadPhotos(any())).thenThrow(firebaseError);

    final (success, failure) = await repository.uploadPhotos([]);

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericFirebaseReviewError>());
    expect(failure!.error, isNotEmpty);
  });

  test('should return a list of photos download url after get its', () async {
    when(() => datasource.getPhotosDownloadURL(any())).thenAnswer(
      (_) => Future(() => ['http://mock.photo']),
    );

    final (success, error) = await repository.getPhotosDownloadURL([]);

    expect(error, isNull);
    expect(success, isNotNull);
    expect(success, isA<List<String>>());
    expect(success!.length, 1);
  });

  test(
      'should return a GenericReviewError after tried get a list of photos download url',
      () async {
    when(() => datasource.getPhotosDownloadURL(any())).thenThrow(error);

    final (success, failure) = await repository.getPhotosDownloadURL([]);

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericReviewError>());
    expect(failure!.error, isNotEmpty);
  });

  test(
      'should return a GenericFirebaseReviewError after tried get a list of photos download url',
      () async {
    when(() => datasource.getPhotosDownloadURL(any())).thenThrow(firebaseError);

    final (success, failure) = await repository.getPhotosDownloadURL([]);

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<GenericFirebaseReviewError>());
    expect(failure!.error, isNotEmpty);
  });
}
