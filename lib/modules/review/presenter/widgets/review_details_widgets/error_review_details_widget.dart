import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';

class ErrorReviewDetailsWidget extends StatelessWidget {
  const ErrorReviewDetailsWidget({super.key, required this.error});
  final ReviewError error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 36, color: Colors.white),
          const SizedBox(height: 12),
          Text(error.error, style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}
