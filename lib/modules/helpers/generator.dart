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
