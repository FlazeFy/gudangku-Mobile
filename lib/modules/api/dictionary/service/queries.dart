import 'package:gudangku/modules/api/dictionary/model/queries.dart';
import 'package:gudangku/modules/api/history/model/queries.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class DictionaryQueriesService {
  final String emuUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<DctModel>> getDctByType(String type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.get(
        Uri.parse("$emuUrl/api/v1/dictionary/type/$type"),
        headers: header);
    if (response.statusCode == 200) {
      print(response.body);
      return dctModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      return [];
    } else {
      return [];
    }
  }
}
