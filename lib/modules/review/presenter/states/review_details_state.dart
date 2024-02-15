import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

sealed class ReviewDetailsState {}

class ReviewDetailsLoadingState extends ReviewDetailsState {}

class ReviewDetailsSuccessState extends ReviewDetailsState {
  ReviewDetailsSuccessState({required this.review});
  final ReviewEntity review;
}

class ReviewDetailsErrorState extends ReviewDetailsState {
  ReviewDetailsErrorState({required this.error});
  final BaseException error;
}
