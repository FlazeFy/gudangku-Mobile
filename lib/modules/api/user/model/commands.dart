import 'dart:convert';

class TimezoneFCMModel {
  String firebaseFCMToken;
  String timezone;

  TimezoneFCMModel({required this.firebaseFCMToken, required this.timezone});

  Map<dynamic, dynamic> toJson() {
    return {
      "firebase_fcm_token": firebaseFCMToken,
      "timezone": timezone,
    };
  }
}

String timezoneFCMModelToJson(TimezoneFCMModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
