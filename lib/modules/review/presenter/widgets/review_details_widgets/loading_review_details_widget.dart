import 'package:flutter/material.dart';

class LoadingReviewDetailsWidget extends StatelessWidget {
  const LoadingReviewDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
