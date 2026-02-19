// To parse this JSON data, do
//
//     final transportationCalculationModel = transportationCalculationModelFromJson(jsonString);

import 'dart:convert';

TransportationCalculationModel transportationCalculationModelFromJson(String str) => TransportationCalculationModel.fromJson(json.decode(str));

String transportationCalculationModelToJson(TransportationCalculationModel data) => json.encode(data.toJson());

class TransportationCalculationModel {
  final String? status;
  final String? message;
  final CalculationData? data;

  TransportationCalculationModel({
    this.status,
    this.message,
    this.data,
  });

  factory TransportationCalculationModel.fromJson(Map<String, dynamic> json) => TransportationCalculationModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : CalculationData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class CalculationData {
  final String? vehicleTypeId;
  final String? distance;
  final String? duration;
  final String? baseFare;
  final String? extraMilage;
  final String? extraMinute;
  final String? totalCost;
  final String? gst;
  final String? payableAmount;

  CalculationData({
    this.vehicleTypeId,
    this.distance,
    this.duration,
    this.baseFare,
    this.extraMilage,
    this.extraMinute,
    this.totalCost,
    this.gst,
    this.payableAmount,
  });

  factory CalculationData.fromJson(Map<String, dynamic> json) => CalculationData(
    vehicleTypeId: json["vehicle_type_id"],
    distance: json["distance"],
    duration: json["duration"],
    baseFare: json["base_fare"],
    extraMilage: json["extra_milage"],
    extraMinute: json["extra_minute"],
    totalCost: json["total_cost"],
    gst: json["gst"],
    payableAmount: json["Payable_amount"],
  );

  Map<String, dynamic> toJson() => {
    "vehicle_type_id": vehicleTypeId,
    "distance": distance,
    "duration": duration,
    "base_fare": baseFare,
    "extra_milage": extraMilage,
    "extra_minute": extraMinute,
    "total_cost": totalCost,
    "gst": gst,
    "Payable_amount": payableAmount,
  };
}
