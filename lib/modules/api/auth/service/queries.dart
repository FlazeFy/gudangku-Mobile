import 'package:gudangku/modules/api/auth/model/queries.dart';
import 'package:http/http.dart' show Client;

class QueriesAuthServices {
  final String emuUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<ProfileModel?> getMyProfile() async {
    const token = '33|0DWfzepjZqA1Utxi3X9KQ40vcmKmZdJIatAJtmnq8d0f169f';
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
