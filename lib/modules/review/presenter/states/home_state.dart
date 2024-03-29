import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

sealed class HomeState {}

final class HomeEmptyState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeSuccessState extends HomeState {
  HomeSuccessState({required this.reviews});
  final List<ReviewEntity> reviews;
}

final class HomeErrorState extends HomeState {
  HomeErrorState({required this.error});
  final BaseException error;
}
