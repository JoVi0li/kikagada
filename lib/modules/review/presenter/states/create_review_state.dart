import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

sealed class CreateReviewState {}

final class CreateReviewInitialState extends CreateReviewState {}

final class CreateReviewLoadingState extends CreateReviewState {}

final class CreateReviewSuccessState extends CreateReviewState {
  CreateReviewSuccessState({required this.review});
  final ReviewEntity review;
}

final class CreateBaseExceptionState extends CreateReviewState {
  CreateBaseExceptionState({required this.error});
  final BaseException error;
}

final class CreateReviewHasNoPhotosState extends CreateReviewState {}
