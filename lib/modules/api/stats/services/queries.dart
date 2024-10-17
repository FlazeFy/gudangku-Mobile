import 'package:gudangku/modules/api/stats/models/queries.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class QueriesStatsService {
  final String baseUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<QueriesPieChartModel>> getTotalInventoryByCategory(
      String type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.get(
        Uri.parse("$baseUrl/api/v1/stats/inventory/total_by_category/$type"),
        headers: header);
    if (response.statusCode == 200) {
      return queriesPieChartModelFromJson(response.body);
    } else {
      return [];
    }
  }

  Future<List<QueriesPieChartModel>> getTotalInventoryByFavorite(
      String type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.get(
        Uri.parse("$baseUrl/api/v1/stats/inventory/total_by_favorite/$type"),
        headers: header);
    if (response.statusCode == 200) {
      return queriesPieChartModelFromJson(response.body);
    } else {
      return [];
    }
  }

  Future<List<QueriesPieChartModel>> getTotalInventoryByRoom(
      String type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.get(
        Uri.parse("$baseUrl/api/v1/stats/inventory/total_by_room/$type"),
        headers: header);
    if (response.statusCode == 200) {
      return queriesPieChartModelFromJson(response.body);
    } else {
      return [];
    }
  }

  Future<List<StatsTotalReportCreatedModel>> getTotalReportCreatedPerMonth(
      String year) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.get(
        Uri.parse("$baseUrl/api/v1/stats/report/total_created_per_month/$year"),
        headers: header);
    if (response.statusCode == 200) {
      return statsTotalReportCreatedModelFromJson(response.body);
    } else {
      return [];
    }
  }
}
