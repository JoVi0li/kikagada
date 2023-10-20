import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingReviewsWidget extends StatelessWidget {
  const LoadingReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 32),
      itemCount: 5,
      itemBuilder: (ctx, index) {
        return Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.background,
          highlightColor: Theme.of(context).colorScheme.primary,
          child: Container(
            height: 80,
            width: MediaQuery.sizeOf(context).width,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        );
      },
    );
  }
}
