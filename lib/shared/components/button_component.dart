import 'package:flutter/material.dart';

enum ButtonComponentType { normal, create, delete }

class ButtonComponent extends StatelessWidget {
  const ButtonComponent({
    super.key,
    required this.onPressed,
    required this.label,
    this.type = ButtonComponentType.normal,
  });

  final Function() onPressed;
  final String label;
  final ButtonComponentType type;

  Color getShadowColor() {
    switch (type) {
      case ButtonComponentType.normal:
        return const Color(0xFFD9B88F);
      case ButtonComponentType.create:
        return const Color(0xFF8FD99F);
      case ButtonComponentType.delete:
        return const Color(0xFFD9A28F);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(3.0, 2.5),
            color: getShadowColor(),
            spreadRadius: 2.5,
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: Theme.of(context).textButtonTheme.style,
        child: Text(label, style: Theme.of(context).textTheme.labelMedium),
      ),
    );
  }
}
