
import 'dart:convert';
import '../../home/models/home_data_model.dart';
import '../../productDetails/models/product_details_model.dart';

WareHouseDetailsModel wareHouseDetailsModelFromJson(String str) => WareHouseDetailsModel.fromJson(json.decode(str));

String wareHouseDetailsModelToJson(WareHouseDetailsModel data) => json.encode(data.toJson());

class WareHouseDetailsModel {
  final String? message;
  final String? status;
  final Data? data;

  WareHouseDetailsModel({
    this.message,
    this.status,
    this.data,
  });

  factory WareHouseDetailsModel.fromJson(Map<String, dynamic> json) => WareHouseDetailsModel(
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
  final String? id;
  final String? name;
  final String? abnNumber;
  final String? thumbnailUrl;
  final String? logoUrl;
  final int? active;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Branch? mainBranch;
  final List<Branch>? branches;
  final List<Category>? categories;
  final List<Brand>? brands;

  Data({
    this.id,
    this.name,
    this.abnNumber,
    this.thumbnailUrl,
    this.logoUrl,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.mainBranch,
    this.branches,
    this.categories,
    this.brands,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    abnNumber: json["abn_number"],
    thumbnailUrl: json["thumbnail_url"],
    logoUrl: json["logo_url"],
    active: json["active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    mainBranch: json["main_branch"] == null ? null : Branch.fromJson(json["main_branch"]),
    branches: json["branches"] == null ? [] : List<Branch>.from(json["branches"]!.map((x) => Branch.fromJson(x))),
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    brands: json["brands"] == null ? [] : List<Brand>.from(json["brands"]!.map((x) => Brand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "abn_number": abnNumber,
    "active": active,
    "thumbnail_url": thumbnailUrl,
    "logo_url": logoUrl,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "main_branch": mainBranch?.toJson(),
    "branches": branches == null ? [] : List<dynamic>.from(branches!.map((x) => x.toJson())),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "brands": brands == null ? [] : List<dynamic>.from(brands!.map((x) => x.toJson())),
  };
}

class Branch {
  final String? id;
  final int? warehouseId;
  final String? branchType;
  final String? email;
  final String? website;
  final String? phone;
  final String? address;
  final String? latitude;
  final String? longitude;
  final int? contactPersonId;
  final String? contactPersonName;
  final String? contactPersonEmail;
  final String? contactPersonPhone;
  final int? active;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Branch({
    this.id,
    this.warehouseId,
    this.branchType,
    this.email,
    this.website,
    this.phone,
    this.address,
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

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["id"],
    warehouseId: json["warehouse_id"],
    branchType: json["branch_type"],
    email: json["email"],
    website: json["website"],
    phone: json["phone"],
    address: json["address"],
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
    "warehouse_id": warehouseId,
    "branch_type": branchType,
    "email": email,
    "website": website,
    "phone": phone,
    "address": address,
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

/*
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
*/
