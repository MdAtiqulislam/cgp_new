// To parse this JSON data, do
//
//     final similarProductsModel = similarProductsModelFromJson(jsonString);

import 'dart:convert';
import '../../../../models/single_product_model.dart';

SimilarProductsModel similarProductsModelFromJson(String str) => SimilarProductsModel.fromJson(json.decode(str));

String similarProductsModelToJson(SimilarProductsModel data) => json.encode(data.toJson());

class SimilarProductsModel {
  final String? message;
  final String? status;
  final List<SingleProductModel>? data;

  SimilarProductsModel({
    this.message,
    this.status,
    this.data,
  });

  factory SimilarProductsModel.fromJson(Map<String, dynamic> json) => SimilarProductsModel(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleProductModel>.from(json["data"]!.map((x) => SingleProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

