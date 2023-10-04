import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget {
  const AppBarComponent({
    super.key,
    required this.title,
    this.hasBackButton = false,
  });

  final String title;
  final bool hasBackButton;


  void pop(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      leading: hasBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => pop(context),
            )
          : null,
    );
  }
}
