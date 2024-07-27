// To parse this JSON data, do
//
//     final wareHousesByCategoryModel = wareHousesByCategoryModelFromJson(jsonString);

import 'dart:convert';

import '../../home/models/home_data_model.dart';

WareHousesByCategoryModel wareHousesByCategoryModelFromJson(String str) => WareHousesByCategoryModel.fromJson(json.decode(str));

String wareHousesByCategoryModelToJson(WareHousesByCategoryModel data) => json.encode(data.toJson());

class WareHousesByCategoryModel {
  final String? message;
  final String? status;
  final Data? data;

  WareHousesByCategoryModel({
    this.message,
    this.status,
    this.data,
  });

  factory WareHousesByCategoryModel.fromJson(Map<String, dynamic> json) => WareHousesByCategoryModel(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  final Category? category;
  final List<WarehouseByCategory>? warehouses;

  Data({
    this.category,
    this.warehouses,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    warehouses: json["warehouses"] == null ? [] : List<WarehouseByCategory>.from(json["warehouses"]!.map((x) => WarehouseByCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category?.toJson(),
    "warehouses": warehouses == null ? [] : List<dynamic>.from(warehouses!.map((x) => x.toJson())),
  };
}

/*class Category {
  final String? id;
  final String? name;
  final String? slug;
  final int? parentId;
  final dynamic grandParentId;
  final dynamic serial;
  final int? active;
  final dynamic createdAt;
  final dynamic updatedAt;

  Category({
    this.id,
    this.name,
    this.slug,
    this.parentId,
    this.grandParentId,
    this.serial,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    parentId: json["parent_id"],
    grandParentId: json["grand_parent_id"],
    serial: json["serial"],
    active: json["active"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "parent_id": parentId,
    "grand_parent_id": grandParentId,
    "serial": serial,
    "active": active,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}*/

class WarehouseByCategory {
  final String? id;
  final String? name;
  final String? productCounts;

  WarehouseByCategory({
    this.id,
    this.name,
    this.productCounts,
  });

  factory WarehouseByCategory.fromJson(Map<String, dynamic> json) => WarehouseByCategory(
    id: json["id"],
    name: json["name"],
    productCounts: json["product_counts"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "product_counts": productCounts,
  };
}
