class SingleAddressModel {
  final int? id;
  final int? customerId;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? address;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? countryId;
  final dynamic? latitude;
  final dynamic? longitude;
  final String? notes;
  final String? addressType;
  final bool? isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SingleAddressModel({
    this.id,
    this.customerId,
    this.firstName,
    this.lastName,
    this.phoneNumber1,
    this.phoneNumber2,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.countryId,
    this.latitude,
    this.longitude,
    this.notes,
    this.addressType,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory SingleAddressModel.fromJson(Map<String, dynamic> json) => SingleAddressModel(
    id: json["id"],
    customerId: json["customer_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phoneNumber1: json["phone_number_1"],
    phoneNumber2: json["phone_number_2"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    postalCode: json["postal_code"],
    countryId: json["country_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    notes: json["notes"],
    addressType: json["address_type"],
    isDefault: json["is_default"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "first_name": firstName,
    "last_name": lastName,
    "phone_number_1": phoneNumber1,
    "phone_number_2": phoneNumber2,
    "address": address,
    "city": city,
    "state": state,
    "postal_code": postalCode,
    "country_id": countryId,
    "latitude": latitude,
    "longitude": longitude,
    "notes": notes,
    "address_type": addressType,
    "is_default": isDefault,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}