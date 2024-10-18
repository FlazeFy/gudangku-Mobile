import 'dart:convert';

class ReportModel {
  String id;
  String reportTitle;
  String? reportDesc;
  String reportCategory;
  int isReminder;
  String? remindAt;
  String createdAt;
  int totalVariety;
  int totalItem;
  String? reportItems;
  int? itemPrice;

  ReportModel({
    required this.id,
    required this.reportTitle,
    this.reportDesc,
    required this.reportCategory,
    required this.isReminder,
    this.remindAt,
    required this.createdAt,
    required this.totalVariety,
    required this.totalItem,
    this.reportItems,
    this.itemPrice,
  });

  factory ReportModel.fromJson(Map<String, dynamic> map) {
    return ReportModel(
      id: map["id"],
      reportTitle: map["report_title"],
      reportDesc: map["report_desc"] ?? '',
      reportCategory: map["report_category"],
      isReminder: map["is_reminder"],
      remindAt: map["remind_at"] ?? '',
      createdAt: map["created_at"],
      totalVariety: map["total_variety"],
      totalItem: map["total_item"],
      reportItems: map["report_items"] ?? '',
      itemPrice: map["item_price"] ?? 0,
    );
  }
}

List<ReportModel> reportModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ReportModel>.from(
      data['data']['data'].map((item) => ReportModel.fromJson(item)));
}
