import 'dart:convert';

class FavoriteToogleModel {
  int isFavorite;

  FavoriteToogleModel({required this.isFavorite});

  Map<String, dynamic> toJson() {
    return {"is_favorite": isFavorite};
  }
}

String favoriteToogleToJson(FavoriteToogleModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

class InventoryModel {
  String inventoryName;
  String inventoryCategory;
  String? inventoryDesc;
  String? inventoryMerk;
  String inventoryRoom;
  String? inventoryStorage;
  String? inventoryRack;
  int inventoryPrice;
  String? inventoryImage;
  String inventoryUnit;
  int inventoryVol;
  String? inventoryCapacityUnit;
  int? inventoryCapacityVol;
  String? inventoryColor;
  int isFavorite;
  int isReminder;

  InventoryModel({
    required this.inventoryName,
    required this.inventoryCategory,
    this.inventoryDesc,
    this.inventoryMerk,
    required this.inventoryRoom,
    this.inventoryStorage,
    this.inventoryRack,
    required this.inventoryPrice,
    this.inventoryImage,
    required this.inventoryUnit,
    required this.inventoryVol,
    this.inventoryCapacityUnit,
    this.inventoryCapacityVol,
    this.inventoryColor,
    required this.isFavorite,
    required this.isReminder,
  });

  Map<String, dynamic> toJson() {
    return {
      "inventory_name": inventoryName,
      "inventory_category": inventoryCategory,
      "inventory_desc": inventoryDesc,
      "inventory_merk": inventoryMerk,
      "inventory_room": inventoryRoom,
      "inventory_storage": inventoryStorage,
      "inventory_rack": inventoryRack,
      "inventory_price": inventoryPrice,
      "inventory_image": inventoryImage,
      "inventory_unit": inventoryUnit,
      "inventory_vol": inventoryVol,
      "inventory_capacity_unit": inventoryCapacityUnit,
      "inventory_capacity_vol": inventoryCapacityVol,
      "inventory_color": inventoryColor,
      "is_favorite": isFavorite,
      "is_reminder": isReminder,
    };
  }
}

String inventoryModelToJson(InventoryModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
