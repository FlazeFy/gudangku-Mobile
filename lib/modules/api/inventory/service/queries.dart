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
}
