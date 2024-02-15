import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

sealed class MyReviewsState {}

final class MyReviewsLoadingState extends MyReviewsState {}

final class MyReviewsWithoutDataState extends MyReviewsState {}

final class MyReviewsSuccessState extends MyReviewsState {
  MyReviewsSuccessState({required this.reviews});
  final List<ReviewEntity> reviews;
}

final class MyReviewsErrorState extends MyReviewsState {
  MyReviewsErrorState({required this.error});
  final BaseException error;
}
