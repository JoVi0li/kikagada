import 'package:kikagada/modules/review/domain/entities/review_entity.dart';

abstract interface class IReviewDatasource {
  Future<ReviewEntity> create(ReviewEntity review);
  Future<ReviewEntity> update(ReviewEntity review);
  Future<ReviewEntity> getById(String id);
  Future<ReviewEntity> delete(String id);
}
