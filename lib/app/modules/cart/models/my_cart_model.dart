// To parse this JSON data, do
//
//     final myCartModel = myCartModelFromJson(jsonString);

import 'dart:convert';

import '../../../../models/single_product_model.dart';


MyCartModel myCartModelFromJson(String str) => MyCartModel.fromJson(json.decode(str));

String myCartModelToJson(MyCartModel data) => json.encode(data.toJson());

class MyCartModel {
  final String? status;
  final String? message;
  final List<SingleCartModel>? data;

  MyCartModel({
    this.status,
    this.message,
    this.data,
  });

  factory MyCartModel.fromJson(Map<String, dynamic> json) => MyCartModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SingleCartModel>.from(json["data"]!.map((x) => SingleCartModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleCartModel {
  final int? id;
  final int? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final SingleProductModel? product;

  SingleCartModel({
    this.id,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory SingleCartModel.fromJson(Map<String, dynamic> json) => SingleCartModel(
    id: json["id"],
    quantity: json["quantity"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    product: json["product"] == null ? null : SingleProductModel.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "product": product?.toJson(),
  };
}

