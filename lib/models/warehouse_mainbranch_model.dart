class WareHouseMainBranchModel {
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

  WareHouseMainBranchModel({
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

  factory WareHouseMainBranchModel.fromJson(Map<String, dynamic> json) => WareHouseMainBranchModel(
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