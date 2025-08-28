import 'package:intl/intl.dart';

String generateTempDataKey() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
  return formattedDate;
}

String generateMonthName(int idx) {
  List month = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  return month[idx - 1];
}

String getDeviceTimeZoneOffset() {
  final offset = DateTime.now().timeZoneOffset;
  final hours = offset.inHours.abs().toString().padLeft(2, '0');
  final minutes = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
  final sign = offset.isNegative ? '-' : '+';
  return '$sign$hours:$minutes';
}
