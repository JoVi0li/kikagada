import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';

class ReviewCardComponent extends StatelessWidget {
  const ReviewCardComponent({super.key, required this.review});
  final ReviewEntity review;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(review.title),
      titleTextStyle: Theme.of(context).textTheme.labelLarge,
      subtitle: Text(review.createdAt.toUtc().toIso8601String()),
      subtitleTextStyle: Theme.of(context).textTheme.labelMedium,
    );
  }
}
