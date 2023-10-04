import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';

abstract class ReviewDetailsState {}

class LoadingReviewDetailsState extends ReviewDetailsState {}

class SuccessReviewDetailsState extends ReviewDetailsState {
  SuccessReviewDetailsState({required this.review});
  final ReviewEntity review;
}

class ErrorReviewDetailsState extends ReviewDetailsState {
  ErrorReviewDetailsState({required this.error});
  final ReviewError error;
}
