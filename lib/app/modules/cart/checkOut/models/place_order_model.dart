// To parse this JSON data, do
//
//     final placeOrderModel = placeOrderModelFromJson(jsonString);

import 'dart:convert';

PlaceOrderModel placeOrderModelFromJson(String str) => PlaceOrderModel.fromJson(json.decode(str));

String placeOrderModelToJson(PlaceOrderModel data) => json.encode(data.toJson());

class PlaceOrderModel {
  final String? status;
  final String? message;
  final Data? data;

  PlaceOrderModel({
    this.status,
    this.message,
    this.data,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) => PlaceOrderModel(
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
  final int? customerId;
  final String? warehouseId;
  final String? shippingAddressId;
  final String? billingAddressId;
  final String? totalPrice;
  final String? discount;
  final String? vat;
  final String? deliveryCharge;
  final String? payableAmount;
  final dynamic deliveryId;
  final dynamic paymentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? id;
  final String? orderType;
  final String? orderStatus;
  final List<LineItem>? lineItems;

  Data({
    this.customerId,
    this.warehouseId,
    this.shippingAddressId,
    this.billingAddressId,
    this.totalPrice,
    this.discount,
    this.vat,
    this.deliveryCharge,
    this.payableAmount,
    this.deliveryId,
    this.paymentId,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.orderType,
    this.orderStatus,
    this.lineItems,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customerId: json["customer_id"],
    warehouseId: json["warehouse_id"],
    shippingAddressId: json["shipping_address_id"],
    billingAddressId: json["billing_address_id"],
    totalPrice: json["total_price"],
    discount: json["discount"],
    vat: json["vat"],
    deliveryCharge: json["delivery_charge"],
    payableAmount: json["payable_amount"],
    deliveryId: json["delivery_id"],
    paymentId: json["payment_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    id: json["id"],
    orderType: json["order_type"],
    orderStatus: json["order_status"],
    lineItems: json["line_items"] == null ? [] : List<LineItem>.from(json["line_items"]!.map((x) => LineItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "warehouse_id": warehouseId,
    "shipping_address_id": shippingAddressId,
    "billing_address_id": billingAddressId,
    "total_price": totalPrice,
    "discount": discount,
    "vat": vat,
    "delivery_charge": deliveryCharge,
    "payable_amount": payableAmount,
    "delivery_id": deliveryId,
    "payment_id": paymentId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "id": id,
    "order_type": orderType,
    "order_status": orderStatus,
    "line_items": lineItems == null ? [] : List<dynamic>.from(lineItems!.map((x) => x.toJson())),
  };
}

class LineItem {
  final int? orderId;
  final int? productId;
  final int? productQuantity;
  final int? regularPrice;
  final int? salesPrice;
  final int? offerId;
  final dynamic variantId;
  final int? id;

  LineItem({
    this.orderId,
    this.productId,
    this.productQuantity,
    this.regularPrice,
    this.salesPrice,
    this.offerId,
    this.variantId,
    this.id,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
    orderId: json["order_id"],
    productId: json["product_id"],
    productQuantity: json["product_quantity"],
    regularPrice: json["regular_price"],
    salesPrice: json["sales_price"],
    offerId: json["offer_id"],
    variantId: json["variant_id"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "product_id": productId,
    "product_quantity": productQuantity,
    "regular_price": regularPrice,
    "sales_price": salesPrice,
    "offer_id": offerId,
    "variant_id": variantId,
    "id": id,
  };
}
