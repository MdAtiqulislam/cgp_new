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