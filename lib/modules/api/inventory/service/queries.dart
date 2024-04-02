import 'package:gudangku/modules/api/inventory/model/queries.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show Client;

class InventoryQueriesService {
  final String emuUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<InventoryAllModel>> getAllInventory() async {
    const token = '33|0DWfzepjZqA1Utxi3X9KQ40vcmKmZdJIatAJtmnq8d0f169f';
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.get(Uri.parse("$emuUrl/api/v1/inventory"),
        headers: header);
    if (response.statusCode == 200) {
      return inventoryAllModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      return [];
    } else {
      return [];
    }
  }
}
