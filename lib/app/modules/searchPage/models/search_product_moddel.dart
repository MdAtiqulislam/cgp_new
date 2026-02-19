// To parse this JSON data, do
//
//     final searchProductModel = searchProductModelFromJson(jsonString);

import 'dart:convert';

import '../../../../models/single_product_model.dart';


SearchProductModel searchProductModelFromJson(String str) => SearchProductModel.fromJson(json.decode(str));

String searchProductModelToJson(SearchProductModel data) => json.encode(data.toJson());

class SearchProductModel {
  final String? message;
  final String? status;
  final Data? data;

  SearchProductModel({
    this.message,
    this.status,
    this.data,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) => SearchProductModel(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  final List<SingleProductModel>? products;

  Data({
    this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products: json["products"] == null ? [] : List<SingleProductModel>.from(json["products"]!.map((x) => SingleProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

