import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';

abstract interface class IReviewRepository {
  Future<(ReviewEntity? success, ReviewError? error)> create(
    ReviewEntity review,
  );
  Future<(ReviewEntity? success, ReviewError? error)> update(
    ReviewEntity review,
  );
  Future<(ReviewEntity? success, ReviewError? error)> getById(String id);
  Future<(ReviewEntity? success, ReviewError? error)> delete(String id);
  Future<(List<ReviewEntity>? success, ReviewError? error)> getReviews(
    ReviewEntity? starterAfter,
    int? limit,
  );
  Future<(List<String>? success, ReviewError? error)> uploadPhotos(
    List<String> photosPath,
  );
  Future<(List<String>? success, ReviewError? error)> getPhotosDownloadURL(
    List<String> photosPath,
  );
}
