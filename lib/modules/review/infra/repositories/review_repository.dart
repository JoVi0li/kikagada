import 'package:firebase_core/firebase_core.dart' as firebase;
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';
import 'package:kikagada/modules/review/infra/datasources/review_datasource.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

class ReviewRepository implements IReviewRepository {
  ReviewRepository({required IReviewDatasource datasource})
      : _datasource = datasource;

  final IReviewDatasource _datasource;

  @override
  Future<(ReviewEntity?, BaseException?)> create(ReviewEntity review) async {
    try {
      return (await _datasource.create(review), null);
    } on firebase.FirebaseException catch (e, s) {
      return (
        null,
        BaseException.firebaseException(
          stackTrace: s,
          exception: e,
          message: e.message,
        ),
      );
    } catch (e, s) {
      return (
        null,
        BaseException.basicException(
          stackTrace: s,
          exception: e as Exception,
        ),
      );
    }
  }

  @override
  Future<(ReviewEntity?, BaseException?)> delete(String id) async {
    try {
      return (await _datasource.delete(id), null);
    } on firebase.FirebaseException catch (e, s) {
      return (
        null,
        BaseException.firebaseException(
          stackTrace: s,
          exception: e,
          message: e.message,
        ),
      );
    } catch (e, s) {
      return (
        null,
        BaseException.basicException(
          stackTrace: s,
          exception: e as Exception,
        ),
      );
    }
  }

  @override
  Future<(ReviewEntity?, BaseException?)> getById(String id) async {
    try {
      return (await _datasource.getById(id), null);
    } on firebase.FirebaseException catch (e, s) {
      return (
        null,
        BaseException.firebaseException(
          stackTrace: s,
          exception: e,
          message: e.message,
        ),
      );
    } catch (e, s) {
      return (
        null,
        BaseException.basicException(
          stackTrace: s,
          exception: e as Exception,
        ),
      );
    }
  }

  @override
  Future<(ReviewEntity?, BaseException?)> update(ReviewEntity review) async {
    try {
      return (await _datasource.update(review), null);
    } on firebase.FirebaseException catch (e, s) {
      return (
        null,
        BaseException.firebaseException(
          stackTrace: s,
          exception: e,
          message: e.message,
        ),
      );
    } catch (e, s) {
      return (
        null,
        BaseException.basicException(
          stackTrace: s,
          exception: e as Exception,
        ),
      );
    }
  }

  @override
  Future<(List<ReviewEntity>?, BaseException?)> getReviews(
    ReviewEntity? starterAfter,
    int? limit,
  ) async {
    try {
      return (await _datasource.getReviews(starterAfter, limit), null);
    } on firebase.FirebaseException catch (e, s) {
      return (
        null,
        BaseException.firebaseException(
          stackTrace: s,
          exception: e,
          message: e.message,
        ),
      );
    } catch (e, s) {
      return (
        null,
        BaseException.basicException(
          stackTrace: s,
          exception: e as Exception,
        ),
      );
    }
  }

  @override
  Future<(List<String>?, BaseException?)> uploadPhotos(
      List<String> photosPath) async {
    try {
      return (await _datasource.uploadPhotos(photosPath), null);
    } on firebase.FirebaseException catch (e, s) {
      return (
        null,
        BaseException.firebaseException(
          stackTrace: s,
          exception: e,
          message: e.message,
        ),
      );
    } catch (e, s) {
      return (
        null,
        BaseException.basicException(
          stackTrace: s,
          exception: e as Exception,
        ),
      );
    }
  }

  @override
  Future<(List<String>?, BaseException?)> getPhotosDownloadURL(
    List<String> photosPath,
  ) async {
    try {
      return (await _datasource.getPhotosDownloadURL(photosPath), null);
    } on firebase.FirebaseException catch (e, s) {
      return (
        null,
        BaseException.firebaseException(
          stackTrace: s,
          exception: e,
          message: e.message,
        ),
      );
    } catch (e, s) {
      return (
        null,
        BaseException.basicException(
          stackTrace: s,
          exception: e as Exception,
        ),
      );
    }
  }

  @override
  Future<(List<ReviewEntity>?, BaseException?)> getMyReviews(
    ReviewEntity? starterAfter,
    int? limit,
  ) async {
    try {
      return (await _datasource.getMyReviews(starterAfter, limit), null);
    } on firebase.FirebaseException catch (e, s) {
      return (
        null,
        BaseException.firebaseException(
          stackTrace: s,
          exception: e,
          message: e.message,
        ),
      );
    } catch (e, s) {
      return (
        null,
        BaseException.basicException(
          stackTrace: s,
          exception: e as Exception,
        ),
      );
    }
  }
}
