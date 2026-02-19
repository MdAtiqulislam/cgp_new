import '../app/modules/shopDetails/models/products_by_category_model.dart';

class SingleProductModel {
  final String? id;
  final String? productName;
  final String? regularPrice;
  final String? salesPrice;
  final int? quantity;
  final int? active;
  final int? hasOwnProductImg;
  final String? barcode;
  final String? categoryId;
  final String? primaryCategoryId;
  final dynamic unit;
  final dynamic sizeId;
  final String? sizeHeight;
  final String? sizeWidth;
  final String? sizeLength;
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
  final List<ProductWarehouse>? warehouses;
  final List<String>? imgUrls;

  SingleProductModel({
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
    this.warehouses,
    this.imgUrls,
  });

  factory SingleProductModel.fromJson(Map<String, dynamic> json) => SingleProductModel(
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
    warehouses: json["warehouses"] == null ? [] : List<ProductWarehouse>.from(json["warehouses"]!.map((x) => ProductWarehouse.fromJson(x))),
    imgUrls: json["img_urls"] == null ? [] : List<String>.from(json["img_urls"]!.map((x) => x)),

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
    "warehouses": warehouses == null ? [] : List<dynamic>.from(warehouses!.map((x) => x.toJson())),
    "img_urls": imgUrls == null ? [] : List<dynamic>.from(imgUrls!.map((x) => x)),

  };
}