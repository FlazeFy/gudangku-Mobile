import 'dart:convert';

import 'package:gudangku/modules/api/report/model/queries.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class ReportQueriesService {
  final String emuUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<ReportModel>> getAllReport(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client
        .get(Uri.parse("$emuUrl/api/v1/report?page=$page"), headers: header);
    if (response.statusCode == 200) {
      return reportModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      return [];
    } else {
      return [];
    }
  }

  Future<List<ReportModel>?> getReportByInventoryId(
      String inventoryName, String id, int page) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.get(
        Uri.parse("$emuUrl/api/v1/report/$inventoryName/$id?page=$page"),
        headers: header);
    if (response.statusCode == 200) {
      return reportModelFromJson(response.body);
    } else if (response.statusCode == 404) {
      return [];
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getDetailReport(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.get(
        Uri.parse("$emuUrl/api/v1/report/detail/item/$id"),
        headers: header);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      ReportDetailModel detail = ReportDetailModel.fromJson(jsonData['data']);
      List<InventoryReportModel> items =
          inventoryModelFromJson(jsonData['data_item']);

      return {
        'detail': detail,
        'items': items,
      };
    } else {
      return null;
    }
  }
}
