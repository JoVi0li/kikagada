import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.onPressed,
  });
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: defaultTargetPlatform == TargetPlatform.android
          ? SvgPicture.asset('lib/shared/assets/icons/google.svg')
          : SvgPicture.asset('lib/shared/assets/icons/apple.svg'),
      iconSize: 24,
      padding: const EdgeInsets.all(23),
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
