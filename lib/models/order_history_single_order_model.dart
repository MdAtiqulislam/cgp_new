class SingleOrderModel {
  final int? id;
  final dynamic orderType;
  final dynamic orderStatus;
  final int? customerId;
  final int? warehouseId;
  final int? billingAddressId;
  final int? pickupAddressId;
  final int? shippingAddressId;
  final int? vehicleTypeId;
  final dynamic paymentId;
  final String? distanceInKm;
  final int? durationInMin;
  final String? totalCost;
  final String? discount;
  final String? gst;
  final String? deliveryCharge;
  final String? payableAmount;
  final DateTime? createdAt;
  final DateTime? acceptedAt;
  final DateTime? cancelledAt;
  final DateTime? updatedAt;

  SingleOrderModel({
    this.id,
    this.orderType,
    this.orderStatus,
    this.customerId,
    this.warehouseId,
    this.billingAddressId,
    this.pickupAddressId,
    this.shippingAddressId,
    this.vehicleTypeId,
    this.paymentId,
    this.distanceInKm,
    this.durationInMin,
    this.totalCost,
    this.discount,
    this.gst,
    this.deliveryCharge,
    this.payableAmount,
    this.createdAt,
    this.acceptedAt,
    this.cancelledAt,
    this.updatedAt,
  });

  factory SingleOrderModel.fromJson(Map<String, dynamic> json) => SingleOrderModel(
    id: json["id"],
    orderType: json["order_type"],
    orderStatus: json["order_status"],
    customerId: json["customer_id"],
    warehouseId: json["warehouse_id"],
    billingAddressId: json["billing_address_id"],
    pickupAddressId: json["pickup_address_id"],
    shippingAddressId: json["shipping_address_id"],
    vehicleTypeId: json["vehicle_type_id"],
    paymentId: json["payment_id"],
    distanceInKm: json["distance_in_km"],
    durationInMin: json["duration_in_min"],
    totalCost: json["total_cost"],
    discount: json["discount"],
    gst: json["gst"],
    deliveryCharge: json["delivery_charge"],
    payableAmount: json["payable_amount"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    acceptedAt: json["accepted_at"] == null ? null : DateTime.parse(json["accepted_at"]),
    cancelledAt: json["cancelled_at"] == null ? null : DateTime.parse(json["cancelled_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_type": orderType,
    "order_status": orderStatus,
    "customer_id": customerId,
    "warehouse_id": warehouseId,
    "billing_address_id": billingAddressId,
    "pickup_address_id": pickupAddressId,
    "shipping_address_id": shippingAddressId,
    "vehicle_type_id": vehicleTypeId,
    "payment_id": paymentId,
    "distance_in_km": distanceInKm,
    "duration_in_min": durationInMin,
    "total_cost": totalCost,
    "discount": discount,
    "gst": gst,
    "delivery_charge": deliveryCharge,
    "payable_amount": payableAmount,
    "created_at": createdAt?.toIso8601String(),
    "accepted_at": acceptedAt?.toIso8601String(),
    "cancelled_at": cancelledAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}