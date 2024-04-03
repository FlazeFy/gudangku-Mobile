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
