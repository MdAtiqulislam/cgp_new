// To parse this JSON data, do
//
//     final ongoingOrderModel = ongoingOrderModelFromJson(jsonString);

import 'dart:convert';

OngoingOrderModel ongoingOrderModelFromJson(String str) => OngoingOrderModel.fromJson(json.decode(str));

String ongoingOrderModelToJson(OngoingOrderModel data) => json.encode(data.toJson());

class OngoingOrderModel {
  final String? status;
  final String? message;
  final OngoingOrderData? data;

  OngoingOrderModel({
    this.status,
    this.message,
    this.data,
  });

  factory OngoingOrderModel.fromJson(Map<String, dynamic> json) => OngoingOrderModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : OngoingOrderData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class OngoingOrderData {
  final String? id;
  final int? orderId;
  final int? deliveryId;
  final String? shippingStatus;
  final String? title;
  final String? message;
  final String? distance;
  final String? duration;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  OngoingOrderData({
    this.id,
    this.orderId,
    this.deliveryId,
    this.shippingStatus,
    this.title,
    this.message,
    this.distance,
    this.duration,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory OngoingOrderData.fromJson(Map<String, dynamic> json) => OngoingOrderData(
    id: json["_id"],
    orderId: json["orderId"],
    deliveryId: json["deliveryId"],
    shippingStatus: json["shippingStatus"],
    title: json["title"],
    message: json["message"],
    distance: json["distance"],
    duration: json["duration"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "orderId": orderId,
    "deliveryId": deliveryId,
    "shippingStatus": shippingStatus,
    "title": title,
    "message": message,
    "distance": distance,
    "duration": duration,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
