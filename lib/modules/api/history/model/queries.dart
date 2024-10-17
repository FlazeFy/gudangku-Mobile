import 'dart:convert';

class HistoryAllModel {
  String id;
  String historyType;
  String historyContext;
  String createdAt;
  String createdBy;

  HistoryAllModel({
    required this.id,
    required this.historyType,
    required this.historyContext,
    required this.createdAt,
    required this.createdBy,
  });

  factory HistoryAllModel.fromJson(Map<String, dynamic> map) {
    return HistoryAllModel(
      id: map["id"],
      historyType: map["history_type"],
      historyContext: map["history_context"],
      createdAt: map["created_at"],
      createdBy: map["created_by"],
    );
  }
}

List<HistoryAllModel> historyAllModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<HistoryAllModel>.from(
      data['data']['data'].map((item) => HistoryAllModel.fromJson(item)));
}
