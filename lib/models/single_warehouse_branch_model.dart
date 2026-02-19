class SingleWarehouseBranchModel {
  final String? id;
  final String? name;
  final String? abnNumber;
  final int? active;
  final String? logoUrl;
  final String? thumbnailUrl;
  final String? distance;
  final WarehouseBranchRating? avgRating;
  final WareHouseBranchInfo? branchInfo;

  SingleWarehouseBranchModel({
    this.id,
    this.name,
    this.abnNumber,
    this.active,
    this.logoUrl,
    this.thumbnailUrl,
    this.distance,
    this.avgRating,
    this.branchInfo,
  });

  factory SingleWarehouseBranchModel.fromJson(Map<String, dynamic> json) => SingleWarehouseBranchModel(
    id: json["id"],
    name: json["name"],
    abnNumber: json["abn_number"],
    active: json["active"],
    logoUrl: json["logo_url"],
    thumbnailUrl: json["thumbnail_url"],
    distance: json["distance"],
    avgRating: json["avg_rating"] == null ? null : WarehouseBranchRating.fromJson(json["avg_rating"]),
    branchInfo: json["branch_info"] == null ? null : WareHouseBranchInfo.fromJson(json["branch_info"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "abn_number": abnNumber,
    "active": active,
    "logo_url": logoUrl,
    "thumbnail_url": thumbnailUrl,
    "distance": distance,
    "avg_rating": avgRating?.toJson(),
    "branch_info": branchInfo?.toJson(),
  };
}

class WarehouseBranchRating {
  final int? averageRating;
  final int? totalRatings;

  WarehouseBranchRating({
    this.averageRating,
    this.totalRatings,
  });

  factory WarehouseBranchRating.fromJson(Map<String, dynamic> json) => WarehouseBranchRating(
    averageRating: json["average_rating"],
    totalRatings: json["total_ratings"],
  );

  Map<String, dynamic> toJson() => {
    "average_rating": averageRating,
    "total_ratings": totalRatings,
  };
}

class WareHouseBranchInfo {
  final String? id;
  final String? name;
  final String? branchType;
  final String? address;
  final String? latitude;
  final String? longitude;
  final int? active;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  WareHouseBranchInfo({
    this.id,
    this.name,
    this.branchType,
    this.address,
    this.latitude,
    this.longitude,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  factory WareHouseBranchInfo.fromJson(Map<String, dynamic> json) => WareHouseBranchInfo(
    id: json["id"],
    name: json["name"],
    branchType: json["branch_type"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    active: json["active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "branch_type": branchType,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "active": active,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}