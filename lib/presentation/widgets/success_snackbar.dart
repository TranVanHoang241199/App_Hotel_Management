import 'package:flutter/material.dart';

class SuccessSnackbar extends StatelessWidget {
  final String message;
  const SuccessSnackbar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    );
  }
}
