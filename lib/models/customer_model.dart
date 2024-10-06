
/*

class CustomerModel {
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final DateTime? registrationDate;
  final dynamic dateOfBirth;
  final dynamic gender;
  final dynamic profileImageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? id;
  final DateTime? lastLogin;
  final bool? isActive;

  CustomerModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.registrationDate,
    this.dateOfBirth,
    this.gender,
    this.profileImageUrl,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.lastLogin,
    this.isActive,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    email: json["email"],
    registrationDate: json["registration_date"] == null ? null : DateTime.parse(json["registration_date"]),
    dateOfBirth: json["date_of_birth"],
    gender: json["gender"],
    profileImageUrl: json["profile_image_url"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    id: json["id"],
    lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "email": email,
    "registration_date": registrationDate?.toIso8601String(),
    "date_of_birth": dateOfBirth,
    "gender": gender,
    "profile_image_url": profileImageUrl,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "id": id,
    "last_login": lastLogin?.toIso8601String(),
    "is_active": isActive,
  };
}

 */

class CustomerModel {
  final int? id;
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final DateTime? dateOfBirth;
  final String? gender;
  final int? profileImageCfMediaId;
  final DateTime? registrationDate;
  final DateTime? lastLogin;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? url;
  final bool? hasDefaultPaymentMethod;
  final AvgRating? avgRating;
  final OngoingDelivery? ongoingDelivery;

  CustomerModel({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.profileImageCfMediaId,
    this.registrationDate,
    this.lastLogin,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.url,
    this.hasDefaultPaymentMethod,
    this.avgRating,
    this.ongoingDelivery,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    id: json["id"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    email: json["email"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    gender: json["gender"],
    profileImageCfMediaId: json["profile_image_cf_media_id"],
    registrationDate: json["registration_date"] == null ? null : DateTime.parse(json["registration_date"]),
    lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    url: json["url"],
    hasDefaultPaymentMethod: json["has_default_payment_method"],
    avgRating: json["avg_rating"] == null ? null : AvgRating.fromJson(json["avg_rating"]),
    ongoingDelivery: json["ongoing_delivery"] == null ? null : OngoingDelivery.fromJson(json["ongoing_delivery"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "email": email,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "profile_image_cf_media_id": profileImageCfMediaId,
    "registration_date": registrationDate?.toIso8601String(),
    "last_login": lastLogin?.toIso8601String(),
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "url": url,
    "has_default_payment_method": hasDefaultPaymentMethod,
    "avg_rating": avgRating?.toJson(),
    "ongoing_delivery": ongoingDelivery?.toJson(),
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

class OngoingDelivery {
  final int? orderId;
  final int? deliveryId;
  final String? shippingStatus;

  OngoingDelivery({
    this.orderId,
    this.deliveryId,
    this.shippingStatus,
  });

  factory OngoingDelivery.fromJson(Map<String, dynamic> json) => OngoingDelivery(
    orderId: json["order_id"],
    deliveryId: json["delivery_id"],
    shippingStatus: json["shipping_status"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "delivery_id": deliveryId,
    "shipping_status": shippingStatus,
  };
}