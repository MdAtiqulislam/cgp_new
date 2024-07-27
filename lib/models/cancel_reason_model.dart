class CancelReasonModel {
  final int? id;
  final String? reasonType;
  final String? reason;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CancelReasonModel({
    this.id,
    this.reasonType,
    this.reason,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory CancelReasonModel.fromJson(Map<String, dynamic> json) => CancelReasonModel(
    id: json["id"],
    reasonType: json["reason_type"],
    reason: json["reason"],
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reason_type": reasonType,
    "reason": reason,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}