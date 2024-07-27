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

  AllProductsModel({
    this.status,
    this.message,
    this.data,
  });

  factory AllProductsModel.fromJson(Map<String, dynamic> json) => AllProductsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SingleProductModel>.from(json["data"]!.map((x) => SingleProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

