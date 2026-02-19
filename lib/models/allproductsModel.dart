// To parse this JSON data, do
//
//     final allProductsModel = allProductsModelFromJson(jsonString);

import 'dart:convert';
import 'package:cgp/models/single_product_model.dart';

AllProductsModel allProductsModelFromJson(String str) => AllProductsModel.fromJson(json.decode(str));

String allProductsModelToJson(AllProductsModel data) => json.encode(data.toJson());

class AllProductsModel {
  final String? status;
  final String? message;
  final List<SingleProductModel>? data;
  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;

  AllProductsModel({
    this.status,
    this.message,
    this.data,
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  factory AllProductsModel.fromJson(Map<String, dynamic> json) => AllProductsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SingleProductModel>.from(json["data"]!.map((x) => SingleProductModel.fromJson(x))),
    total: json["total"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "total":total,
    "per_page":perPage,
    "current_page":currentPage,
    "last_page":lastPage,
  };
}

