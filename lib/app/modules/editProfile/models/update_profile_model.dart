// To parse this JSON data, do
//
//     final customerProfileUpdateModel = customerProfileUpdateModelFromJson(jsonString);

import 'dart:convert';

import 'package:cgp/models/customer_model.dart';

CustomerProfileUpdateModel customerProfileUpdateModelFromJson(String str) => CustomerProfileUpdateModel.fromJson(json.decode(str));

String customerProfileUpdateModelToJson(CustomerProfileUpdateModel data) => json.encode(data.toJson());

class CustomerProfileUpdateModel {
  final String? status;
  final String? message;
  final CustomerModel? data;

  CustomerProfileUpdateModel({
    this.status,
    this.message,
    this.data,
  });

  factory CustomerProfileUpdateModel.fromJson(Map<String, dynamic> json) => CustomerProfileUpdateModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : CustomerModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}
