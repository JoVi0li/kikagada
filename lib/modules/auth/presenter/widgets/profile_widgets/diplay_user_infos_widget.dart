import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/shared/components/button_component.dart';

class DisplayUserInfosWidget extends StatelessWidget {
  const DisplayUserInfosWidget(
    this.user, {
    super.key,
    required this.onDeleteAccount,
  });

  final UserEntity user;
  final void Function(UserEntity) onDeleteAccount;

  Widget frameBuilder(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    if (wasSynchronouslyLoaded) {
      return child;
    }
    return AnimatedOpacity(
      opacity: frame == null ? 0 : 1,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
      child: child,
    );
  }

  Widget errorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return SizedBox(
      width: getSize(context).width,
      height: getSize(context).height * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.white, size: 36),
          const SizedBox(height: 24),
          Text(
            'Não foi possivel carregar a imagem',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  Size getSize(BuildContext context) {
    return MediaQuery.sizeOf(context);
  }

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
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: (user.photo != null && user.photo!.isNotEmpty)
                    ? Image.network(
                        user.photo!,
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.low,
                        cacheWidth: getSize(context).width.toInt(),
                        cacheHeight: (getSize(context).height * 0.25).toInt(),
                        frameBuilder: frameBuilder,
                        errorBuilder: errorBuilder,
                      )
                    : SvgPicture.asset(
                        'lib/shared/assets/icons/user.svg',
                        height: 70,
                        width: 70,
                      ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              user.name,
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              user.email,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
