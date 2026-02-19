// To parse this JSON data, do
//
//     final wareHouseBranchDetailsModel = wareHouseBranchDetailsModelFromJson(jsonString);

import 'dart:convert';

WareHouseBranchDetailsModel wareHouseBranchDetailsModelFromJson(String str) => WareHouseBranchDetailsModel.fromJson(json.decode(str));

String wareHouseBranchDetailsModelToJson(WareHouseBranchDetailsModel data) => json.encode(data.toJson());

class WareHouseBranchDetailsModel {
  final String? status;
  final String? message;
  final WarehouseBranchDetailsData? data;

  WareHouseBranchDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  factory WareHouseBranchDetailsModel.fromJson(Map<String, dynamic> json) => WareHouseBranchDetailsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : WarehouseBranchDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class WarehouseBranchDetailsData {
  final String? id;
  final int? warehouseId;
  final String? name;
  final String? branchType;
  final String? email;
  final String? website;
  final String? phone;
  final String? address;
  final String? postalCode;
  final String? stateId;
  final String? latitude;
  final String? longitude;
  final dynamic contactPersonId;
  final String? contactPersonName;
  final String? contactPersonEmail;
  final String? contactPersonPhone;
  final int? active;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final BranchDetailsWarehouse? warehouse;

  WarehouseBranchDetailsData({
    this.id,
    this.warehouseId,
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
    this.warehouse,
  });

  factory WarehouseBranchDetailsData.fromJson(Map<String, dynamic> json) => WarehouseBranchDetailsData(
    id: json["id"],
    warehouseId: json["warehouse_id"],
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
    warehouse: json["warehouse"] == null ? null : BranchDetailsWarehouse.fromJson(json["warehouse"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "warehouse_id": warehouseId,
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
    "warehouse": warehouse?.toJson(),
  };
}

class BranchDetailsWarehouse {
  final String? id;
  final String? name;
  final String? abnNumber;
  final int? active;
  final dynamic createdAt;
  final DateTime? updatedAt;

  BranchDetailsWarehouse({
    this.id,
    this.name,
    this.abnNumber,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  factory BranchDetailsWarehouse.fromJson(Map<String, dynamic> json) => BranchDetailsWarehouse(
    id: json["id"],
    name: json["name"],
    abnNumber: json["abn_number"],
    active: json["active"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "abn_number": abnNumber,
    "active": active,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
  };
}
