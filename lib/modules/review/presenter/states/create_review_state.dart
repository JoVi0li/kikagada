import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';

sealed class CreateReviewState {}

final class CreateReviewInitialState extends CreateReviewState {}

final class CreateReviewLoadingState extends CreateReviewState {}

final class CreateReviewSuccessState extends CreateReviewState {
  CreateReviewSuccessState({required this.review});
  final ReviewEntity review;
}

final class CreateReviewErrorState extends CreateReviewState {
  CreateReviewErrorState({required this.error});
  final ReviewError error;
}

final class CreateReviewHasNoPhotosState extends CreateReviewState {}
