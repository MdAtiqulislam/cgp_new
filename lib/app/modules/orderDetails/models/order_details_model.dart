
/*
import 'dart:convert';

import 'package:cgp/models/single_address_model.dart';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  final String? status;
  final String? message;
  final OrderDetailsData? data;

  OrderDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : OrderDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class OrderDetailsData {
  final int? orderId;
  final String? totalPrice;
  final String? discount;
  final String? deliveryCharge;
  final String? payableAmount;
  final String? orderType;
  final String? orderStatus;
  final DateTime? createdAt;
  final dynamic updatedAt;
  final OrderDetailsWarehouse? warehouse;
  final SingleAddressModel? billingAddress;
  final SingleAddressModel? pickupAddress;
  final SingleAddressModel? shippingAddress;
  final List<OrderDetailsLineItem>? lineItems;
  final DeliveryInfo? deliveryInfo;

  OrderDetailsData({
    this.orderId,
    this.totalPrice,
    this.discount,
    this.deliveryCharge,
    this.payableAmount,
    this.orderType,
    this.orderStatus,
    this.createdAt,
    this.updatedAt,
    this.warehouse,
    this.billingAddress,
    this.pickupAddress,
    this.shippingAddress,
    this.lineItems,
    this.deliveryInfo,
  });

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) => OrderDetailsData(
    orderId: json["order_id"],
    totalPrice: json["total_price"],
    discount: json["discount"],
    deliveryCharge: json["delivery_charge"],
    payableAmount: json["payable_amount"],
    orderType: json["order_type"],
    orderStatus: json["order_status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    warehouse: json["warehouse"] == null ? null : OrderDetailsWarehouse.fromJson(json["warehouse"]),
    billingAddress: json["billing_address"] == null ? null : SingleAddressModel.fromJson(json["billing_address"]),
    pickupAddress: json["pickup_address"]== null ? null : SingleAddressModel.fromJson(json["pickup_address"]),
    shippingAddress: json["shipping_address"] == null ? null : SingleAddressModel.fromJson(json["shipping_address"]),
    lineItems: json["line_items"] == null ? [] : List<OrderDetailsLineItem>.from(json["line_items"]!.map((x) => OrderDetailsLineItem.fromJson(x))),
    deliveryInfo: json["delivery_info"] == null ? null : DeliveryInfo.fromJson(json["delivery_info"]),
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "total_price": totalPrice,
    "discount": discount,
    "delivery_charge": deliveryCharge,
    "payable_amount": payableAmount,
    "order_type": orderType,
    "order_status": orderStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
    "warehouse": warehouse?.toJson(),
    "billing_address": billingAddress?.toJson(),
    "pickup_address": pickupAddress,
    "shipping_address": shippingAddress?.toJson(),
    "line_items": lineItems == null ? [] : List<dynamic>.from(lineItems!.map((x) => x.toJson())),
    "delivery_info": deliveryInfo?.toJson(),
  };
}

class OrderDetailsLineItem {
  final dynamic name;
  final int? quantity;
  final String? regularPrice;
  final String? salesPrice;
  final dynamic active;
  final dynamic hasOwnProductImg;
  final dynamic unit;
  final dynamic sizeHeight;
  final dynamic sizeWidth;
  final dynamic sizeLength;
  final dynamic weight;
  final dynamic categoryName;
  final dynamic brandName;

  OrderDetailsLineItem({
    this.name,
    this.quantity,
    this.regularPrice,
    this.salesPrice,
    this.active,
    this.hasOwnProductImg,
    this.unit,
    this.sizeHeight,
    this.sizeWidth,
    this.sizeLength,
    this.weight,
    this.categoryName,
    this.brandName,
  });

  factory OrderDetailsLineItem.fromJson(Map<String, dynamic> json) => OrderDetailsLineItem(
    name: json["name"],
    quantity: json["quantity"],
    regularPrice: json["regular_price"],
    salesPrice: json["sales_price"],
    active: json["active"],
    hasOwnProductImg: json["has_own_product_img"],
    unit: json["unit"],
    sizeHeight: json["size_height"],
    sizeWidth: json["size_width"],
    sizeLength: json["size_length"],
    weight: json["weight"],
    categoryName: json["category_name"],
    brandName: json["brand_name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "quantity": quantity,
    "regular_price": regularPrice,
    "sales_price": salesPrice,
    "active": active,
    "has_own_product_img": hasOwnProductImg,
    "unit": unit,
    "size_height": sizeHeight,
    "size_width": sizeWidth,
    "size_length": sizeLength,
    "weight": weight,
    "category_name": categoryName,
    "brand_name": brandName,
  };
}

class OrderDetailsWarehouse {
  final dynamic id;
  final dynamic name;
  final WarehouseBranch? warehouseBranch;

  OrderDetailsWarehouse({
    this.id,
    this.name,
    this.warehouseBranch,
  });

  factory OrderDetailsWarehouse.fromJson(Map<String, dynamic> json) => OrderDetailsWarehouse(
    id: json["id"],
    name: json["name"],
    warehouseBranch: json["warehouse_branch"] == null ? null : WarehouseBranch.fromJson(json["warehouse_branch"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "warehouse_branch": warehouseBranch?.toJson(),
  };
}

class WarehouseBranch {
  final dynamic id;
  final dynamic name;
  final dynamic type;
  final dynamic phone;
  final dynamic address;
  final dynamic postalCode;
  final int? latitude;
  final int? longitude;
  final dynamic contactPersonName;
  final dynamic contactPersonEmail;

  WarehouseBranch({
    this.id,
    this.name,
    this.type,
    this.phone,
    this.address,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.contactPersonName,
    this.contactPersonEmail,
  });

  factory WarehouseBranch.fromJson(Map<String, dynamic> json) => WarehouseBranch(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    phone: json["phone"],
    address: json["address"],
    postalCode: json["postal_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    contactPersonName: json["contact_person_name"],
    contactPersonEmail: json["contact_person_email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "phone": phone,
    "address": address,
    "postal_code": postalCode,
    "latitude": latitude,
    "longitude": longitude,
    "contact_person_name": contactPersonName,
    "contact_person_email": contactPersonEmail,
  };
}

class DeliveryInfo {
  final String? shippingStatus;
  final int? initDistance;
  final int? initDuration;
  final dynamic finalDistance;
  final dynamic finalDuration;
  final dynamic estimatedRemainingDistance;
  final dynamic estimatedRemainingTime;
  final DateTime? acceptedAt;
  final DateTime? pickedUpAt;
  final DateTime? deliveredAt;
  final DateTime? cancelledAt;
  final DateTime? updatedAt;
  final Rider? rider;

  DeliveryInfo({
    this.shippingStatus,
    this.initDistance,
    this.initDuration,
    this.finalDistance,
    this.finalDuration,
    this.estimatedRemainingDistance,
    this.estimatedRemainingTime,
    this.acceptedAt,
    this.pickedUpAt,
    this.deliveredAt,
    this.cancelledAt,
    this.updatedAt,
    this.rider,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) => DeliveryInfo(
    shippingStatus: json["shipping_status"],
    initDistance: json["init_distance"],
    initDuration: json["init_duration"],
    finalDistance: json["final_distance"],
    finalDuration: json["final_duration"],
    estimatedRemainingDistance: json["estimated_remaining_distance"],
    estimatedRemainingTime: json["estimated_remaining_time"],
    acceptedAt: json["accepted_at"] == null ? null : DateTime.parse(json["accepted_at"]),
    pickedUpAt: json["picked_up_at"] == null ? null : DateTime.parse(json["picked_up_at"]),
    deliveredAt: json["delivered_at"] == null ? null : DateTime.parse(json["delivered_at"]),
    cancelledAt: json["cancelled_at"] == null ? null : DateTime.parse(json["cancelled_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    rider: json["rider"] == null ? null : Rider.fromJson(json["rider"]),
  );

  Map<String, dynamic> toJson() => {
    "shipping_status": shippingStatus,
    "init_distance": initDistance,
    "init_duration": initDuration,
    "final_distance": finalDistance,
    "final_duration": finalDuration,
    "estimated_remaining_distance": estimatedRemainingDistance,
    "estimated_remaining_time": estimatedRemainingTime,
    "accepted_at": acceptedAt?.toIso8601String(),
    "picked_up_at": pickedUpAt?.toIso8601String(),
    "delivered_at": deliveredAt?.toIso8601String(),
    "cancelled_at": cancelledAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "rider": rider?.toJson(),
  };
}

class Rider {
  final dynamic id;
  final dynamic name;
  final dynamic email;
  final dynamic phone;
  final dynamic location;
  final dynamic vehicleLicensePlate;

  Rider({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.location,
    this.vehicleLicensePlate
  });

  factory Rider.fromJson(Map<String, dynamic> json) => Rider(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    location: json["location"],
    vehicleLicensePlate: json["vehicle_license_plate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "vehicle_license_plate": vehicleLicensePlate,
    "location": location,
  };
}*/



