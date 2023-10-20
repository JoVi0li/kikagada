import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';

class ReviewCardComponent extends StatelessWidget {
  const ReviewCardComponent(
      {super.key, required this.review, required this.onTap});
  final ReviewEntity review;
  final Function(String id, BuildContext context) onTap;

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
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(),
        boxShadow: [
          BoxShadow(
            offset: const Offset(3.0, 2.5),
            color: Theme.of(context).colorScheme.primary,
            spreadRadius: 2.5,
          ),
        ],
      ),
      child: ListTile(
        onTap: () => onTap(review.id, context),
        title: Text(review.title),
        titleTextStyle: Theme.of(context).textTheme.labelLarge,
        subtitle: Text(hoursSinceCreated(review.createdAt)),
        subtitleTextStyle: Theme.of(context).textTheme.labelMedium,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
