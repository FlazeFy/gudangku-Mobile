import 'dart:convert';

class InventoryAllModel {
  String id;
  String inventoryName;
  String inventoryCategory;
  String? inventoryDesc;
  String? inventoryMerk;
  String inventoryRoom;
  String? inventoryStorage;
  String? inventoryRack;
  int inventoryPrice;
  String inventoryUnit;
  int inventoryVol;
  String? inventoryCapacityUnit;
  int? inventoryCapacityVol;
  bool isFavorite;
  bool isReminder;
  String createdAt;
  String createdBy;
  String? updatedAt;
  String? deletedAt;

  InventoryAllModel({
    required this.id,
    required this.inventoryName,
    required this.inventoryCategory,
    this.inventoryDesc,
    this.inventoryMerk,
    required this.inventoryRoom,
    this.inventoryStorage,
    this.inventoryRack,
    required this.inventoryPrice,
    required this.inventoryUnit,
    required this.inventoryVol,
    this.inventoryCapacityUnit,
    this.inventoryCapacityVol,
    required this.isFavorite,
    required this.isReminder,
    required this.createdAt,
    required this.createdBy,
    this.updatedAt,
    this.deletedAt,
  });

  factory InventoryAllModel.fromJson(Map<String, dynamic> map) {
    return InventoryAllModel(
      id: map["id"],
      inventoryName: map["inventory_name"],
      inventoryCategory: map["inventory_category"],
      inventoryDesc: map["inventory_desc"] ?? "",
      inventoryMerk: map["inventory_merk"] ?? "",
      inventoryRoom: map["inventory_room"],
      inventoryStorage: map["inventory_storage"] ?? "",
      inventoryRack: map["inventory_rack"] ?? "",
      inventoryPrice: map["inventory_price"],
      inventoryUnit: map["inventory_unit"],
      inventoryVol: map["inventory_vol"] ?? 0,
      inventoryCapacityUnit: map["inventory_capacity_unit"] ?? "",
      inventoryCapacityVol: map["inventory_capacity_vol"] ?? 0,
      isFavorite: map["is_favorite"] == 1,
      isReminder: map["is_reminder"] == 1,
      createdAt: map["created_at"] ?? "",
      createdBy: map["created_by"] ?? "",
      updatedAt: map["updated_at"] ?? "",
      deletedAt: map["deleted_at"] ?? "",
    );
  }
}

List<InventoryAllModel> inventoryAllModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<InventoryAllModel>.from(
      data['data']['data'].map((item) => InventoryAllModel.fromJson(item)));
}

InventoryAllModel inventoryModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return InventoryAllModel.fromJson(data['data']);
}

class ReminderModel {
  String? id;
  String reminderDesc;
  String reminderType;
  String reminderContext;
  String? createdAt;
  String? updatedAt;
  String? inventoryId;
  int? sendDemo;

  ReminderModel(
      {this.id,
      required this.reminderDesc,
      required this.reminderType,
      required this.reminderContext,
      this.createdAt,
      this.updatedAt,
      this.inventoryId,
      this.sendDemo});

  Map<dynamic, dynamic> toJson() {
    return {
      "inventory_id": inventoryId,
      "reminder_desc": reminderDesc,
      "reminder_type": reminderType,
      "reminder_context": reminderContext,
      "send_demo": sendDemo,
    };
  }

  factory ReminderModel.fromJson(Map<String, dynamic> map) {
    return ReminderModel(
        id: map["id"],
        reminderDesc: map["reminder_desc"],
        reminderType: map["reminder_type"],
        reminderContext: map["reminder_context"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"]);
  }
}

String reminderModelToJson(ReminderModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

List<ReminderModel> reminderInventoryModelFromJson(List data) {
  // final data = json.decode(jsonData);
  return List<ReminderModel>.from(
      data.map((item) => ReminderModel.fromJson(item)));
}
