import 'package:flutter/material.dart';

class AppDialog {
  static void dialog(
    BuildContext context,
    Widget content, {
    Color? bgColor,
    bool dismissible = true,
  }) {
    final theme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: theme.inversePrimary),
                borderRadius: BorderRadius.circular(12),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              backgroundColor: bgColor ?? Colors.white,
              shadowColor: bgColor ?? Colors.white,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: content,
              ),
            );
          },
        );
      },
    );
  }
}

