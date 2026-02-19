import 'package:cgp/models/warehouse_mainbranch_model.dart';

class SingleWarehouseModel {
  final String? id;
  final String? name;
  final String? abnNumber;
  final String? logoUrl;
  final String? thumbnailUrl;
  final int? active;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final WareHouseMainBranchModel? mainBranch;
  final List<String>? categories;
  final List<String>? brands;

  SingleWarehouseModel({
    this.id,
    this.name,
    this.abnNumber,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.mainBranch,
    this.categories,
    this.brands,
    this.logoUrl,
    this.thumbnailUrl
  });

  factory SingleWarehouseModel.fromJson(Map<String, dynamic> json) => SingleWarehouseModel(
    id: json["id"],
    name: json["name"],
    abnNumber: json["abn_number"],
    logoUrl: json["logo_url"],
    thumbnailUrl: json["thumbnail_url"],
    active: json["active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    mainBranch: json["main_branch"] == null ? null : WareHouseMainBranchModel.fromJson(json["main_branch"]),
    categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
    brands: json["brands"] == null ? [] : List<String>.from(json["brands"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "abn_number": abnNumber,
    "logo_url": logoUrl,
    "thumbnail_url": thumbnailUrl,
    "active": active,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "main_branch": mainBranch?.toJson(),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
    "brands": brands == null ? [] : List<dynamic>.from(brands!.map((x) => x)),
  };
}