import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:gudangku/modules/api/inventory/model/commands.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class InventoryCommandsService {
  final String emuUrl = "http://10.0.2.2:8000";

  Client client = Client();

  Future<List<Map<String, dynamic>>> softDeleteInventoryById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');

    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.delete(
      Uri.parse("$emuUrl/api/v1/inventory/delete/$id"),
      headers: header,
    );

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return [
        {
          "message": "success",
          "body": responseData["message"],
        }
      ];
    } else {
      return [
        {"message": "failed", "body": responseData['message']}
      ];
    }
  }

  Future<List<Map<String, dynamic>>> hardDeleteInventoryById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');

    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.delete(
      Uri.parse("$emuUrl/api/v1/inventory/destroy/$id"),
      headers: header,
    );

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return [
        {
          "message": "success",
          "body": responseData["message"],
        }
      ];
    } else {
      return [
        {"message": "failed", "body": responseData['message']}
      ];
    }
  }

  Future<List<Map<String, dynamic>>> toogleFavInventoryById(
      String id, FavoriteToogleModel data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');

    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.put(
      Uri.parse("$emuUrl/api/v1/inventory/fav_toggle/$id"),
      headers: header,
      body: favoriteToogleToJson(data),
    );

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return [
        {
          "message": "success",
          "body": responseData["message"],
        }
      ];
    } else {
      return [
        {"message": "failed", "body": responseData['message']}
      ];
    }
  }

  Future<List<Map<String, dynamic>>> putRecoverInventoryById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');

    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.put(
        Uri.parse("$emuUrl/api/v1/inventory/recover/$id"),
        headers: header);

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return [
        {
          "message": "success",
          "body": responseData["message"],
        }
      ];
    } else {
      return [
        {"message": "failed", "body": responseData['message']}
      ];
    }
  }

  Future<List<Map<String, dynamic>>> postInventory(InventoryModel data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');

    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.post(
      Uri.parse("$emuUrl/api/v1/inventory"),
      headers: header,
      body: inventoryModelToJson(data),
    );

    var responseData = jsonDecode(response.body);

    if ([201, 401, 409, 422, 500].contains(response.statusCode)) {
      return [
        {
          "status": responseData["status"],
          "message": responseData["message"],
        }
      ];
    } else {
      return [
        {"status": "failed", "body": "something wrong. please contact admin"}
      ];
    }
  }
}
