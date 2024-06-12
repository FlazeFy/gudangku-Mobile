import 'package:flutter_local_notifications/flutter_local_notifications.dart';

int selectedIndex = 0;

class PieData {
  PieData(this.xData, this.yData, [this.text = ""]);
  final String xData;
  final num yData;
  final String text;
}

// Firebase
String? token;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);
