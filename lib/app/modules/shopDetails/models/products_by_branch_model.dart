// To parse this JSON data, do
//
//     final productByWarehouseBranchModel = productByWarehouseBranchModelFromJson(jsonString);

import 'dart:convert';

import 'package:cgp/models/single_product_model.dart';

ProductByWarehouseBranchModel productByWarehouseBranchModelFromJson(String str) => ProductByWarehouseBranchModel.fromJson(json.decode(str));

String productByWarehouseBranchModelToJson(ProductByWarehouseBranchModel data) => json.encode(data.toJson());

class ProductByWarehouseBranchModel {
  final String? status;
  final String? message;
  final ProductByWarehouseBranchData? data;
  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;

  ProductByWarehouseBranchModel({
    this.status,
    this.message,
    this.data,
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  factory ProductByWarehouseBranchModel.fromJson(Map<String, dynamic> json) => ProductByWarehouseBranchModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : ProductByWarehouseBranchData.fromJson(json["data"]),
    total: json["total"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "total":total,
    "per_page":perPage,
    "current_page":currentPage,
    "last_page":lastPage,
  };
}

class ProductByWarehouseBranchData {
  final String? id;
  final String? name;
  final String? abnNumber;
  final int? active;
  final dynamic logoUrl;
  final dynamic thumbnailUrl;
  final AvgRating? avgRating;
  final ProductBranchInfoModel? branchInfo;
  final List<SingleProductModel>? products;

  ProductByWarehouseBranchData({
    this.id,
    this.name,
    this.abnNumber,
    this.active,
    this.logoUrl,
    this.thumbnailUrl,
    this.avgRating,
    this.branchInfo,
    this.products,
  });

  factory ProductByWarehouseBranchData.fromJson(Map<String, dynamic> json) => ProductByWarehouseBranchData(
    id: json["id"],
    name: json["name"],
    abnNumber: json["abn_number"],
    active: json["active"],
    logoUrl: json["logo_url"],
    thumbnailUrl: json["thumbnail_url"],
    avgRating: json["avg_rating"] == null ? null : AvgRating.fromJson(json["avg_rating"]),
    branchInfo: json["branch_info"] == null ? null : ProductBranchInfoModel.fromJson(json["branch_info"]),
    products: json["products"] == null ? [] : List<SingleProductModel>.from(json["products"]!.map((x) => SingleProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "abn_number": abnNumber,
    "active": active,
    "logo_url": logoUrl,
    "thumbnail_url": thumbnailUrl,
    "avg_rating": avgRating?.toJson(),
    "branch_info": branchInfo?.toJson(),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class AvgRating {
  final int? averageRating;
  final int? totalRatings;

  AvgRating({
    this.averageRating,
    this.totalRatings,
  });

  factory AvgRating.fromJson(Map<String, dynamic> json) => AvgRating(
    averageRating: json["average_rating"],
    totalRatings: json["total_ratings"],
  );

  Map<String, dynamic> toJson() => {
    "average_rating": averageRating,
    "total_ratings": totalRatings,
  };
}

class ProductBranchInfoModel {
  final String? id;
  final dynamic name;
  final String? branchType;
  final String? email;
  final String? website;
  final String? phone;
  final String? address;
  final dynamic postalCode;
  final dynamic stateId;
  final String? latitude;
  final String? longitude;
  final int? contactPersonId;
  final String? contactPersonName;
  final String? contactPersonEmail;
  final String? contactPersonPhone;
  final int? active;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductBranchInfoModel({
    this.id,
    this.name,
    this.branchType,
    this.email,
    this.website,
    this.phone,
    this.address,
    this.postalCode,
    this.stateId,
    this.latitude,
    this.longitude,
    this.contactPersonId,
    this.contactPersonName,
    this.contactPersonEmail,
    this.contactPersonPhone,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductBranchInfoModel.fromJson(Map<String, dynamic> json) => ProductBranchInfoModel(
    id: json["id"],
    name: json["name"],
    branchType: json["branch_type"],
    email: json["email"],
    website: json["website"],
    phone: json["phone"],
    address: json["address"],
    postalCode: json["postal_code"],
    stateId: json["state_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    contactPersonId: json["contact_person_id"],
    contactPersonName: json["contact_person_name"],
    contactPersonEmail: json["contact_person_email"],
    contactPersonPhone: json["contact_person_phone"],
    active: json["active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "branch_type": branchType,
    "email": email,
    "website": website,
    "phone": phone,
    "address": address,
    "postal_code": postalCode,
    "state_id": stateId,
    "latitude": latitude,
    "longitude": longitude,
    "contact_person_id": contactPersonId,
    "contact_person_name": contactPersonName,
    "contact_person_email": contactPersonEmail,
    "contact_person_phone": contactPersonPhone,
    "active": active,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

