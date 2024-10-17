import 'package:gudangku/modules/api/auth/model/queries.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class QueriesAuthServices {
  final String emuUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<ProfileModel?> getMyProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client
        .get(Uri.parse("$emuUrl/api/v1/user/my_profile"), headers: header);
    if (response.statusCode == 200) {
      return profileModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
