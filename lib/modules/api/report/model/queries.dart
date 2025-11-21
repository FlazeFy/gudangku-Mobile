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

class ReportImage {
  String url;

  ReportImage({required this.url});

  factory ReportImage.fromJson(Map<String, dynamic> map) {
    return ReportImage(
      url: map['url'] ?? '',
    );
  }
}

class ReportDetailModel {
  String id;
  String reportTitle;
  String? reportDesc;
  String reportCategory;
  int isReminder;
  String? remindAt;
  String createdAt;
  String createdBy;
  String? updatedAt;
  String? deletedAt;
  int totalItem;
  int totalPrice;
  List<ReportImage>? reportImage;

  ReportDetailModel({
    required this.id,
    required this.reportTitle,
    this.reportDesc,
    required this.reportCategory,
    required this.isReminder,
    this.remindAt,
    required this.createdAt,
    required this.createdBy,
    this.updatedAt,
    this.deletedAt,
    this.reportImage,
    required this.totalItem,
    required this.totalPrice,
  });

  factory ReportDetailModel.fromJson(Map<String, dynamic> map) {
    return ReportDetailModel(
      id: map['id'],
      reportTitle: map['report_title'],
      reportDesc: map['report_desc'] ?? '',
      reportImage: (map['report_image'] as List<dynamic>? ?? [])
          .map((img) => ReportImage.fromJson(img))
          .toList(),
      reportCategory: map['report_category'],
      isReminder: map['is_reminder'],
      remindAt: map['remind_at'] ?? '',
      createdAt: map['created_at'],
      createdBy: map['created_by'],
      updatedAt: map['updated_at'] ?? '',
      deletedAt: map['deleted_at'] ?? '',
      totalItem: map['total_item'],
      totalPrice: map['total_price'],
    );
  }
}

ReportDetailModel reportDetailModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return ReportDetailModel.fromJson(data);
}

class InventoryReportModel {
  String id;
  String? inventoryId;
  String reportId;
  String itemName;
  String? itemDesc;
  int itemQty;
  int? itemPrice;
  String createdAt;
  String createdBy;

  InventoryReportModel({
    required this.id,
    this.inventoryId,
    required this.reportId,
    required this.itemName,
    this.itemDesc,
    required this.itemQty,
    required this.itemPrice,
    required this.createdAt,
    required this.createdBy,
  });

  factory InventoryReportModel.fromJson(Map<String, dynamic> map) {
    return InventoryReportModel(
      id: map['id'],
      inventoryId: map['inventory_id'] ?? '',
      reportId: map['report_id'],
      itemName: map['item_name'],
      itemDesc: map['item_desc'] ?? '',
      itemQty: map['item_qty'],
      itemPrice: map['item_price'] ?? 0,
      createdAt: map['created_at'],
      createdBy: map['created_by'],
    );
  }
}

List<InventoryReportModel> inventoryModelFromJson(dynamic data) {
  return List<InventoryReportModel>.from(
      data.map((item) => InventoryReportModel.fromJson(item)));
}
