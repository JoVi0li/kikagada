import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';

class FeedErrorWidget extends StatelessWidget {
  const FeedErrorWidget({super.key, required this.error});
  final ReviewError error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 36, color: Colors.white),
          const SizedBox(height: 12),
          Text(error.error, style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}
