import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:gudangku/modules/api/inventory/model/commands.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

  Future<List<Map<String, dynamic>>> postInventory(InventoryModel data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');

    final uri = Uri.parse("$emuUrl/api/v1/inventory");
    final request = http.MultipartRequest('POST', uri)
      ..headers.addAll({
        'Accept': 'application/json',
        'content-type': 'multipart/form-data',
        'Authorization': "Bearer $token",
      });

    final Map<String, dynamic> dataFields =
        jsonDecode(inventoryModelToJson(data));

    dataFields.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });
    if (capturedImage != null) {
      request.files
          .add(await http.MultipartFile.fromPath('file', capturedImage!.path));
    }

    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    final responseJson = jsonDecode(responseData);
    if ([201, 401, 409, 422, 500].contains(response.statusCode)) {
      return [
        {
          "status": responseJson["status"],
          "message": responseJson["message"],
        }
      ];
    } else {
      return [
        {"status": "failed", "message": "something wrong. please contact admin"}
      ];
    }
  }
}
