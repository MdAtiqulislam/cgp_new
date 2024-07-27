
import 'dart:convert';

import '../../../../models/order_history_single_order_model.dart';

OrderHistoryModel orderHistoryModelFromJson(String str) => OrderHistoryModel.fromJson(json.decode(str));

String orderHistoryModelToJson(OrderHistoryModel data) => json.encode(data.toJson());

class OrderHistoryModel {
  final String? status;
  final String? message;
  final List<SingleOrderModel>? data;

  OrderHistoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) => OrderHistoryModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SingleOrderModel>.from(json["data"]!.map((x) => SingleOrderModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}



