import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ReviewDetailsLoadingWidget extends StatelessWidget {
  const ReviewDetailsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.background,
              highlightColor: Theme.of(context).colorScheme.primary,
              child: Container(
                height: MediaQuery.sizeOf(context).width - 150,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.background,
              highlightColor: Theme.of(context).colorScheme.primary,
              child: Container(
                height: MediaQuery.sizeOf(context).height / 2,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
