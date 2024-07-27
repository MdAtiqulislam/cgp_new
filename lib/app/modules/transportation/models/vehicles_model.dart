// To parse this JSON data, do
//
//     final vehiclesModel = vehiclesModelFromJson(jsonString);

import 'dart:convert';

VehiclesModel vehiclesModelFromJson(String str) => VehiclesModel.fromJson(json.decode(str));

String vehiclesModelToJson(VehiclesModel data) => json.encode(data.toJson());

class VehiclesModel {
  final String? status;
  final String? message;
  final List<SingleVehicleModel>? data;

  VehiclesModel({
    this.status,
    this.message,
    this.data,
  });

  factory VehiclesModel.fromJson(Map<String, dynamic> json) => VehiclesModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SingleVehicleModel>.from(json["data"]!.map((x) => SingleVehicleModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleVehicleModel {
  final String? id;
  final int? typeId;
  final String? name;
  final String? code;
  final String? mediaUrl;
  final String? vehicleCapacity;
  final int? minKm;
  final int? maxTimeInMinutes;
  final String? minFare;
  final String? perKmFare;
  final String? perMinutesFare;
  final int? active;

  SingleVehicleModel({
    this.id,
    this.typeId,
    this.name,
    this.code,
    this.mediaUrl,
    this.vehicleCapacity,
    this.minKm,
    this.maxTimeInMinutes,
    this.minFare,
    this.perKmFare,
    this.perMinutesFare,
    this.active,
  });

  factory SingleVehicleModel.fromJson(Map<String, dynamic> json) => SingleVehicleModel(
    id: json["id"],
    typeId: json["type_id"],
    name: json["name"],
    code: json["code"],
    mediaUrl: json["media_url"],
    vehicleCapacity: json["vehicle_capacity"],
    minKm: json["min_km"],
    maxTimeInMinutes: json["max_time_in_minutes"],
    minFare: json["min_fare"],
    perKmFare: json["per_km_fare"],
    perMinutesFare: json["per_minutes_fare"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type_id": typeId,
    "name": name,
    "code": code,
    "media_url": mediaUrl,
    "vehicle_capacity": vehicleCapacity,
    "min_km": minKm,
    "max_time_in_minutes": maxTimeInMinutes,
    "min_fare": minFare,
    "per_km_fare": perKmFare,
    "per_minutes_fare": perMinutesFare,
    "active": active,
  };
}
