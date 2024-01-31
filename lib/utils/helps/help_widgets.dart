import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/presentation/widgets/error_dialog_widget.dart';

class HelpWidgets {
  static void showErrorDialog(BuildContext context, String errorMessage,
      {VoidCallback? onRetry}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorDialog(
          errorMessage: errorMessage,
          onRetry: onRetry,
        );
      },
    );
  }
}
