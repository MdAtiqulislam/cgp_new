// To parse this JSON data, do
//
//     final productsByWireHouseModel = productsByWireHouseModelFromJson(jsonString);

import 'dart:convert';


import '../../../../models/single_product_model.dart';
import '../../../../models/single_warehouse_model.dart';

ProductsByWareHouseModel productsByWareHouseModelFromJson(String str) => ProductsByWareHouseModel.fromJson(json.decode(str));

String productsByWireHouseModelToJson(ProductsByWareHouseModel data) => json.encode(data.toJson());

class ProductsByWareHouseModel {
  final String? message;
  final String? status;
  final Data? data;

  ProductsByWareHouseModel({
    this.message,
    this.status,
    this.data,
  });

  factory ProductsByWareHouseModel.fromJson(Map<String, dynamic> json) => ProductsByWareHouseModel(
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
  final SingleWarehouseModel? warehouse;
  final List<SingleProductModel>? products;

  Data({
    this.warehouse,
    this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    warehouse: json["warehouse"] == null ? null : SingleWarehouseModel.fromJson(json["warehouse"]),
    products: json["products"] == null ? [] : List<SingleProductModel>.from(json["products"]!.map((x) => SingleProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "warehouse": warehouse?.toJson(),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

/*class Product {
  final String? id;
  final String? name;
  final String? slug;
  final String? barcode;
  final dynamic productTypeId;
  final String? categoryId;
  final String? primaryCategoryId;
  final dynamic unitTypeId;
  final dynamic unit;
  final dynamic sizeId;
  final dynamic colourId;
  final dynamic groupId;
  final String? weight;
  final String? materials;
  final String? price;
  final String? shortDesc;
  final String? longDesc;
  final String? detailsOverview;
  final String? detailsSpecifications;
  final String? detailsSizeAndMaterials;
  final dynamic statusId;
  final int? active;
  final dynamic creatorId;
  final dynamic editorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? brandName;

  Product({
    this.id,
    this.name,
    this.slug,
    this.barcode,
    this.productTypeId,
    this.categoryId,
    this.primaryCategoryId,
    this.unitTypeId,
    this.unit,
    this.sizeId,
    this.colourId,
    this.groupId,
    this.weight,
    this.materials,
    this.price,
    this.shortDesc,
    this.longDesc,
    this.detailsOverview,
    this.detailsSpecifications,
    this.detailsSizeAndMaterials,
    this.statusId,
    this.active,
    this.creatorId,
    this.editorId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.brandName,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    barcode: json["barcode"],
    productTypeId: json["product_type_id"],
    categoryId: json["category_id"],
    primaryCategoryId: json["primary_category_id"],
    unitTypeId: json["unit_type_id"],
    unit: json["unit"],
    sizeId: json["size_id"],
    colourId: json["colour_id"],
    groupId: json["group_id"],
    weight: json["weight"],
    materials: json["materials"],
    price: json["price"],
    shortDesc: json["short_desc"],
    longDesc: json["long_desc"],
    detailsOverview: json["details_overview"],
    detailsSpecifications: json["details_specifications"],
    detailsSizeAndMaterials: json["details_size_and_materials"],
    statusId: json["status_id"],
    active: json["active"],
    creatorId: json["creator_id"],
    editorId: json["editor_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    brandName: json["brand_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "barcode": barcode,
    "product_type_id": productTypeId,
    "category_id": categoryId,
    "primary_category_id": primaryCategoryId,
    "unit_type_id": unitTypeId,
    "unit": unit,
    "size_id": sizeId,
    "colour_id": colourId,
    "group_id": groupId,
    "weight": weight,
    "materials": materials,
    "price": price,
    "short_desc": shortDesc,
    "long_desc": longDesc,
    "details_overview": detailsOverview,
    "details_specifications": detailsSpecifications,
    "details_size_and_materials": detailsSizeAndMaterials,
    "status_id": statusId,
    "active": active,
    "creator_id": creatorId,
    "editor_id": editorId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "brand_name": brandName,
  };
}

class Warehouse {
  final String? id;
  final String? name;
  final String? abnNumber;
  final int? active;
  final dynamic createdAt;
  final dynamic updatedAt;
  final MainBranch? mainBranch;

  Warehouse({
    this.id,
    this.name,
    this.abnNumber,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.mainBranch,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
    id: json["id"],
    name: json["name"],
    abnNumber: json["abn_number"],
    active: json["active"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    mainBranch: json["main_branch"] == null ? null : MainBranch.fromJson(json["main_branch"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "abn_number": abnNumber,
    "active": active,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "main_branch": mainBranch?.toJson(),
  };
}

class MainBranch {
  MainBranch();

  factory MainBranch.fromJson(Map<String, dynamic> json) => MainBranch(
  );

  Map<String, dynamic> toJson() => {
  };
}*/
