import 'package:flutter/material.dart';

class SnackBars {
  static void showError({
    required BuildContext context,
    String? message,
    bool removePrevious = true,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final theme = Theme.of(context);

    if (removePrevious) scaffoldMessenger.removeCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        backgroundColor: theme.colorScheme.error,
        content: Text(
          message ?? 'An error ocurred, please try again.',
          style: TextStyle(color: theme.colorScheme.onError),
        ),
      ),
    );
  }
}
