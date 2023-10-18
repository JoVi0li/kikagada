import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/presenter/components/review_card_component.dart';
import 'package:kikagada/modules/review/presenter/screens/review_details_screen.dart';

class MyReviewsListWidget extends StatelessWidget {
  const MyReviewsListWidget(this.reviews, {super.key});

  final List<ReviewEntity> reviews;

  void onTap(String id, BuildContext context) async {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (ctx) => ReviewDetailsScreen(reviewId: id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 32),
      itemCount: reviews.length,
      itemBuilder: (ctx, index) => ReviewCardComponent(
        review: reviews[index],
        onTap: onTap,
      ),
    );
  }
}
