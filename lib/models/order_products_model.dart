// To parse this JSON data, do
//
//     final orderProductsModel = orderProductsModelFromJson(jsonString);

import 'dart:convert';

OrderProductsModel orderProductsModelFromJson(String str) => OrderProductsModel.fromJson(json.decode(str));

String orderProductsModelToJson(OrderProductsModel data) => json.encode(data.toJson());

class OrderProductsModel {
  final int? productId;
  final int? offerId;
  final int? quantity;
  final int? regularPrice;
  final int? salesPrice;

  OrderProductsModel({
    this.productId,
    this.offerId,
    this.quantity,
    this.regularPrice,
    this.salesPrice,
  });

  factory OrderProductsModel.fromJson(Map<String, dynamic> json) => OrderProductsModel(
    productId: json["product_id"],
    offerId: json["offer_id"],
    quantity: json["quantity"],
    regularPrice: json["regular_price"],
    salesPrice: json["sales_price"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "offer_id": offerId,
    "quantity": quantity,
    "regular_price": regularPrice,
    "sales_price": salesPrice,
  };
}
