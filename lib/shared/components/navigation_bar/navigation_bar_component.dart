import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/review/presenter/screens/create_review_screen.dart';
import 'package:kikagada/modules/review/presenter/screens/home_screen.dart';
import 'package:kikagada/modules/review/presenter/screens/profile_screen.dart';
import 'package:kikagada/modules/review/presenter/screens/reviews_screen.dart';
import 'package:kikagada/shared/components/navigation_bar/navigation_bar_controller.dart';

class NavigationBarComponent extends StatefulWidget {
  const NavigationBarComponent({super.key, required});

  @override
  State<NavigationBarComponent> createState() => _NavigationBarComponentState();
}

class _NavigationBarComponentState extends State<NavigationBarComponent> {
  late final GetIt _getIt;
  late final NavigationBarController _controller;

  @override
  void initState() {
    super.initState();
    _getIt = GetIt.I;
    _controller = _getIt<NavigationBarController>();
  }

  @override
  void dispose() {
    _getIt.resetLazySingleton<NavigationBarController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (ctx, state, child) {
        return Scaffold(
          body: const [
            HomeScreen(),
            ReviewsScreen(),
            CreateReviewScreen(),
            ProfileScreen(),
          ][state],
          bottomNavigationBar: NavigationBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 0,
            height: 80,
            destinations: [
              IconButton(
                onPressed: () => _controller.navigateTo(ScreenOptionsEnum.home),
                icon: SvgPicture.asset('lib/shared/assets/icons/house.svg'),
                selectedIcon: SvgPicture.asset(
                    'lib/shared/assets/icons/house_selected.svg'),
                isSelected: state == ScreenOptionsEnum.home.index,
              ),
              IconButton(
                onPressed: () =>
                    _controller.navigateTo(ScreenOptionsEnum.reviews),
                icon: SvgPicture.asset('lib/shared/assets/icons/archive.svg'),
                selectedIcon: SvgPicture.asset(
                    'lib/shared/assets/icons/archive_selected.svg'),
                isSelected: state == ScreenOptionsEnum.reviews.index,
              ),
              IconButton(
                onPressed: () =>
                    _controller.navigateTo(ScreenOptionsEnum.create),
                icon:
                    SvgPicture.asset('lib/shared/assets/icons/pluscircle.svg'),
                selectedIcon: SvgPicture.asset(
                    'lib/shared/assets/icons/pluscircle_selected.svg'),
                isSelected: state == ScreenOptionsEnum.create.index,
              ),
              IconButton(
                onPressed: () =>
                    _controller.navigateTo(ScreenOptionsEnum.profile),
                icon: SvgPicture.asset('lib/shared/assets/icons/user.svg'),
                selectedIcon: SvgPicture.asset(
                    'lib/shared/assets/icons/user_selected.svg'),
                isSelected: state == ScreenOptionsEnum.profile.index,
              ),
            ],
          ),
        );
      },
    );
  }
}
