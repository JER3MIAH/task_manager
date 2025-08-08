import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:task_manager/src/shared/widgets/widgets.dart';

class AppTextField extends HookWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool multiLine;
  final VoidCallback? onTapClear;
  final String? Function(String?)? validator;
  const AppTextField({
    super.key,
    required this.controller,
    this.labelText = '',
    required this.hintText,
    this.multiLine = false,
    this.onTapClear,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final tStyle = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: theme.onSurface,
    );
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: theme.inversePrimary.withValues(alpha: .25),
      ),
      borderRadius: BorderRadius.circular(4),
    );

    final validationFailed = useState<bool>(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText.isNotEmpty) ...[
          AppText(labelText, fontSize: 12, color: theme.onSurface),
          YBox(7),
        ],
        Stack(
          children: [
            TextFormField(
              controller: controller,
              cursorColor: theme.primary,
              style: tStyle,
              keyboardType: multiLine
                  ? TextInputType.multiline
                  : TextInputType.text,
              maxLines: multiLine ? 8 : null,
              validator:
                  validator ??
                  (value) {
                    if (value == null || value.trim().isEmpty) {
                      validationFailed.value = true;
                      return '';
                    }
                    validationFailed.value = false;
                    return null;
                  },
              decoration: InputDecoration(
                errorStyle: const TextStyle(height: .0001),
                hintText: hintText,
                hintStyle: tStyle.copyWith(
                  color: theme.onSurface.withValues(alpha: .25),
                ),
                contentPadding: multiLine
                    ? null
                    : const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                constraints: BoxConstraints(
                  minHeight: multiLine ? 112 : 40,
                  maxHeight: multiLine ? 112 : 40,
                ),
                focusedBorder: border,
                enabledBorder: border,
                disabledBorder: border,
                focusedErrorBorder: border.copyWith(
                  borderSide: BorderSide(color: theme.error),
                ),
                errorBorder: border.copyWith(
                  borderSide: BorderSide(color: theme.error),
                ),
              ),
            ),
            if (validationFailed.value)
              Positioned(
                bottom: 5,
                right: 5,
                child: AppText(
                  'Can’t be empty',
                  fontSize: 13,
                  color: theme.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
