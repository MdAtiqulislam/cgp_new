// To parse this JSON data, do
//
//     final wareHousesModel = wareHousesModelFromJson(jsonString);


/*
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

*/
// To parse this JSON data, do
//
//     final warehouseBranchesModel = warehouseBranchesModelFromJson(jsonString);

import 'dart:convert';

import 'package:cgp/models/single_warehouse_branch_model.dart';

WarehouseBranchesModel warehouseBranchesModelFromJson(String str) => WarehouseBranchesModel.fromJson(json.decode(str));

String warehouseBranchesModelToJson(WarehouseBranchesModel data) => json.encode(data.toJson());

class WarehouseBranchesModel {
  final String? status;
  final String? message;
  final List<SingleWarehouseBranchModel>? data;
  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;

  WarehouseBranchesModel({
    this.status,
    this.message,
    this.data,
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  factory WarehouseBranchesModel.fromJson(Map<String, dynamic> json) => WarehouseBranchesModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SingleWarehouseBranchModel>.from(json["data"]!.map((x) => SingleWarehouseBranchModel.fromJson(x))),
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
