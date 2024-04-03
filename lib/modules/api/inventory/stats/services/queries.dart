import 'package:gudangku/modules/api/inventory/stats/models/queries.dart';
import 'package:http/http.dart' show Client;

class QueriesStatsService {
  final String baseUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<QueriesPieChartModel>> getTotalInventoryByCategory() async {
    const token = '33|0DWfzepjZqA1Utxi3X9KQ40vcmKmZdJIatAJtmnq8d0f169f';
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.get(
        Uri.parse("$baseUrl/api/v1/stats/total_inventory_by_category"),
        headers: header);
    if (response.statusCode == 200) {
      return queriesPieChartModelFromJson(response.body);
    } else {
      return [];
    }
  }

  Future<List<QueriesPieChartModel>> getTotalInventoryByFavorite() async {
    const token = '33|0DWfzepjZqA1Utxi3X9KQ40vcmKmZdJIatAJtmnq8d0f169f';
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.get(
        Uri.parse("$baseUrl/api/v1/stats/total_inventory_by_favorite"),
        headers: header);
    if (response.statusCode == 200) {
      return queriesPieChartModelFromJson(response.body);
    } else {
      return [];
    }
  }

  Future<List<QueriesPieChartModel>> getTotalInventoryByRoom() async {
    const token = '33|0DWfzepjZqA1Utxi3X9KQ40vcmKmZdJIatAJtmnq8d0f169f';
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.get(
        Uri.parse("$baseUrl/api/v1/stats/total_inventory_by_room"),
        headers: header);
    if (response.statusCode == 200) {
      return queriesPieChartModelFromJson(response.body);
    } else {
      return [];
    }
  }
}
