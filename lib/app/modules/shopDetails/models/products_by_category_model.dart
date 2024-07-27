
import 'dart:convert';

import 'package:cgp/app/modules/home/models/home_data_model.dart';

import '../../../../models/single_product_model.dart';

ProductsByCategoryModel productsByCategoryModelFromJson(String str) => ProductsByCategoryModel.fromJson(json.decode(str));

String productsByCategoryModelToJson(ProductsByCategoryModel data) => json.encode(data.toJson());

class ProductsByCategoryModel {
  final String? message;
  final String? status;
  final Data? data;

  ProductsByCategoryModel({
    this.message,
    this.status,
    this.data,
  });

  factory ProductsByCategoryModel.fromJson(Map<String, dynamic> json) => ProductsByCategoryModel(
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
  final List<SingleProductModel>? products;

  Data({
    this.category,
    this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    products: json["products"] == null ? [] : List<SingleProductModel>.from(json["products"]!.map((x) => SingleProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category?.toJson(),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
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
  final String? editorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? brandName;
  final List<ProductWarehouse>? warehouses;

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
    this.warehouses,
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
    warehouses: json["warehouses"] == null ? [] : List<ProductWarehouse>.from(json["warehouses"]!.map((x) => ProductWarehouse.fromJson(x))),
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
    "warehouses": warehouses == null ? [] : List<dynamic>.from(warehouses!.map((x) => x.toJson())),
  };
}

class ProductWarehouse {
  final String? warehouseId;
  final String? warehouseName;

  ProductWarehouse({
    this.warehouseId,
    this.warehouseName,
  });

  factory ProductWarehouse.fromJson(Map<String, dynamic> json) => ProductWarehouse(
    warehouseId: json["warehouse_id"],
    warehouseName: json["warehouse_name"],
  );

  Map<String, dynamic> toJson() => {
    "warehouse_id": warehouseId,
    "warehouse_name": warehouseName,
  };
}
