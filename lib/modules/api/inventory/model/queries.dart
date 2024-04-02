import 'dart:convert';

class InventoryAllModel {
  String id;
  String inventoryName;
  String inventoryCategory;
  String? inventoryDesc;
  String inventoryMerk;
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
    required this.inventoryMerk,
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
      createdBy: map["created_by"],
      updatedAt: map["updated_at"] ?? "",
      deletedAt: map["deleted_at"] ?? "",
    );
  }
}

List<InventoryAllModel> inventoryAllModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<InventoryAllModel>.from(
      data['data'].map((item) => InventoryAllModel.fromJson(item)));
}
