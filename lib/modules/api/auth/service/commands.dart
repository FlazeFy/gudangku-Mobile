import 'dart:convert';

import 'package:gudangku/modules/api/auth/model/commands.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class LoginCommandsService {
  final String baseUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<Map<String, dynamic>>> postLogin(LoginModel data) async {
    final response = await client.post(
      Uri.parse("$baseUrl/api/v1/login"),
      headers: {"content-type": "application/json"},
      body: loginModelToJson(data),
    );

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token_key', responseData['token']);
      await prefs.setString('username_key', responseData['result']['username']);
      await prefs.setString('email_key', responseData['result']['email']);
      await prefs.setString('role_key', responseData['role'].toString());

      return [
        {
          "message": "success",
          "body": responseData['result'],
          "token": responseData['token']
        }
      ];
    } else if (response.statusCode == 422) {
      // Validation failed
      return [
        {"message": "failed", "body": responseData['result'], "token": null}
      ];
    } else if (response.statusCode == 401) {
      // Wrong username or password
      return [
        {"message": "failed", "body": responseData['message'], "token": null}
      ];
    } else {
      return [
        {"message": "failed", "body": "Unknown error", "token": null}
      ];
    }
  }
}
