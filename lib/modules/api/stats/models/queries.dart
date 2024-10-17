import 'dart:convert';

class QueriesPieChartModel {
  String ctx;
  int total;

  QueriesPieChartModel({required this.ctx, required this.total});

  factory QueriesPieChartModel.fromJson(Map<String, dynamic> map) {
    return QueriesPieChartModel(
      ctx: map["context"],
      total: map["total"],
    );
  }
}

List<QueriesPieChartModel> queriesPieChartModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<QueriesPieChartModel>.from(
      data['data'].map((item) => QueriesPieChartModel.fromJson(item)));
}

class StatsTotalReportCreatedModel {
  String ctx;
  int totalReport;
  int totalItem;

  StatsTotalReportCreatedModel(
      {required this.ctx, required this.totalReport, required this.totalItem});

  factory StatsTotalReportCreatedModel.fromJson(Map<dynamic, dynamic> map) {
    return StatsTotalReportCreatedModel(
      ctx: map["context"],
      totalReport: map["total_report"],
      totalItem: map["total_item"],
    );
  }
}

List<StatsTotalReportCreatedModel> statsTotalReportCreatedModelFromJson(
    String jsonData) {
  final data = json.decode(jsonData);
  return List<StatsTotalReportCreatedModel>.from(
      data['data'].map((item) => StatsTotalReportCreatedModel.fromJson(item)));
}
