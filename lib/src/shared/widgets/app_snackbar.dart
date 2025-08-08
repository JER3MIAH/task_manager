import 'dart:io';
import 'package:flutter/material.dart';

class AppSnackbar {
  static void show(
    BuildContext context, {
    required String title,
    Duration duration = const Duration(seconds: 4),
  }) {
    final theme = Theme.of(context).colorScheme;
    final isMobile = Platform.isAndroid|| Platform.isIOS;

    final snackBar = SnackBar(
      width: isMobile ? null : 440,
      backgroundColor: theme.secondaryContainer,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(8),
      margin: isMobile ? const EdgeInsets.symmetric(horizontal: 10) : null,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
      duration: duration,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar() // Ensures only one snack bar is shown at a time
      ..showSnackBar(snackBar);
  }
}

