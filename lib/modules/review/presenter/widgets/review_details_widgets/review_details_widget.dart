import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/presenter/widgets/review_details_widgets/error_review_details_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/review_details_widgets/review_details_loading_widget.dart';
import 'package:kikagada/modules/review/presenter/widgets/review_details_widgets/success_review_details_widget.dart';

sealed class ReviewDetailsWidget {
  static Widget loading() {
    return const ReviewDetailsLoadingWidget();
  }

  static Widget error(ReviewError error) {
    return ErrorReviewDetailsWidget(error: error);
  }

  static Widget success(ReviewEntity review) {
    return SuccessReviewDetailsWidget(review: review);
  }
}
