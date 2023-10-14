import 'package:flutter/material.dart';
import 'package:kikagada/shared/components/button_component.dart';

class DialogComponent extends StatelessWidget {
  const DialogComponent({
    super.key,
    required this.title,
    required this.content,
    this.actions,
  });

  final String title;
  final String content;
  final List<Widget>? actions;

  final padding = const EdgeInsets.only(
    left: 16,
    top: 16,
    bottom: 24,
    right: 16,
  );

  void closeDialog(BuildContext context) {
    return Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (actions != null && actions!.isNotEmpty) {
      return SimpleDialog(
        title: Text(title),
        titlePadding: padding,
        contentPadding: padding,
        children: [
          Text(content),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: actions!,
          ),
        ],
      );
    }
    return SimpleDialog(
      title: Text(title),
      titlePadding: padding,
      contentPadding: padding,
      children: [
        Text(content),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonComponent(onPressed: () => closeDialog(context), label: 'Ok'),
          ],
        ),
      ],
    );
  }
}
