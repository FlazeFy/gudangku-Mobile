import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/stats/models/queries.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/modules/helpers/generator.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class QueriesStatsService {
  final String baseUrl = "http://10.0.2.2:8000";
  DateTime now = DateTime.now();
  Client client = Client();

  Future<List<QueriesPieChartModel>> getTotalInventoryByCategory(
      String type) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "total-inventory-by-cat-$type-sess";
    DateTime? lastHit;
    lastHit = prefs.containsKey("last-hit-$backupKey")
        ? DateTime.tryParse(prefs.getString("last-hit-$backupKey") ?? '')
        : null;
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (!prefs.containsKey(backupKey) ||
        lastHit == null ||
        now.difference(lastHit).inSeconds > statsFetchRestTime) {
      if (connectivityResult == ConnectivityResult.none) {
        if (prefs.containsKey(backupKey)) {
          final data = prefs.getString(backupKey);
          if (data != null) {
            if (!isOffline) {
              Get.snackbar(
                  "Warning", "Lost connection, all data shown are local",
                  colorText: whiteColor,
                  backgroundColor: darkColor,
                  borderColor: primaryColor,
                  borderWidth: spaceMini / 2.5);
              isOffline = true;
            }
            return queriesPieChartModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse(
                "$baseUrl/api/v1/stats/inventory/total_by_category/$type"),
            headers: header);
        if (response.statusCode == 200) {
          if (isOffline) {
            Get.snackbar(
                "Information", "Welcome back, all data are now realtime",
                colorText: whiteColor,
                backgroundColor: darkColor,
                borderColor: primaryColor,
                borderWidth: spaceMini / 2.5);
            isOffline = false;
          }
          prefs.setString("last-hit-$backupKey", generateTempDataKey());
          prefs.setString(backupKey, response.body);
          return queriesPieChartModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return queriesPieChartModelFromJson(response.body);
            } else {
              return [];
            }
          } else {
            return [];
          }
        }
      }
    } else {
      final data = prefs.getString(backupKey);
      if (data != null) {
        return queriesPieChartModelFromJson(data);
      } else {
        return [];
      }
    }
  }

  Future<List<QueriesPieChartModel>> getTotalInventoryByFavorite(
      String type) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "total-inventory-by-fav-$type-sess";
    DateTime? lastHit;
    lastHit = prefs.containsKey("last-hit-$backupKey")
        ? DateTime.tryParse(prefs.getString("last-hit-$backupKey") ?? '')
        : null;
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (!prefs.containsKey(backupKey) ||
        lastHit == null ||
        now.difference(lastHit).inSeconds > statsFetchRestTime) {
      if (connectivityResult == ConnectivityResult.none) {
        if (prefs.containsKey(backupKey)) {
          final data = prefs.getString(backupKey);
          if (data != null) {
            if (!isOffline) {
              Get.snackbar(
                  "Warning", "Lost connection, all data shown are local",
                  colorText: whiteColor,
                  backgroundColor: darkColor,
                  borderColor: primaryColor,
                  borderWidth: spaceMini / 2.5);
              isOffline = true;
            }
            return queriesPieChartModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse(
                "$baseUrl/api/v1/stats/inventory/total_by_favorite/$type"),
            headers: header);
        if (response.statusCode == 200) {
          if (isOffline) {
            Get.snackbar(
                "Information", "Welcome back, all data are now realtime",
                colorText: whiteColor,
                backgroundColor: darkColor,
                borderColor: primaryColor,
                borderWidth: spaceMini / 2.5);
            isOffline = false;
          }
          prefs.setString("last-hit-$backupKey", generateTempDataKey());
          prefs.setString(backupKey, response.body);
          return queriesPieChartModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return queriesPieChartModelFromJson(response.body);
            } else {
              return [];
            }
          } else {
            return [];
          }
        }
      }
    } else {
      final data = prefs.getString(backupKey);
      if (data != null) {
        return queriesPieChartModelFromJson(data);
      } else {
        return [];
      }
    }
  }

  Future<List<QueriesPieChartModel>> getTotalInventoryByRoom(
      String type) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "total-inventory-by-room-$type-sess";
    DateTime? lastHit;
    lastHit = prefs.containsKey("last-hit-$backupKey")
        ? DateTime.tryParse(prefs.getString("last-hit-$backupKey") ?? '')
        : null;
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (!prefs.containsKey(backupKey) ||
        lastHit == null ||
        now.difference(lastHit).inSeconds > statsFetchRestTime) {
      if (connectivityResult == ConnectivityResult.none) {
        if (prefs.containsKey(backupKey)) {
          final data = prefs.getString(backupKey);
          if (data != null) {
            if (!isOffline) {
              Get.snackbar(
                  "Warning", "Lost connection, all data shown are local",
                  colorText: whiteColor,
                  backgroundColor: darkColor,
                  borderColor: primaryColor,
                  borderWidth: spaceMini / 2.5);
              isOffline = true;
            }
            return queriesPieChartModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse("$baseUrl/api/v1/stats/inventory/total_by_room/$type"),
            headers: header);
        if (response.statusCode == 200) {
          if (isOffline) {
            Get.snackbar(
                "Information", "Welcome back, all data are now realtime",
                colorText: whiteColor,
                backgroundColor: darkColor,
                borderColor: primaryColor,
                borderWidth: spaceMini / 2.5);
            isOffline = false;
          }
          prefs.setString("last-hit-$backupKey", generateTempDataKey());
          prefs.setString(backupKey, response.body);
          return queriesPieChartModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return queriesPieChartModelFromJson(response.body);
            } else {
              return [];
            }
          } else {
            return [];
          }
        }
      }
    } else {
      final data = prefs.getString(backupKey);
      if (data != null) {
        return queriesPieChartModelFromJson(data);
      } else {
        return [];
      }
    }
  }

  Future<List<QueriesPieChartModel>> getTotalInventoryByMerk(
      String type) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "total-inventory-by-merk-$type-sess";
    DateTime? lastHit;
    lastHit = prefs.containsKey("last-hit-$backupKey")
        ? DateTime.tryParse(prefs.getString("last-hit-$backupKey") ?? '')
        : null;
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (!prefs.containsKey(backupKey) ||
        lastHit == null ||
        now.difference(lastHit).inSeconds > statsFetchRestTime) {
      if (connectivityResult == ConnectivityResult.none) {
        if (prefs.containsKey(backupKey)) {
          final data = prefs.getString(backupKey);
          if (data != null) {
            if (!isOffline) {
              Get.snackbar(
                  "Warning", "Lost connection, all data shown are local",
                  colorText: whiteColor,
                  backgroundColor: darkColor,
                  borderColor: primaryColor,
                  borderWidth: spaceMini / 2.5);
              isOffline = true;
            }
            return queriesPieChartModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse("$baseUrl/api/v1/stats/inventory/total_by_merk/$type"),
            headers: header);
        if (response.statusCode == 200) {
          if (isOffline) {
            Get.snackbar(
                "Information", "Welcome back, all data are now realtime",
                colorText: whiteColor,
                backgroundColor: darkColor,
                borderColor: primaryColor,
                borderWidth: spaceMini / 2.5);
            isOffline = false;
          }
          prefs.setString("last-hit-$backupKey", generateTempDataKey());
          prefs.setString(backupKey, response.body);
          return queriesPieChartModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return queriesPieChartModelFromJson(response.body);
            } else {
              return [];
            }
          } else {
            return [];
          }
        }
      }
    } else {
      final data = prefs.getString(backupKey);
      if (data != null) {
        return queriesPieChartModelFromJson(data);
      } else {
        return [];
      }
    }
  }

  Future<List<StatsTotalReportCreatedModel>> getTotalReportCreatedPerMonth(
      String year) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "total-report-created-$year-sess";
    DateTime? lastHit;
    lastHit = prefs.containsKey("last-hit-$backupKey")
        ? DateTime.tryParse(prefs.getString("last-hit-$backupKey") ?? '')
        : null;
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (!prefs.containsKey(backupKey) ||
        lastHit == null ||
        now.difference(lastHit).inSeconds > statsFetchRestTime) {
      if (connectivityResult == ConnectivityResult.none) {
        if (prefs.containsKey(backupKey)) {
          final data = prefs.getString(backupKey);
          if (data != null) {
            if (!isOffline) {
              Get.snackbar(
                  "Warning", "Lost connection, all data shown are local",
                  colorText: whiteColor,
                  backgroundColor: darkColor,
                  borderColor: primaryColor,
                  borderWidth: spaceMini / 2.5);
              isOffline = true;
            }
            return statsTotalReportCreatedModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse(
                "$baseUrl/api/v1/stats/report/total_created_per_month/$year"),
            headers: header);
        if (response.statusCode == 200) {
          if (isOffline) {
            Get.snackbar(
                "Information", "Welcome back, all data are now realtime",
                colorText: whiteColor,
                backgroundColor: darkColor,
                borderColor: primaryColor,
                borderWidth: spaceMini / 2.5);
            isOffline = false;
          }
          prefs.setString("last-hit-$backupKey", generateTempDataKey());
          prefs.setString(backupKey, response.body);
          return statsTotalReportCreatedModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return statsTotalReportCreatedModelFromJson(response.body);
            } else {
              return [];
            }
          } else {
            return [];
          }
        }
      }
    } else {
      final data = prefs.getString(backupKey);
      if (data != null) {
        return statsTotalReportCreatedModelFromJson(data);
      } else {
        return [];
      }
    }
  }

  Future<List<StatsTotalInventoryCreatedModel>>
      getTotalInventoryCreatedPerMonth(String year) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "total-inventory-created-$year-sess";
    DateTime? lastHit;
    lastHit = prefs.containsKey("last-hit-$backupKey")
        ? DateTime.tryParse(prefs.getString("last-hit-$backupKey") ?? '')
        : null;
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (!prefs.containsKey(backupKey) ||
        lastHit == null ||
        now.difference(lastHit).inSeconds > statsFetchRestTime) {
      if (connectivityResult == ConnectivityResult.none) {
        if (prefs.containsKey(backupKey)) {
          final data = prefs.getString(backupKey);
          if (data != null) {
            if (!isOffline) {
              Get.snackbar(
                  "Warning", "Lost connection, all data shown are local",
                  colorText: whiteColor,
                  backgroundColor: darkColor,
                  borderColor: primaryColor,
                  borderWidth: spaceMini / 2.5);
              isOffline = true;
            }
            return statsTotalInventoryCreatedModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse(
                "$baseUrl/api/v1/stats/inventory/total_created_per_month/$year"),
            headers: header);
        if (response.statusCode == 200) {
          if (isOffline) {
            Get.snackbar(
                "Information", "Welcome back, all data are now realtime",
                colorText: whiteColor,
                backgroundColor: darkColor,
                borderColor: primaryColor,
                borderWidth: spaceMini / 2.5);
            isOffline = false;
          }
          prefs.setString("last-hit-$backupKey", generateTempDataKey());
          prefs.setString(backupKey, response.body);
          return statsTotalInventoryCreatedModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return statsTotalInventoryCreatedModelFromJson(response.body);
            } else {
              return [];
            }
          } else {
            return [];
          }
        }
      }
    } else {
      final data = prefs.getString(backupKey);
      if (data != null) {
        return statsTotalInventoryCreatedModelFromJson(data);
      } else {
        return [];
      }
    }
  }

  Future<List<StatsTotalReportSpendingModel>> getTotalReportSpendingPerMonth(
      String year) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "total-report-spending-$year-sess";
    DateTime? lastHit;
    lastHit = prefs.containsKey("last-hit-$backupKey")
        ? DateTime.tryParse(prefs.getString("last-hit-$backupKey") ?? '')
        : null;
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (!prefs.containsKey(backupKey) ||
        lastHit == null ||
        now.difference(lastHit).inSeconds > statsFetchRestTime) {
      if (connectivityResult == ConnectivityResult.none) {
        if (prefs.containsKey(backupKey)) {
          final data = prefs.getString(backupKey);
          if (data != null) {
            if (!isOffline) {
              Get.snackbar(
                  "Warning", "Lost connection, all data shown are local",
                  colorText: whiteColor,
                  backgroundColor: darkColor,
                  borderColor: primaryColor,
                  borderWidth: spaceMini / 2.5);
              isOffline = true;
            }
            return statsTotalReportSpendingModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse(
                "$baseUrl/api/v1/stats/report/total_spending_per_month/$year"),
            headers: header);
        if (response.statusCode == 200) {
          if (isOffline) {
            Get.snackbar(
                "Information", "Welcome back, all data are now realtime",
                colorText: whiteColor,
                backgroundColor: darkColor,
                borderColor: primaryColor,
                borderWidth: spaceMini / 2.5);
            isOffline = false;
          }
          prefs.setString("last-hit-$backupKey", generateTempDataKey());
          prefs.setString(backupKey, response.body);
          return statsTotalReportSpendingModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return statsTotalReportSpendingModelFromJson(response.body);
            } else {
              return [];
            }
          } else {
            return [];
          }
        }
      }
    } else {
      final data = prefs.getString(backupKey);
      if (data != null) {
        return statsTotalReportSpendingModelFromJson(data);
      } else {
        return [];
      }
    }
  }

  Future<List<StatsTotalReportUsedModel>> getTotalReportUsedPerMonth(
      String year) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "total-report-used-$year-sess";
    DateTime? lastHit;
    lastHit = prefs.containsKey("last-hit-$backupKey")
        ? DateTime.tryParse(prefs.getString("last-hit-$backupKey") ?? '')
        : null;
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (!prefs.containsKey(backupKey) ||
        lastHit == null ||
        now.difference(lastHit).inSeconds > statsFetchRestTime) {
      if (connectivityResult == ConnectivityResult.none) {
        if (prefs.containsKey(backupKey)) {
          final data = prefs.getString(backupKey);
          if (data != null) {
            if (!isOffline) {
              Get.snackbar(
                  "Warning", "Lost connection, all data shown are local",
                  colorText: whiteColor,
                  backgroundColor: darkColor,
                  borderColor: primaryColor,
                  borderWidth: spaceMini / 2.5);
              isOffline = true;
            }
            return statsTotalReportUsedModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse(
                "$baseUrl/api/v1/stats/report/total_used_per_month/$year"),
            headers: header);
        if (response.statusCode == 200) {
          if (isOffline) {
            Get.snackbar(
                "Information", "Welcome back, all data are now realtime",
                colorText: whiteColor,
                backgroundColor: darkColor,
                borderColor: primaryColor,
                borderWidth: spaceMini / 2.5);
            isOffline = false;
          }
          prefs.setString("last-hit-$backupKey", generateTempDataKey());
          prefs.setString(backupKey, response.body);
          return statsTotalReportUsedModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return statsTotalReportUsedModelFromJson(response.body);
            } else {
              return [];
            }
          } else {
            return [];
          }
        }
      }
    } else {
      final data = prefs.getString(backupKey);
      if (data != null) {
        return statsTotalReportUsedModelFromJson(data);
      } else {
        return [];
      }
    }
  }
}
