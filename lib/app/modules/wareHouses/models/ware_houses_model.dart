// To parse this JSON data, do
//
//     final wareHousesModel = wareHousesModelFromJson(jsonString);

import 'dart:convert';


import '../../../../models/single_warehouse_model.dart';

WareHousesModel wareHousesModelFromJson(String str) => WareHousesModel.fromJson(json.decode(str));

String wareHousesModelToJson(WareHousesModel data) => json.encode(data.toJson());

class WareHousesModel {
  final String? message;
  final String? status;
  final List<SingleWarehouseModel>? data;

  WareHousesModel({
    this.message,
    this.status,
    this.data,
  });

  factory WareHousesModel.fromJson(Map<String, dynamic> json) => WareHousesModel(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleWarehouseModel>.from(json["data"]!.map((x) => SingleWarehouseModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

