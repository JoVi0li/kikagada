import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';
import 'package:kikagada/modules/review/presenter/widgets/home_widgets/home_error_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/home_widgets/loading_reviews_widgets.dart';
import 'package:kikagada/modules/review/presenter/widgets/home_widgets/reviews_list_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/home_widgets/reviews_not_found_widget.dart';

sealed class HomeWidget {
  static Widget listReviews(List<ReviewEntity> reviews) {
    return ReviewsListWidget(reviews);
  }

  static Widget notFound() {
    return const ReviewsNotFoundWidget();
  }

  static Widget loading() {
    return const LoadingReviewsWidget();
  }

  static Widget error(BaseException error) {
    return HomeErrorWidget(
      error,
      tryAgain: () => {},
    );
  }
}
