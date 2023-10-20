import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kikagada/shared/components/navigation_bar/navigation_bar_component.dart';
import 'package:kikagada/shared/components/navigation_bar/navigation_bar_controller.dart';

class WithoutReviewsWidget extends StatelessWidget {
  const WithoutReviewsWidget({super.key});

  void onPressed(BuildContext context) async {
    return await Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute(
          builder: (ctx) => NavigationBarComponent(
            screenIndex: ScreenOptionsEnum.create.index,
          ),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Quando criar uma review\nela aparecerá aqui',
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          IconButton(
              onPressed: () => onPressed(context),
              icon: SvgPicture.asset('lib/shared/assets/icons/pluscircle.svg'))
        ],
      ),
    );
  }
}
