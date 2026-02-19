// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) => NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) => json.encode(data.toJson());

class NotificationsModel {
  final String? status;
  final String? message;
  final List<SingleNotificationModel>? data;

  NotificationsModel({
    this.status,
    this.message,
    this.data,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SingleNotificationModel>.from(json["data"]!.map((x) => SingleNotificationModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleNotificationModel {
  final String? id;
  final List<String>? deviceTokens;
  final int? userId;
  final String? title;
  final String? message;
  final NotificationData? data;
  final bool? isRead;
  final DateTime? createdAt;
  final int? v;

  SingleNotificationModel({
    this.id,
    this.deviceTokens,
    this.userId,
    this.title,
    this.message,
    this.data,
    this.isRead,
    this.createdAt,
    this.v,
  });

  factory SingleNotificationModel.fromJson(Map<String, dynamic> json) => SingleNotificationModel(
    id: json["_id"],
    deviceTokens: json["deviceTokens"] == null ? [] : List<String>.from(json["deviceTokens"]!.map((x) => x)),
    userId: json["userId"],
    title: json["title"],
    message: json["message"],
    data: json["data"] == null ? null : NotificationData.fromJson(json["data"]),
    isRead: json["isRead"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "deviceTokens": deviceTokens == null ? [] : List<dynamic>.from(deviceTokens!.map((x) => x)),
    "userId": userId,
    "title": title,
    "message": message,
    "data": data?.toJson(),
    "isRead": isRead,
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
  };
}

class NotificationData {
  final String? type;
  final String? orderId;
  final String? deliveryId;
  final String? deliveryUserId;
  final String? deliveryUserName;
  final String? target;
  final dynamic customerId;

  NotificationData({
    this.type,
    this.orderId,
    this.deliveryId,
    this.deliveryUserId,
    this.deliveryUserName,
    this.target,
    this.customerId,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    type: json["type"],
    orderId: json["orderId"],
    deliveryId: json["deliveryId"],
    deliveryUserId: json["deliveryUserId"],
    deliveryUserName: json["deliveryUserName"],
    target:json["target"],
    customerId: json["customerId"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "orderId": orderId,
    "deliveryId": deliveryId,
    "deliveryUserId": deliveryUserId,
    "deliveryUserName": deliveryUserName,
    "target": target,
    "customerId": customerId,
  };
}

