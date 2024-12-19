import 'dart:convert';

import 'package:gudangku/modules/api/inventory/model/commands.dart';
import 'package:gudangku/modules/api/inventory/model/queries.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class InventoryQueriesService {
  final String emuUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<InventoryAllModel>> getAllInventory(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client
        .get(Uri.parse("$emuUrl/api/v1/inventory?page=$page"), headers: header);
    if (response.statusCode == 200) {
      return inventoryAllModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      return [];
    } else {
      return [];
    }
  }

  Future<Map<String, dynamic>?> getDetailInventory(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client
        .get(Uri.parse("$emuUrl/api/v1/inventory/detail/$id"), headers: header);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      InventoryModel detail = InventoryModel.fromJson(jsonData['data']);
      List<ReminderModel>? reminder = jsonData['reminder'] != null
          ? reminderInventoryModelFromJson(jsonData['reminder'])
          : null;

      return {
        'detail': detail,
        'reminder': reminder,
      };
    } else {
      return null;
    }
  }

  Future<String> getDetailDoc(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.get(
        Uri.parse("$emuUrl/api/v1/inventory/detail/$id/doc"),
        headers: header);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['data'];
    } else if (response.statusCode == 401) {
      return "";
    } else {
      return "";
    }
  }

  Future<List<InventoryCalendarModel>> getInventoryCalendar() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client
        .get(Uri.parse("$emuUrl/api/v1/inventory/calendar"), headers: header);
    if (response.statusCode == 200) {
      return inventoryCalendarModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      return [];
    } else {
      return [];
    }
  }
}
