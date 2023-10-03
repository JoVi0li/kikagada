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
  late final ReviewError error;

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
    error = GenericFirestoreReviewError(error: 'error', message: null);
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

  test('should return a ReviewError after tried create it', () async {
    when(() => datasource.create(any())).thenThrow(error);

    final (success, failure) = await repository.create(review);

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<ReviewError>());
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

  test('should return a ReviewError after tried get it', () async {
    when(() => datasource.getById(any())).thenThrow(error);

    final (success, failure) = await repository.getById('01');

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<ReviewError>());
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

  test('should return a ReviewError after tried delete it', () async {
    when(() => datasource.delete(any())).thenThrow(error);

    final (success, failure) = await repository.delete('01');

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<ReviewError>());
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

  test('should return a ReviewError after tried update it', () async {
    when(() => datasource.update(any())).thenThrow(error);

    final (success, failure) = await repository.update(review);

    expect(success, isNull);
    expect(failure, isNotNull);
    expect(failure, isA<ReviewError>());
    expect(failure!.error, isNotEmpty);
  });
}
