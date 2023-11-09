import 'package:firebase_auth/firebase_auth.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';
import 'package:kikagada/modules/review/infra/datasources/review_datasource.dart';

class ReviewRepository implements IReviewRepository {
  ReviewRepository({required IReviewDatasource datasource})
      : _datasource = datasource;

  final IReviewDatasource _datasource;

  @override
  Future<(ReviewEntity?, ReviewError?)> create(ReviewEntity review) async {
    try {
      return (await _datasource.create(review), null);
    } on FirebaseException catch (e) {
      return (
        null,
        GenericFirebaseReviewError(error: e.code, message: e.message)
      );
    } catch (e) {
      return (null, GenericReviewError(error: e.toString(), message: null));
    }
  }

  @override
  Future<(ReviewEntity?, ReviewError?)> delete(String id) async {
    try {
      return (await _datasource.delete(id), null);
    } on FirebaseException catch (e) {
      return (
        null,
        GenericFirebaseReviewError(error: e.code, message: e.message)
      );
    } catch (e) {
      return (null, GenericReviewError(error: e.toString(), message: null));
    }
  }

  @override
  Future<(ReviewEntity?, ReviewError?)> getById(String id) async {
    try {
      return (await _datasource.getById(id), null);
    } on FirebaseException catch (e) {
      return (
        null,
        GenericFirebaseReviewError(error: e.code, message: e.message)
      );
    } catch (e) {
      return (null, GenericReviewError(error: e.toString(), message: null));
    }
  }

  @override
  Future<(ReviewEntity?, ReviewError?)> update(ReviewEntity review) async {
    try {
      return (await _datasource.update(review), null);
    } on FirebaseException catch (e) {
      return (
        null,
        GenericFirebaseReviewError(error: e.code, message: e.message)
      );
    } catch (e) {
      return (null, GenericReviewError(error: e.toString(), message: null));
    }
  }

  @override
  Future<(List<ReviewEntity>?, ReviewError?)> getReviews(
    ReviewEntity? starterAfter,
    int? limit,
  ) async {
    try {
      return (await _datasource.getReviews(starterAfter, limit), null);
    } on FirebaseException catch (e) {
      return (
        null,
        GenericFirebaseReviewError(error: e.code, message: e.message)
      );
    } catch (e) {
      return (null, GenericReviewError(error: e.toString(), message: null));
    }
  }

  @override
  Future<(List<String>?, ReviewError?)> uploadPhotos(
      List<String> photosPath) async {
    try {
      return (await _datasource.uploadPhotos(photosPath), null);
    } on FirebaseException catch (e) {
      return (
        null,
        GenericFirebaseReviewError(error: e.code, message: e.message)
      );
    } catch (e) {
      return (null, GenericReviewError(error: e.toString(), message: null));
    }
  }

  @override
  Future<(List<String>?, ReviewError?)> getPhotosDownloadURL(
    List<String> photosPath,
  ) async {
    try {
      return (await _datasource.getPhotosDownloadURL(photosPath), null);
    } on FirebaseException catch (e) {
      return (
        null,
        GenericFirebaseReviewError(error: e.code, message: e.message)
      );
    } catch (e) {
      return (null, GenericReviewError(error: e.toString(), message: null));
    }
  }

  @override
  Future<(List<ReviewEntity>?, ReviewError?)> getMyReviews(
    ReviewEntity? starterAfter,
    int? limit,
  ) async {
    try {
      return (await _datasource.getMyReviews(starterAfter, limit), null);
    } on FirebaseException catch (e) {
      return (
        null,
        GenericFirebaseReviewError(error: e.code, message: e.message)
      );
    } catch (e) {
      return (null, GenericReviewError(error: e.toString(), message: null));
    }
  }
}
