
import 'dart:convert';

import 'package:cgp/models/customer_model.dart';

LoggedInCustomerProfileModel loggedInCustomerProfileModelFromJson(String str) => LoggedInCustomerProfileModel.fromJson(json.decode(str));

String loggedInCustomerProfileModelToJson(LoggedInCustomerProfileModel data) => json.encode(data.toJson());

class LoggedInCustomerProfileModel {
  final String? status;
  final String? message;
  final CustomerModel? data;

  LoggedInCustomerProfileModel({
    this.status,
    this.message,
    this.data,
  });

  factory LoggedInCustomerProfileModel.fromJson(Map<String, dynamic> json) => LoggedInCustomerProfileModel(
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

