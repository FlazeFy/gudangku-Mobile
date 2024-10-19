import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/history/model/queries.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/modules/helpers/generator.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class HistoryQueriesService {
  final String emuUrl = "http://10.0.2.2:8000";
  DateTime now = DateTime.now();
  Client client = Client();

  Future<List<HistoryAllModel>> getAllHistory(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "history-sess";
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
        now.difference(lastHit).inSeconds > historyFetchRestTime) {
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
            return historyAllModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse("$emuUrl/api/v1/history?page=$page"),
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
          return historyAllModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return historyAllModelFromJson(response.body);
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
        return historyAllModelFromJson(data);
      } else {
        return [];
      }
    }
  }
}
