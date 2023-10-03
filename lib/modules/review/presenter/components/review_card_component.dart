import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';

class ReviewCardComponent extends StatelessWidget {
  const ReviewCardComponent({super.key, required this.review});
  final ReviewEntity review;

  String hoursSinceCreated(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inSeconds < 60) {
      return 'Há ${difference.inSeconds} segs';
    }

    if (difference.inMinutes < 60) {
      return 'Há ${difference.inMinutes} mins';
    }

    if (difference.inHours < 24) {
      return 'Há ${difference.inHours} hrs';
    }

    return 'Há ${difference.inDays} dias';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(review.title),
      titleTextStyle: Theme.of(context).textTheme.labelLarge,
      subtitle: Text(hoursSinceCreated(review.createdAt)),
      subtitleTextStyle: Theme.of(context)
          .textTheme
          .labelMedium
          ?.copyWith(color: Colors.white30),
    );
  }
}
