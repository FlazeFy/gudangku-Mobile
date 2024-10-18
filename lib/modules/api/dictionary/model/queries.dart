import 'dart:convert';

class DctModel {
  String dctName;

  DctModel({
    required this.dctName,
  });

  factory DctModel.fromJson(Map<String, dynamic> map) {
    return DctModel(
      dctName: map["dictionary_name"],
    );
  }
}

List<DctModel> dctModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<DctModel>.from(
      data['data'].map((item) => DctModel.fromJson(item)));
}
