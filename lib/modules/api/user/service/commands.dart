import 'dart:convert';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/user/model/commands.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class UserCommandsService {
  final String baseUrl = "https://gudangku.leonardhors.com";
  final String emuUrl = "http://10.0.2.2:8000";

  Client client = Client();

  Future putFirebase(TimezoneFCMModel data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');

    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.put(
        Uri.parse("$emuUrl/api/v1/user/update_timezone_fcm"),
        headers: header,
        body: timezoneFCMModelToJson(data));

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return [
        {
          "status": "success",
          "message": responseData["message"],
        }
      ];
    } else if (response.statusCode == 422 || response.statusCode == 401) {
      return [
        {"status": "failed", "message": responseData['message']}
      ];
    } else {
      return [
        {
          "status": "failed",
          "message": "Unknown error, please contact the admin".tr
        }
      ];
    }
  }

  Future putUpdateProfile(UpdateProfileModel data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');

    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.put(
        Uri.parse("$emuUrl/api/v1/user/update_profile"),
        headers: header,
        body: updateProfileModelToJson(data));

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return [
        {
          "status": "success",
          "message": responseData["message"],
        }
      ];
    } else if (response.statusCode == 422 || response.statusCode == 401) {
      return [
        {"status": "failed", "message": responseData['message']}
      ];
    } else {
      return [
        {
          "status": "failed",
          "message": "Unknown error, please contact the admin".tr
        }
      ];
    }
  }

  Future generateQRCode() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');

    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': "Bearer $token",
    };

    final responsePost = await client.post(Uri.parse("$emuUrl/api/v1/lend/qr"),
        headers: header, body: json.encode({'qr_period': 6}));

    var responsePostData = jsonDecode(responsePost.body);

    if (responsePost.statusCode == 201) {
      final responseGet = await client.get(Uri.parse("$emuUrl/api/v1/lend/qr"),
          headers: header);
      var responseGetData = jsonDecode(responseGet.body);

      if (responseGet.statusCode == 200) {
        return [
          {
            "status": "success",
            "data": responseGetData["data"],
          }
        ];
      } else {
        return [
          {
            "status": "failed",
            "message": responseGetData["message"],
          }
        ];
      }
    } else if (responsePost.statusCode == 422 ||
        responsePost.statusCode == 401) {
      return [
        {"status": "failed", "message": responsePostData['message']}
      ];
    } else {
      return [
        {
          "status": "failed",
          "message": "Unknown error, please contact the admin".tr
        }
      ];
    }
  }
}
