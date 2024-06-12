import 'dart:convert';

class ProfileModel {
  String username;
  String email;
  String telegramUserId;
  String createdAt;

  ProfileModel(
      {required this.username,
      required this.email,
      required this.telegramUserId,
      required this.createdAt});

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      username: map["username"],
      email: map["email"],
      telegramUserId: map["telegram_user_id"],
      createdAt: map["created_at"],
    );
  }
}

ProfileModel profileModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return ProfileModel.fromJson(data['data']);
}