//

// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:cgp/models/single_address_model.dart';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  final String? status;
  final String? message;
  final OrderDetailsData? data;

  OrderDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : OrderDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class OrderDetailsData {
  final int? orderId;
  final String? totalPrice;
  final String? discount;
  final String? deliveryCharge;
  final String? payableAmount;
  final String? orderType;
  final String? orderStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final OrderDetailsWarehouse? warehouse;
  final SingleAddressModel? billingAddress;
  final SingleAddressModel? pickupAddress;
  final SingleAddressModel? shippingAddress;
  final List<OrderDetailsLineItem>? lineItems;
  final DeliveryInfo? deliveryInfo;
  final Reviews? reviews;
  final List<dynamic>? images;

  OrderDetailsData({
    this.orderId,
    this.totalPrice,
    this.discount,
    this.deliveryCharge,
    this.payableAmount,
    this.orderType,
    this.orderStatus,
    this.createdAt,
    this.updatedAt,
    this.warehouse,
    this.billingAddress,
    this.pickupAddress,
    this.shippingAddress,
    this.lineItems,
    this.deliveryInfo,
    this.reviews,
    this.images
  });

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) => OrderDetailsData(
    orderId: json["order_id"],
    totalPrice: json["total_price"],
    discount: json["discount"],
    deliveryCharge: json["delivery_charge"],
    payableAmount: json["payable_amount"],
    orderType: json["order_type"],
    orderStatus: json["order_status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    warehouse: json["warehouse"] == null ? null : OrderDetailsWarehouse.fromJson(json["warehouse"]),
    billingAddress: json["billing_address"] == null ? null : SingleAddressModel.fromJson(json["billing_address"]),
    pickupAddress: json["pickup_address"] == null ? null : SingleAddressModel.fromJson(json["pickup_address"]),
    shippingAddress: json["shipping_address"] == null ? null : SingleAddressModel.fromJson(json["shipping_address"]),
    lineItems: json["line_items"] == null ? [] : List<OrderDetailsLineItem>.from(json["line_items"]!.map((x) => OrderDetailsLineItem.fromJson(x))),
    images: json["images"],// == null ? [] : List<OrderDetailsLineItem>.from(json["line_items"]!.map((x) => OrderDetailsLineItem.fromJson(x))),
    deliveryInfo: json["delivery_info"] == null ? null : DeliveryInfo.fromJson(json["delivery_info"]),
    reviews: json["reviews"] == null ? null : Reviews.fromJson(json["reviews"]),
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "total_price": totalPrice,
    "discount": discount,
    "delivery_charge": deliveryCharge,
    "payable_amount": payableAmount,
    "order_type": orderType,
    "order_status": orderStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "warehouse": warehouse?.toJson(),
    "billing_address": billingAddress?.toJson(),
    "pickup_address": pickupAddress?.toJson(),
    "shipping_address": shippingAddress?.toJson(),
    "line_items": lineItems == null ? [] : List<dynamic>.from(lineItems!.map((x) => x.toJson())),
    "delivery_info": deliveryInfo?.toJson(),
    "reviews": reviews?.toJson(),
    "images":images,
  };
}

