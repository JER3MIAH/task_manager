import 'package:flutter/material.dart';
import 'package:task_manager/src/shared/widgets/widgets.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double fontSize;
  final double bHeight;
  final bool expanded;
  final Color? color;
  final Color? hoverColor;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.title,
    this.onTap,
    this.fontSize = 13,
    this.bHeight = 40,
    this.expanded = false,
    this.color,
    this.hoverColor,
    this.textColor,
  });

  const AppButton.large({
    super.key,
    required this.title,
    this.onTap,
    this.color,
    this.hoverColor,
    this.textColor,
  })  : expanded = false,
        fontSize = 15,
        bHeight = 48;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BounceInAnimation(
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color ?? theme.primary),
          elevation: WidgetStatePropertyAll(0),
          overlayColor: WidgetStatePropertyAll(
            hoverColor ?? theme.primaryContainer,
          ),
          minimumSize: WidgetStatePropertyAll(
            expanded ? Size(double.infinity, bHeight) : null,
          ),
          fixedSize: WidgetStatePropertyAll(Size.fromHeight(bHeight)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
        child: AppText(
          title,
          fontSize: fontSize,
          color: textColor ?? theme.onPrimary,
        ),
      ),
    );
  }
}
