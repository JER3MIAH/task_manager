import 'package:intl/intl.dart';

// Customizable Date Formatter
String formatDate(DateTime dateTime, {String format = 'h:mm a, dd MMM yyyy'}) {
  return DateFormat(format).format(dateTime);
}

