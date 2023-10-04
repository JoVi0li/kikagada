import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';

abstract base class FeedState {}

final class FeedEmptyState extends FeedState {}

final class FeedLoadingState extends FeedState {}

final class FeedSuccessState extends FeedState {
  FeedSuccessState({required this.value});
  final List<ReviewEntity> value;
}

final class FeedErrorState extends FeedState {
  FeedErrorState({required this.error});
  final ReviewError error;
}
