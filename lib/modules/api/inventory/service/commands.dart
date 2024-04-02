import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:http/http.dart' show Client;

class InventoryCommandsService {
  final String emuUrl = "http://10.0.2.2:8000";

  Client client = Client();

  Future<List<Map<String, dynamic>>> softDeleteInventoryById(String id) async {
    const token = '33|0DWfzepjZqA1Utxi3X9KQ40vcmKmZdJIatAJtmnq8d0f169f';

    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.delete(
      Uri.parse("$emuUrl/api/v1/inventory/delete/${id}"),
      headers: header,
    );

    var responseData = jsonDecode(response.body);

    print(response);

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
}
