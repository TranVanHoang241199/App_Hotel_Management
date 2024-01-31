import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;

  const ErrorDialog({
    required this.errorMessage,
    this.onRetry,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error"),
      content: Text(errorMessage),
      actions: [
        if (onRetry != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onRetry!();
            },
            child: Text("Retry"),
          ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("OK"),
        ),
      ],
    );
  }
}
