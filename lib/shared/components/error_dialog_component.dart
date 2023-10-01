import 'package:flutter/material.dart';

class ErrorDialogComponent extends StatelessWidget {
  const ErrorDialogComponent({super.key, required this.errorMessage});
  final String errorMessage;

  void closeDialog(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.error),
      title: const Text("Algo deu errado"),
      content: SingleChildScrollView(
        child: Text(
          errorMessage,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => closeDialog(context),
          child: Text(
            "Ok",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
