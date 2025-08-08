import 'package:flutter/material.dart';
import 'package:task_manager/src/features/navigation/app_navigator.dart';

class DateSelectionContainer extends StatelessWidget {
  final ValueNotifier<DateTime?> selectedDate;
  final VoidCallback? onSelected;
  const DateSelectionContainer({
    super.key,
    required this.selectedDate,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: theme.primary),
              textTheme: const TextTheme().apply(fontSizeDelta: 16.14),
              datePickerTheme: DatePickerThemeData(
                dayShape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.46),
                  ),
                ),
                headerBackgroundColor: theme.primary,
                dayOverlayColor: WidgetStatePropertyAll(theme.primary),
                dayStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16.14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            child: CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100, 12, 31),
              onDateChanged: (value) {
                selectedDate.value = value;
                AppNavigator(context).popRoute();
                if (onSelected != null) onSelected!();
              },
            ),
          ),
        ],
      ),
    );
  }
}
