import 'dart:convert';

class PieData {
  PieData(this.xData, this.yData, [this.text = ""]);
  final String xData;
  final num yData;
  final String text;
}

class TwoLineData {
  TwoLineData(this.xData, this.yData, this.zData, [this.text = ""]);
  final String xData;
  final num yData;
  final num zData;
  final String text;
}

class OneLineData {
  OneLineData(this.xData, this.yData, [this.text = ""]);
  final String xData;
  final num yData;
  final String text;
}

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

class StatsTotalInventoryCreatedModel {
  String ctx;
  int total;

  StatsTotalInventoryCreatedModel({required this.ctx, required this.total});

  factory StatsTotalInventoryCreatedModel.fromJson(Map<dynamic, dynamic> map) {
    return StatsTotalInventoryCreatedModel(
        ctx: map["context"], total: map["total"]);
  }
}

List<StatsTotalInventoryCreatedModel> statsTotalInventoryCreatedModelFromJson(
    String jsonData) {
  final data = json.decode(jsonData);
  return List<StatsTotalInventoryCreatedModel>.from(data['data']
      .map((item) => StatsTotalInventoryCreatedModel.fromJson(item)));
}

class StatsTotalReportSpendingModel {
  String ctx;
  dynamic totalPrice;
  dynamic avgPrice;

  StatsTotalReportSpendingModel(
      {required this.ctx, required this.totalPrice, required this.avgPrice});

  factory StatsTotalReportSpendingModel.fromJson(Map<dynamic, dynamic> map) {
    return StatsTotalReportSpendingModel(
      ctx: map["context"],
      totalPrice: map["total_price"],
      avgPrice: map["average_price_per_item"],
    );
  }
}

List<StatsTotalReportSpendingModel> statsTotalReportSpendingModelFromJson(
    String jsonData) {
  final data = json.decode(jsonData);
  return List<StatsTotalReportSpendingModel>.from(
      data['data'].map((item) => StatsTotalReportSpendingModel.fromJson(item)));
}

class StatsTotalReportUsedModel {
  String ctx;
  dynamic totalCheckout;
  dynamic totalWashlist;

  StatsTotalReportUsedModel(
      {required this.ctx,
      required this.totalCheckout,
      required this.totalWashlist});

  factory StatsTotalReportUsedModel.fromJson(Map<dynamic, dynamic> map) {
    return StatsTotalReportUsedModel(
      ctx: map["context"],
      totalCheckout: map["total_checkout"],
      totalWashlist: map["total_washlist"],
    );
  }
}

List<StatsTotalReportUsedModel> statsTotalReportUsedModelFromJson(
    String jsonData) {
  final data = json.decode(jsonData);
  return List<StatsTotalReportUsedModel>.from(
      data['data'].map((item) => StatsTotalReportUsedModel.fromJson(item)));
}
