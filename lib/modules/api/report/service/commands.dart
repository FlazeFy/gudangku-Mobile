import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:gudangku/modules/api/report/model/commands.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class ReportCommandsService {
  final String emuUrl = "http://10.0.2.2:8000";

  Client client = Client();

  Future<List<Map<String, dynamic>>> deleteReportInventoryByItemId(
      String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': "Bearer $token",
    };
    final response = await client.delete(
      Uri.parse("$emuUrl/api/v1/report/delete/item/$id"),
      headers: header,
    );

    var responseData = jsonDecode(response.body);
    if ([200, 404, 401, 500].contains(response.statusCode)) {
      return [
        {
          "status": responseData["status"],
          "message": responseData["message"],
        }
      ];
    } else {
      return [
        {"status": "failed", "message": "something wrong. please contact admin"}
      ];
    }
  }

  Future<List<Map<String, dynamic>>> deleteReportById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': "Bearer $token",
    };
    final response = await client.delete(
      Uri.parse("$emuUrl/api/v1/report/delete/report/$id"),
      headers: header,
    );

    var responseData = jsonDecode(response.body);
    if ([200, 404, 401, 500].contains(response.statusCode)) {
      return [
        {
          "status": responseData["status"],
          "message": responseData["message"],
        }
      ];
    } else {
      return [
        {"status": "failed", "message": "something wrong. please contact admin"}
      ];
    }
  }

  Future<List<Map<String, dynamic>>> putReportById(
      PutReportDetailModel data, String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': "Bearer $token",
    };
    final response = await client.put(
      Uri.parse("$emuUrl/api/v1/report/update/report/$id"),
      headers: header,
      body: reportDetailModelToJson(data),
    );

    var responseData = jsonDecode(response.body);
    if ([200, 404, 401, 422, 500].contains(response.statusCode)) {
      return [
        {
          "status": responseData["status"],
          "message": responseData["message"],
        }
      ];
    } else {
      return [
        {"status": "failed", "message": "something wrong. please contact admin"}
      ];
    }
  }
}
