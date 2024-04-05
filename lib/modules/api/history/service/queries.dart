import 'package:gudangku/modules/api/history/model/queries.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show Client;

class HistoryQueriesService {
  final String emuUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<HistoryAllModel>> getAllHistory() async {
    const token = '33|0DWfzepjZqA1Utxi3X9KQ40vcmKmZdJIatAJtmnq8d0f169f';
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response =
        await client.get(Uri.parse("$emuUrl/api/v1/history"), headers: header);
    if (response.statusCode == 200) {
      return historyAllModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      return [];
    } else {
      return [];
    }
  }
}