class OrderDetailsLineItem {
  final dynamic name;
  final int? quantity;
  final String? regularPrice;
  final String? salesPrice;
  final dynamic active;
  final dynamic hasOwnProductImg;
  final dynamic unit;
  final dynamic sizeHeight;
  final dynamic sizeWidth;
  final dynamic sizeLength;
  final dynamic weight;
  final dynamic categoryName;
  final dynamic brandName;

  OrderDetailsLineItem({
    this.name,
    this.quantity,
    this.regularPrice,
    this.salesPrice,
    this.active,
    this.hasOwnProductImg,
    this.unit,
    this.sizeHeight,
    this.sizeWidth,
    this.sizeLength,
    this.weight,
    this.categoryName,
    this.brandName,
  });

  factory OrderDetailsLineItem.fromJson(Map<String, dynamic> json) => OrderDetailsLineItem(
    name: json["name"],
    quantity: json["quantity"],
    regularPrice: json["regular_price"],
    salesPrice: json["sales_price"],
    active: json["active"],
    hasOwnProductImg: json["has_own_product_img"],
    unit: json["unit"],
    sizeHeight: json["size_height"],
    sizeWidth: json["size_width"],
    sizeLength: json["size_length"],
    weight: json["weight"],
    categoryName: json["category_name"],
    brandName: json["brand_name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "quantity": quantity,
    "regular_price": regularPrice,
    "sales_price": salesPrice,
    "active": active,
    "has_own_product_img": hasOwnProductImg,
    "unit": unit,
    "size_height": sizeHeight,
    "size_width": sizeWidth,
    "size_length": sizeLength,
    "weight": weight,
    "category_name": categoryName,
    "brand_name": brandName,
  };
}

class OrderDetailsWarehouse {
  final dynamic id;
  final dynamic name;
  final OrderDetailsWarehouseBranch? warehouseBranch;

