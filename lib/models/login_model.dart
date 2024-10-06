
/*
import 'dart:convert';

import 'customer_model.dart';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String? status;
  final String? message;
  final Data? data;

  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final CustomerModel? customer;
  final String? accessToken;

  Data({
    this.customer,
    this.accessToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customer: json["customer"] == null ? null : CustomerModel.fromJson(json["customer"]),
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "customer": customer?.toJson(),
    "access_token": accessToken,
  };
}

 */

// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

import 'customer_model.dart';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String? status;
  final String? message;
  final Data? data;

  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final CustomerModel? customer;
  final String? accessToken;

  Data({
    this.customer,
    this.accessToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customer: json["customer"] == null ? null : CustomerModel.fromJson(json["customer"]),
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "customer": customer?.toJson(),
    "access_token": accessToken,
  };
}


