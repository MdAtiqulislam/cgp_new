// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

import 'package:cgp/app/modules/home/models/home_data_model.dart';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
  final String? message;
  final String? status;
  final List<Category>? data;

  CategoriesModel({
    this.message,
    this.status,
    this.data,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? [] : List<Category>.from(json["data"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}


