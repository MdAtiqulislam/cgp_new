// To parse this JSON data, do
//
//     final wareHouseSearchModel = wareHouseSearchModelFromJson(jsonString);

import 'dart:convert';

WareHouseSearchModel wareHouseSearchModelFromJson(String str) => WareHouseSearchModel.fromJson(json.decode(str));

String wareHouseSearchModelToJson(WareHouseSearchModel data) => json.encode(data.toJson());

class WareHouseSearchModel {
  final String? message;
  final String? status;
  final List<WarehouseSearchData>? data;

  WareHouseSearchModel({
    this.message,
    this.status,
    this.data,
  });

  factory WareHouseSearchModel.fromJson(Map<String, dynamic> json) => WareHouseSearchModel(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? [] : List<WarehouseSearchData>.from(json["data"]!.map((x) => WarehouseSearchData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class WarehouseSearchData {
  final String? id;
  final String? name;
  final String? abnNumber;
  final int? active;
  final dynamic logoUrl;
  final dynamic thumbnailUrl;
  final AvgRating? avgRating;
  final BranchInfo? branchInfo;

  WarehouseSearchData({
    this.id,
    this.name,
    this.abnNumber,
    this.active,
    this.logoUrl,
    this.thumbnailUrl,
    this.avgRating,
    this.branchInfo,
  });

  factory WarehouseSearchData.fromJson(Map<String, dynamic> json) => WarehouseSearchData(
    id: json["id"],
    name: json["name"],
    abnNumber: json["abn_number"],
    active: json["active"],
    logoUrl: json["logo_url"],
    thumbnailUrl: json["thumbnail_url"],
    avgRating: json["avg_rating"] == null ? null : AvgRating.fromJson(json["avg_rating"]),
    branchInfo: json["branch_info"] == null ? null : BranchInfo.fromJson(json["branch_info"]),
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

class BranchInfo {
  final String? id;
  final String? name;
  final String? branchType;
  final String? address;
  final String? latitude;
  final String? longitude;
  final int? active;

  BranchInfo({
    this.id,
    this.name,
    this.branchType,
    this.address,
    this.latitude,
    this.longitude,
    this.active,
  });

  factory BranchInfo.fromJson(Map<String, dynamic> json) => BranchInfo(
    id: json["id"],
    name: json["name"],
    branchType: json["branch_type"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "branch_type": branchType,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "active": active,
  };
}
