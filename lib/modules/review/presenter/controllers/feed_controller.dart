import 'package:flutter/widgets.dart';
import 'package:kikagada/shared/routes/review_routes.dart';

abstract interface class IFeedController {
  Future<void> navigateToReviewDetails(BuildContext context, String reviewId);
  Future<void> navigateToCreateReview(BuildContext context);
}

class FeedController implements IFeedController {
  @override
  Future<void> navigateToReviewDetails(
    BuildContext context,
    String reviewId,
  ) async {
    return await Navigator.pushNamed<void>(
      context,
      ReviewRoutes.details,
      arguments: reviewId,
    );
  }

  @override
  Future<void> navigateToCreateReview(BuildContext context) async {
    return Navigator.pushNamed<void>(context, ReviewRoutes.create);
  }
}
