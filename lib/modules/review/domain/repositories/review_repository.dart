import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

abstract interface class IReviewRepository {
  Future<(ReviewEntity? success, BaseException? error)> create(
    ReviewEntity review,
  );
  Future<(ReviewEntity? success, BaseException? error)> update(
    ReviewEntity review,
  );
  Future<(ReviewEntity? success, BaseException? error)> getById(String id);
  Future<(ReviewEntity? success, BaseException? error)> delete(String id);
  Future<(List<ReviewEntity>? success, BaseException? error)> getReviews(
    ReviewEntity? starterAfter,
    int? limit,
  );
  Future<(List<String>? success, BaseException? error)> uploadPhotos(
    List<String> photosPath,
  );
  Future<(List<String>? success, BaseException? error)> getPhotosDownloadURL(
    List<String> photosPath,
  );
  Future<(List<ReviewEntity>? success, BaseException? failure)> getMyReviews(
    ReviewEntity? starterAfter,
    int? limit,
  );
}
