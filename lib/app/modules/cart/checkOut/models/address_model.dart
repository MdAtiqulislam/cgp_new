// To parse this JSON data, do
//
//     final addressListModel = addressListModelFromJson(jsonString);

import 'dart:convert';

import '../../../../../models/single_address_model.dart';

AddressListModel addressListModelFromJson(String str) => AddressListModel.fromJson(json.decode(str));

String addressListModelToJson(AddressListModel data) => json.encode(data.toJson());

class AddressListModel {
  final String? status;
  final String? message;
  final List<SingleAddressModel>? data;

  AddressListModel({
    this.status,
    this.message,
    this.data,
  });

  factory AddressListModel.fromJson(Map<String, dynamic> json) => AddressListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SingleAddressModel>.from(json["data"]!.map((x) => SingleAddressModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

