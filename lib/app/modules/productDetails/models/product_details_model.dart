// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:cgp/models/warehouse_mainbranch_model.dart';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
  final String? status;
  final String? message;
  final ProductDetailsDataModel? data;

  ProductDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : ProductDetailsDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ProductDetailsDataModel {
  final String? id;
  final dynamic productName;
  final String? regularPrice;
  final String? salesPrice;
  final int? quantity;
  final int? active;
  final int? hasOwnProductImg;
  final String? barcode;
  final String? categoryId;
  final String? primaryCategoryId;
  final String? brandId;
  final dynamic unit;
  final dynamic sizeId;
  final dynamic sizeHeight;
  final dynamic sizeWidth;
  final dynamic sizeLength;
  final dynamic colourId;
  final dynamic groupId;
  final String? weight;
  final String? weightUnitId;
  final String? materials;
  final String? shortDesc;
  final String? longDesc;
  final String? detailsOverview;
  final String? detailsSpecifications;
  final String? detailsSizeAndMaterials;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? warehouseName;
  final String? categoryName;
  final String? brandName;
  final Brand? brand;
  final List<ProductDetailsWarehouseModel>? warehouses;

  ProductDetailsDataModel({
    this.id,
    this.productName,
    this.regularPrice,
    this.salesPrice,
    this.quantity,
    this.active,
    this.hasOwnProductImg,
    this.barcode,
    this.categoryId,
    this.primaryCategoryId,
    this.brandId,
    this.unit,
    this.sizeId,
    this.sizeHeight,
    this.sizeWidth,
    this.sizeLength,
    this.colourId,
    this.groupId,
    this.weight,
    this.weightUnitId,
    this.materials,
    this.shortDesc,
    this.longDesc,
    this.detailsOverview,
    this.detailsSpecifications,
    this.detailsSizeAndMaterials,
    this.createdAt,
    this.updatedAt,
    this.warehouseName,
    this.categoryName,
    this.brandName,
    this.brand,
    this.warehouses,
  });

  factory ProductDetailsDataModel.fromJson(Map<String, dynamic> json) => ProductDetailsDataModel(
    id: json["id"],
    productName: json["product_name"],
    regularPrice: json["regular_price"],
    salesPrice: json["sales_price"],
    quantity: json["quantity"],
    active: json["active"],
    hasOwnProductImg: json["has_own_product_img"],
    barcode: json["barcode"],
    categoryId: json["category_id"],
    primaryCategoryId: json["primary_category_id"],
    brandId: json["brand_id"],
    unit: json["unit"],
    sizeId: json["size_id"],
    sizeHeight: json["size_height"],
    sizeWidth: json["size_width"],
    sizeLength: json["size_length"],
    colourId: json["colour_id"],
    groupId: json["group_id"],
    weight: json["weight"],
    weightUnitId: json["weight_unit_id"],
    materials: json["materials"],
    shortDesc: json["short_desc"],
    longDesc: json["long_desc"],
    detailsOverview: json["details_overview"],
    detailsSpecifications: json["details_specifications"],
    detailsSizeAndMaterials: json["details_size_and_materials"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    warehouseName: json["warehouse_name"],
    categoryName: json["category_name"],
    brandName: json["brand_name"],
    brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
    warehouses: json["warehouses"] == null ? [] : List<ProductDetailsWarehouseModel>.from(json["warehouses"]!.map((x) => ProductDetailsWarehouseModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "regular_price": regularPrice,
    "sales_price": salesPrice,
    "quantity": quantity,
    "active": active,
    "has_own_product_img": hasOwnProductImg,
    "barcode": barcode,
    "category_id": categoryId,
    "primary_category_id": primaryCategoryId,
    "brand_id": brandId,
    "unit": unit,
    "size_id": sizeId,
    "size_height": sizeHeight,
    "size_width": sizeWidth,
    "size_length": sizeLength,
    "colour_id": colourId,
    "group_id": groupId,
    "weight": weight,
    "weight_unit_id": weightUnitId,
    "materials": materials,
    "short_desc": shortDesc,
    "long_desc": longDesc,
    "details_overview": detailsOverview,
    "details_specifications": detailsSpecifications,
    "details_size_and_materials": detailsSizeAndMaterials,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "warehouse_name": warehouseName,
    "category_name": categoryName,
    "brand_name": brandName,
    "brand": brand?.toJson(),
    "warehouses": warehouses == null ? [] : List<dynamic>.from(warehouses!.map((x) => x.toJson())),
  };
}

class Brand {
  final String? id;
  final String? name;
  final String? slug;
  final dynamic mediaId;
  final int? active;
  final String? creatorId;
  final dynamic editorId;
  final dynamic createdAt;
  final dynamic updatedAt;

  Brand({
    this.id,
    this.name,
    this.slug,
    this.mediaId,
    this.active,
    this.creatorId,
    this.editorId,
    this.createdAt,
    this.updatedAt,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    mediaId: json["media_id"],
    active: json["active"],
    creatorId: json["creator_id"],
    editorId: json["editor_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "media_id": mediaId,
    "active": active,
    "creator_id": creatorId,
    "editor_id": editorId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class ProductDetailsWarehouseModel {
  final String? id;
  final String? productId;
  final String? warehouseId;
  final String? warehouseBranchId;
  final dynamic productName;
  final int? quantity;
  final String? regularPrice;
  final String? salesPrice;
  final int? hasOwnProductImg;
  final int? active;
  final String? name;
  final String? abnNumber;
  final dynamic createdAt;
  final DateTime? updatedAt;
  final WareHouseMainBranchModel? mainBranch;

  ProductDetailsWarehouseModel({
    this.id,
    this.productId,
    this.warehouseId,
    this.warehouseBranchId,
    this.productName,
    this.quantity,
    this.regularPrice,
    this.salesPrice,
    this.hasOwnProductImg,
    this.active,
    this.name,
    this.abnNumber,
    this.createdAt,
    this.updatedAt,
    this.mainBranch,
  });

  factory ProductDetailsWarehouseModel.fromJson(Map<String, dynamic> json) => ProductDetailsWarehouseModel(
    id: json["id"],
    productId: json["product_id"],
    warehouseId: json["warehouse_id"],
    warehouseBranchId: json["warehouse_branch_id"],
    productName: json["product_name"],
    quantity: json["quantity"],
    regularPrice: json["regular_price"],
    salesPrice: json["sales_price"],
    hasOwnProductImg: json["has_own_product_img"],
    active: json["active"],
    name: json["name"],
    abnNumber: json["abn_number"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    mainBranch: json["main_branch"] == null ? null : WareHouseMainBranchModel.fromJson(json["main_branch"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "warehouse_id": warehouseId,
    "warehouse_branch_id": warehouseBranchId,
    "product_name": productName,
    "quantity": quantity,
    "regular_price": regularPrice,
    "sales_price": salesPrice,
    "has_own_product_img": hasOwnProductImg,
    "active": active,
    "name": name,
    "abn_number": abnNumber,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
    "main_branch": mainBranch?.toJson(),
  };
}

class MainBranch {
  MainBranch();

  factory MainBranch.fromJson(Map<String, dynamic> json) => MainBranch(
  );

  Map<String, dynamic> toJson() => {
  };
}
