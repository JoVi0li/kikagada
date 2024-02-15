import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/presenter/widgets/my_reviews_widgets/loading_my_reviews_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/my_reviews_widgets/my_reviews_error_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/my_reviews_widgets/my_reviews_list_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/my_reviews_widgets/without_reviews_widget.dart';

sealed class MyReviewsWidget {
  static Widget loading() {
    return const LoadingMyReviewsWidget();
  }

  static Widget error(ReviewError error, void Function() tryAgain) {
    return MyReviewsErrorWidget(error, tryAgain: tryAgain);
  }

  static Widget listReviews(List<ReviewEntity> reviews) {
    return MyReviewsListWidget(reviews);
  }

  static Widget noData() {
    return const WithoutReviewsWidget();
  }
}
