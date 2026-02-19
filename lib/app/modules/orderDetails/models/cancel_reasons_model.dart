// To parse this JSON data, do
//
//     final cancelReasonsModel = cancelReasonsModelFromJson(jsonString);

import 'dart:convert';

import '../../../../models/cancel_reason_model.dart';

CancelReasonsModel cancelReasonsModelFromJson(String str) => CancelReasonsModel.fromJson(json.decode(str));

String cancelReasonsModelToJson(CancelReasonsModel data) => json.encode(data.toJson());

class CancelReasonsModel {
  final String? status;
  final String? message;
  final List<CancelReasonModel>? data;

  CancelReasonsModel({
    this.status,
    this.message,
    this.data,
  });

  factory CancelReasonsModel.fromJson(Map<String, dynamic> json) => CancelReasonsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CancelReasonModel>.from(json["data"]!.map((x) => CancelReasonModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}


