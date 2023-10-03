import 'package:flutter/widgets.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/presenter/components/review_card_component.dart';

class FeedSuccessWidget extends StatelessWidget {
  const FeedSuccessWidget({super.key, required this.reviews, required this.onClick,});
  final List<ReviewEntity> reviews;
  final Function(String reviewId) onClick;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: () => onClick(reviews[index].id),
          child: ReviewCardComponent(review: reviews[index]),
        );
      },
    );
  }
}
