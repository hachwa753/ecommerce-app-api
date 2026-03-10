import 'package:intl/intl.dart';

extension DateFormatting on String {
  String toReadableDate({String pattern = 'MMM d, yyyy'}) {
    try {
      final DateTime parsedDate = DateTime.parse(this);
      final DateFormat formatter = DateFormat(pattern);
      return formatter.format(parsedDate);
    } catch (e) {
      return this;
    }
  }
}

extension DateTimeFormatting on DateTime {
  String toReadableDate({String pattern = 'MMM d, yyyy'}) {
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(this);
  }
}
