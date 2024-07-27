// To parse this JSON data, do
//
//     final homeDataModel = homeDataModelFromJson(jsonString);

import 'dart:convert';

import '../../../../models/single_product_model.dart';
import '../../../../models/single_warehouse_model.dart';

HomeDataModel homeDataModelFromJson(String str) => HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
  final String? message;
  final String? status;
  final List<Category>? categories;
  final List<SingleWarehouseModel>? warehouses;
  final List<SingleProductModel>? products;

  HomeDataModel({
    this.message,
    this.status,
    this.categories,
    this.warehouses,
    this.products,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
    message: json["message"],
    status: json["status"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    warehouses: json["warehouses"] == null ? [] : List<SingleWarehouseModel>.from(json["warehouses"]!.map((x) => SingleWarehouseModel.fromJson(x))),
    products: json["products"] == null ? [] : List<SingleProductModel>.from(json["products"]!.map((x) => SingleProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "warehouses": warehouses == null ? [] : List<dynamic>.from(warehouses!.map((x) => x.toJson())),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Category {
  final String? id;
  final String? name;
  final String? slug;
  final int? parentId;
  final dynamic grandParentId;
  final dynamic serial;
  final int? active;
  final dynamic createdAt;
  final DateTime? updatedAt;

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
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    "updated_at": updatedAt?.toIso8601String(),
  };
}
















