import 'package:flutter/material.dart';

class CreateReviewLoadingWidget extends StatelessWidget {
  const CreateReviewLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}