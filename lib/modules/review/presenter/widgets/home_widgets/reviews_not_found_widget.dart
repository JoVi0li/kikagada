import 'package:flutter/material.dart';

class ReviewsNotFoundWidget extends StatelessWidget {
  const ReviewsNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Ops! Parece que não temos\nreviews para mostrar...',
        style: Theme.of(context).textTheme.labelLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
