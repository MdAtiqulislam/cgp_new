// To parse this JSON data, do
//
//     final wishListModel = wishListModelFromJson(jsonString);

import 'dart:convert';

import 'package:cgp/app/modules/home/models/home_data_model.dart';

import '../../../../models/single_product_model.dart';

WishListModel wishListModelFromJson(String str) => WishListModel.fromJson(json.decode(str));

String wishListModelToJson(WishListModel data) => json.encode(data.toJson());

class WishListModel {
  final String? status;
  final String? message;
  final List<WishListData>? data;

  WishListModel({
    this.status,
    this.message,
    this.data,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<WishListData>.from(json["data"]!.map((x) => WishListData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class WishListData {
  final int? id;
  final DateTime? addedAt;
  final SingleProductModel? product;

  WishListData({
    this.id,
    this.addedAt,
    this.product,
  });

  factory WishListData.fromJson(Map<String, dynamic> json) => WishListData(
    id: json["id"],
    addedAt: json["added_at"] == null ? null : DateTime.parse(json["added_at"]),
    product: json["product"] == null ? null : SingleProductModel.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "added_at": addedAt?.toIso8601String(),
    "product": product?.toJson(),
  };
}

