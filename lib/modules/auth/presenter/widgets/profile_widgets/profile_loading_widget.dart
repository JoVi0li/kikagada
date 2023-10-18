import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class ProfileLoadingWidget extends StatelessWidget {
  const ProfileLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: Shimmer.fromColors(
                baseColor: Theme.of(context).colorScheme.background,
                highlightColor: Theme.of(context).colorScheme.primary,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: SvgPicture.asset(
                    'lib/shared/assets/icons/user.svg',
                    height: 70,
                    width: 70,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.background,
              highlightColor: Theme.of(context).colorScheme.primary,
              child: Text(
                'Jonh Doe',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.background,
              highlightColor: Theme.of(context).colorScheme.primary,
              child: Text(
                'jonh_doe@email.com',
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