  OrderDetailsWarehouse({
    this.id,
    this.name,
    this.warehouseBranch,
  });

  factory OrderDetailsWarehouse.fromJson(Map<String, dynamic> json) => OrderDetailsWarehouse(
    id: json["id"],
    name: json["name"],
    warehouseBranch: json["warehouse_branch"] == null ? null : OrderDetailsWarehouseBranch.fromJson(json["warehouse_branch"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "warehouse_branch": warehouseBranch?.toJson(),
  };
}

class OrderDetailsWarehouseBranch {
  final dynamic id;
  final dynamic name;
  final dynamic type;
  final dynamic phone;
  final dynamic address;
  final dynamic postalCode;
  final int? latitude;
  final int? longitude;
  final dynamic contactPersonName;
  final dynamic contactPersonEmail;

  OrderDetailsWarehouseBranch({
    this.id,
    this.name,
    this.type,
    this.phone,
    this.address,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.contactPersonName,
    this.contactPersonEmail,
  });

  factory OrderDetailsWarehouseBranch.fromJson(Map<String, dynamic> json) => OrderDetailsWarehouseBranch(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    phone: json["phone"],
    address: json["address"],
    postalCode: json["postal_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    contactPersonName: json["contact_person_name"],
    contactPersonEmail: json["contact_person_email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "phone": phone,
    "address": address,
    "postal_code": postalCode,
    "latitude": latitude,
    "longitude": longitude,
    "contact_person_name": contactPersonName,
    "contact_person_email": contactPersonEmail,
  };
}


class DeliveryInfo {
  final String? shippingStatus;
  final String? initDistance;
  final String? initDuration;
  final dynamic finalDistance;
  final dynamic finalDuration;
  final dynamic estimatedRemainingDistance;
  final dynamic estimatedRemainingTime;
  final DateTime? createdAt;
  final DateTime? acceptedAt;
  final dynamic reachedPickupPointAt;
  final DateTime? pickedUpAt;
  final dynamic reachedDeliveryPointAt;
  final dynamic deliveredAt;
  final dynamic cancelledAt;
  final DateTime? updatedAt;
  final OrderDetailsRider? rider;

  DeliveryInfo({
    this.shippingStatus,
    this.initDistance,
    this.initDuration,
    this.finalDistance,
    this.finalDuration,
    this.estimatedRemainingDistance,
    this.estimatedRemainingTime,
    this.createdAt,
    this.acceptedAt,
    this.reachedPickupPointAt,
    this.pickedUpAt,
    this.reachedDeliveryPointAt,
    this.deliveredAt,
    this.cancelledAt,
    this.updatedAt,
    this.rider,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) => DeliveryInfo(
    shippingStatus: json["shipping_status"],
    initDistance: json["init_distance"],
    initDuration: json["init_duration"],
    finalDistance: json["final_distance"],
    finalDuration: json["final_duration"],
    estimatedRemainingDistance: json["estimated_remaining_distance"],
    estimatedRemainingTime: json["estimated_remaining_time"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    acceptedAt: json["accepted_at"] == null ? null : DateTime.parse(json["accepted_at"]),
    reachedPickupPointAt: json["reached_pickup_point_at"],
    pickedUpAt: json["picked_up_at"] == null ? null : DateTime.parse(json["picked_up_at"]),
    reachedDeliveryPointAt: json["reached_delivery_point_at"],
    deliveredAt: json["delivered_at"],
    cancelledAt: json["cancelled_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    rider: json["rider"] == null ? null : OrderDetailsRider.fromJson(json["rider"]),
  );

  Map<String, dynamic> toJson() => {
    "shipping_status": shippingStatus,
    "init_distance": initDistance,
    "init_duration": initDuration,
    "final_distance": finalDistance,
    "final_duration": finalDuration,
    "estimated_remaining_distance": estimatedRemainingDistance,
    "estimated_remaining_time": estimatedRemainingTime,
    "created_at": createdAt?.toIso8601String(),
    "accepted_at": acceptedAt?.toIso8601String(),
    "reached_pickup_point_at": reachedPickupPointAt,
    "picked_up_at": pickedUpAt?.toIso8601String(),
    "reached_delivery_point_at": reachedDeliveryPointAt,
    "delivered_at": deliveredAt,
    "cancelled_at": cancelledAt,
    "updated_at": updatedAt?.toIso8601String(),
    "rider": rider?.toJson(),
  };
}

class OrderDetailsRider {
  final int? id;
  final int? userId;
  final String? name;
  final String? url;
  final String? vehicleLicensePlate;
  final String? email;
  final String? phone;
  final Location? location;

  OrderDetailsRider({
    this.id,
    this.userId,
    this.name,
    this.url,
    this.vehicleLicensePlate,
    this.email,
    this.phone,
    this.location,
  });

  factory OrderDetailsRider.fromJson(Map<String, dynamic> json) => OrderDetailsRider(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    url: json["url"],
    vehicleLicensePlate: json["vehicle_license_plate"],
    email: json["email"],
    phone: json["phone"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "url": url,
    "vehicle_license_plate": vehicleLicensePlate,
    "email": email,
    "phone": phone,
    "location": location?.toJson(),
  };
}

class Location {
  final double? latitude;
  final double? longitude;
  final DateTime? updatedAt;

  Location({
    this.latitude,
    this.longitude,
    this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Reviews {
  final Given? given;
  final dynamic received;

  Reviews({
    this.given,
    this.received,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
    given: json["given"] == null ? null : Given.fromJson(json["given"]),
    received: json["received"],
  );

  Map<String, dynamic> toJson() => {
    "given": given?.toJson(),
    "received": received,
  };
}

class Given {
  final int? id;
  final int? rating;
  final String? review;
  final DateTime? createdAt;
  final dynamic updatedAt;

  Given({
    this.id,
    this.rating,
    this.review,
    this.createdAt,
    this.updatedAt,
  });

  factory Given.fromJson(Map<String, dynamic> json) => Given(
    id: json["id"],
    rating: json["rating"],
    review: json["review"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "review": review,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
  };
}

