import 'package:flutter/material.dart';

class FeedEmptyWidget extends StatelessWidget {
  const FeedEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Parece estar tudo vazio por aqui...',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
