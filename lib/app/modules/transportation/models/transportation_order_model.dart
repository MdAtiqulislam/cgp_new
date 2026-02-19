// To parse this JSON data, do
//
//     final transportationOrderModel = transportationOrderModelFromJson(jsonString);

import 'dart:convert';

TransportationOrderModel transportationOrderModelFromJson(String str) => TransportationOrderModel.fromJson(json.decode(str));

String transportationOrderModelToJson(TransportationOrderModel data) => json.encode(data.toJson());

class TransportationOrderModel {
  final String? status;
  final String? message;
  final Data? data;

  TransportationOrderModel({
    this.status,
    this.message,
    this.data,
  });

  factory TransportationOrderModel.fromJson(Map<String, dynamic> json) => TransportationOrderModel(
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
  final Order? order;
  final Delivery? delivery;
  final Payment? payment;
  final PaymentIntent? paymentIntent;

  Data({
    this.order,
    this.delivery,
    this.payment,
    this.paymentIntent,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    delivery: json["delivery"] == null ? null : Delivery.fromJson(json["delivery"]),
    payment: json["payment"] == null ? null : Payment.fromJson(json["payment"]),
    paymentIntent: json["PaymentIntent"] == null ? null : PaymentIntent.fromJson(json["PaymentIntent"]),
  );

  Map<String, dynamic> toJson() => {
    "order": order?.toJson(),
    "delivery": delivery?.toJson(),
    "payment": payment?.toJson(),
    "PaymentIntent": paymentIntent?.toJson(),
  };
}

class Delivery {
  final dynamic customerId;
  final dynamic orderId;
  final dynamic initDistance;
  final dynamic initDuration;
  final dynamic deliveryCharge;
  final dynamic riderId;
  final dynamic warehouseId;
  final dynamic vehicleId;
  final dynamic finalDistance;
  final dynamic finalDuration;
  final DateTime? acceptedAt;
  final DateTime? pickedUpAt;
  final DateTime? deliveredAt;
  final DateTime? cancelledAt;
  final DateTime? updatedAt;
  final int? id;
  final String? shippingStatus;

  Delivery({
    this.customerId,
    this.orderId,
    this.initDistance,
    this.initDuration,
    this.deliveryCharge,
    this.riderId,
    this.warehouseId,
    this.vehicleId,
    this.finalDistance,
    this.finalDuration,
    this.acceptedAt,
    this.pickedUpAt,
    this.deliveredAt,
    this.cancelledAt,
    this.updatedAt,
    this.id,
    this.shippingStatus,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
    customerId: json["customer_id"],
    orderId: json["order_id"],
    initDistance: json["init_distance"],
    initDuration: json["init_duration"],
    deliveryCharge: json["delivery_charge"],
    riderId: json["rider_id"],
    warehouseId: json["warehouse_id"],
    vehicleId: json["vehicle_id"],
    finalDistance: json["final_distance"],
    finalDuration: json["final_duration"],
    acceptedAt: json["accepted_at"] == null ? null : DateTime.parse(json["accepted_at"]),
    pickedUpAt: json["picked_up_at"] == null ? null : DateTime.parse(json["picked_up_at"]),
    deliveredAt: json["delivered_at"] == null ? null : DateTime.parse(json["delivered_at"]),
    cancelledAt: json["cancelled_at"] == null ? null : DateTime.parse(json["cancelled_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    id: json["id"],
    shippingStatus: json["shipping_status"],
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "order_id": orderId,
    "init_distance": initDistance,
    "init_duration": initDuration,
    "delivery_charge": deliveryCharge,
    "rider_id": riderId,
    "warehouse_id": warehouseId,
    "vehicle_id": vehicleId,
    "final_distance": finalDistance,
    "final_duration": finalDuration,
    "accepted_at": acceptedAt?.toIso8601String(),
    "picked_up_at": pickedUpAt?.toIso8601String(),
    "delivered_at": deliveredAt?.toIso8601String(),
    "cancelled_at": cancelledAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "id": id,
    "shipping_status": shippingStatus,
  };
}

class Order {
  final int? id;
  final int? customerId;
  final int? pickupAddressId;
  final int? shippingAddressId;
  final dynamic vehicleTypeId;
  final String? totalCost;
  final String? gst;
  final String? payableAmount;
  final String? orderStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Order({
    this.id,
    this.customerId,
    this.pickupAddressId,
    this.shippingAddressId,
    this.vehicleTypeId,
    this.totalCost,
    this.gst,
    this.payableAmount,
    this.orderStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    customerId: json["customer_id"],
    pickupAddressId: json["pickup_address_id"],
    shippingAddressId: json["shipping_address_id"],
    vehicleTypeId: json["vehicle_type_id"],
    totalCost: json["total_cost"],
    gst: json["gst"],
    payableAmount: json["payable_amount"],
    orderStatus: json["order_status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "pickup_address_id": pickupAddressId,
    "shipping_address_id": shippingAddressId,
    "vehicle_type_id": vehicleTypeId,
    "total_cost": totalCost,
    "gst": gst,
    "payable_amount": payableAmount,
    "order_status": orderStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Payment {
  final String? id;
  final String? orderId;
  final String? stripeId;
  final String? paymentStatus;
  final String? paymentBy;
  final dynamic paymentAt;
  final dynamic cancelledAt;
  final DateTime? createdAt;
  final dynamic updatedAt;

  Payment({
    this.id,
    this.orderId,
    this.stripeId,
    this.paymentStatus,
    this.paymentBy,
    this.paymentAt,
    this.cancelledAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["id"],
    orderId: json["order_id"],
    stripeId: json["stripe_id"],
    paymentStatus: json["payment_status"],
    paymentBy: json["payment_by"],
    paymentAt: json["payment_at"],
    cancelledAt: json["cancelled_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "stripe_id": stripeId,
    "payment_status": paymentStatus,
    "payment_by": paymentBy,
    "payment_at": paymentAt,
    "cancelled_at": cancelledAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
  };
}

class PaymentIntent {
  final String? id;
  final String? object;
  final int? amount;
  final int? amountCapturable;
  final AmountDetails? amountDetails;
  final int? amountReceived;
  final dynamic application;
  final dynamic applicationFeeAmount;
  final AutomaticPaymentMethods? automaticPaymentMethods;
  final dynamic canceledAt;
  final dynamic cancellationReason;
  final String? captureMethod;
  final String? clientSecret;
  final String? confirmationMethod;
  final int? created;
  final String? currency;
  final String? customer;
  final dynamic description;
  final dynamic invoice;
  final dynamic lastPaymentError;
  final dynamic latestCharge;
  final bool? livemode;
  final Metadata? metadata;
  final dynamic nextAction;
  final dynamic onBehalfOf;
  final dynamic paymentMethod;
  final dynamic paymentMethodConfigurationDetails;
  final PaymentMethodOptions? paymentMethodOptions;
  final List<String>? paymentMethodTypes;
  final dynamic processing;
  final dynamic receiptEmail;
  final dynamic review;
  final dynamic setupFutureUsage;
  final Shipping? shipping;
  final dynamic source;
  final dynamic statementDescriptor;
  final dynamic statementDescriptorSuffix;
  final String? status;
  final dynamic transferData;
  final dynamic transferGroup;

  PaymentIntent({
    this.id,
    this.object,
    this.amount,
    this.amountCapturable,
    this.amountDetails,
    this.amountReceived,
    this.application,
    this.applicationFeeAmount,
    this.automaticPaymentMethods,
    this.canceledAt,
    this.cancellationReason,
    this.captureMethod,
    this.clientSecret,
    this.confirmationMethod,
    this.created,
    this.currency,
    this.customer,
    this.description,
    this.invoice,
    this.lastPaymentError,
    this.latestCharge,
    this.livemode,
    this.metadata,
    this.nextAction,
    this.onBehalfOf,
    this.paymentMethod,
    this.paymentMethodConfigurationDetails,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.processing,
    this.receiptEmail,
    this.review,
    this.setupFutureUsage,
    this.shipping,
    this.source,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    this.status,
    this.transferData,
    this.transferGroup,
  });

  factory PaymentIntent.fromJson(Map<String, dynamic> json) => PaymentIntent(
    id: json["id"],
    object: json["object"],
    amount: json["amount"],
    amountCapturable: json["amount_capturable"],
    amountDetails: json["amount_details"] == null ? null : AmountDetails.fromJson(json["amount_details"]),
    amountReceived: json["amount_received"],
    application: json["application"],
    applicationFeeAmount: json["application_fee_amount"],
    automaticPaymentMethods: json["automatic_payment_methods"] == null ? null : AutomaticPaymentMethods.fromJson(json["automatic_payment_methods"]),
    canceledAt: json["canceled_at"],
    cancellationReason: json["cancellation_reason"],
    captureMethod: json["capture_method"],
    clientSecret: json["client_secret"],
    confirmationMethod: json["confirmation_method"],
    created: json["created"],
    currency: json["currency"],
    customer: json["customer"],
    description: json["description"],
    invoice: json["invoice"],
    lastPaymentError: json["last_payment_error"],
    latestCharge: json["latest_charge"],
    livemode: json["livemode"],
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
    nextAction: json["next_action"],
    onBehalfOf: json["on_behalf_of"],
    paymentMethod: json["payment_method"],
    paymentMethodConfigurationDetails: json["payment_method_configuration_details"],
    paymentMethodOptions: json["payment_method_options"] == null ? null : PaymentMethodOptions.fromJson(json["payment_method_options"]),
    paymentMethodTypes: json["payment_method_types"] == null ? [] : List<String>.from(json["payment_method_types"]!.map((x) => x)),
    processing: json["processing"],
    receiptEmail: json["receipt_email"],
    review: json["review"],
    setupFutureUsage: json["setup_future_usage"],
    shipping: json["shipping"] == null ? null : Shipping.fromJson(json["shipping"]),
    source: json["source"],
    statementDescriptor: json["statement_descriptor"],
    statementDescriptorSuffix: json["statement_descriptor_suffix"],
    status: json["status"],
    transferData: json["transfer_data"],
    transferGroup: json["transfer_group"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "amount": amount,
    "amount_capturable": amountCapturable,
    "amount_details": amountDetails?.toJson(),
    "amount_received": amountReceived,
    "application": application,
    "application_fee_amount": applicationFeeAmount,
    "automatic_payment_methods": automaticPaymentMethods?.toJson(),
    "canceled_at": canceledAt,
    "cancellation_reason": cancellationReason,
    "capture_method": captureMethod,
    "client_secret": clientSecret,
    "confirmation_method": confirmationMethod,
    "created": created,
    "currency": currency,
    "customer": customer,
    "description": description,
    "invoice": invoice,
    "last_payment_error": lastPaymentError,
    "latest_charge": latestCharge,
    "livemode": livemode,
    "metadata": metadata?.toJson(),
    "next_action": nextAction,
    "on_behalf_of": onBehalfOf,
    "payment_method": paymentMethod,
    "payment_method_configuration_details": paymentMethodConfigurationDetails,
    "payment_method_options": paymentMethodOptions?.toJson(),
    "payment_method_types": paymentMethodTypes == null ? [] : List<dynamic>.from(paymentMethodTypes!.map((x) => x)),
    "processing": processing,
    "receipt_email": receiptEmail,
    "review": review,
    "setup_future_usage": setupFutureUsage,
    "shipping": shipping?.toJson(),
    "source": source,
    "statement_descriptor": statementDescriptor,
    "statement_descriptor_suffix": statementDescriptorSuffix,
    "status": status,
    "transfer_data": transferData,
    "transfer_group": transferGroup,
  };
}

class AmountDetails {
  final Tip? tip;

  AmountDetails({
    this.tip,
  });

  factory AmountDetails.fromJson(Map<String, dynamic> json) => AmountDetails(
    tip: json["tip"] == null ? null : Tip.fromJson(json["tip"]),
  );

  Map<String, dynamic> toJson() => {
    "tip": tip?.toJson(),
  };
}

class Tip {
  Tip();

  factory Tip.fromJson(Map<String, dynamic> json) => Tip(
  );

  Map<String, dynamic> toJson() => {
  };
}

class AutomaticPaymentMethods {
  final String? allowRedirects;
  final bool? enabled;

  AutomaticPaymentMethods({
    this.allowRedirects,
    this.enabled,
  });

  factory AutomaticPaymentMethods.fromJson(Map<String, dynamic> json) => AutomaticPaymentMethods(
    allowRedirects: json["allow_redirects"],
    enabled: json["enabled"],
  );

  Map<String, dynamic> toJson() => {
    "allow_redirects": allowRedirects,
    "enabled": enabled,
  };
}

class Metadata {
  final String? pickupAddressCoordinates;
  final String? shippingAddressCoordinates;

  Metadata({
    this.pickupAddressCoordinates,
    this.shippingAddressCoordinates,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    pickupAddressCoordinates: json["pickup_address_coordinates"],
    shippingAddressCoordinates: json["shipping_address_coordinates"],
  );

  Map<String, dynamic> toJson() => {
    "pickup_address_coordinates": pickupAddressCoordinates,
    "shipping_address_coordinates": shippingAddressCoordinates,
  };
}

class PaymentMethodOptions {
  final Card? card;

  PaymentMethodOptions({
    this.card,
  });

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) => PaymentMethodOptions(
    card: json["card"] == null ? null : Card.fromJson(json["card"]),
  );

  Map<String, dynamic> toJson() => {
    "card": card?.toJson(),
  };
}

class Card {
  final dynamic installments;
  final dynamic mandateOptions;
  final dynamic network;
  final String? requestThreeDSecure;

  Card({
    this.installments,
    this.mandateOptions,
    this.network,
    this.requestThreeDSecure,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    installments: json["installments"],
    mandateOptions: json["mandate_options"],
    network: json["network"],
    requestThreeDSecure: json["request_three_d_secure"],
  );

  Map<String, dynamic> toJson() => {
    "installments": installments,
    "mandate_options": mandateOptions,
    "network": network,
    "request_three_d_secure": requestThreeDSecure,
  };
}

class Shipping {
  final Address? address;
  final String? carrier;
  final String? name;
  final dynamic phone;
  final dynamic trackingNumber;

  Shipping({
    this.address,
    this.carrier,
    this.name,
    this.phone,
    this.trackingNumber,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    carrier: json["carrier"],
    name: json["name"],
    phone: json["phone"],
    trackingNumber: json["tracking_number"],
  );

  Map<String, dynamic> toJson() => {
    "address": address?.toJson(),
    "carrier": carrier,
    "name": name,
    "phone": phone,
    "tracking_number": trackingNumber,
  };
}

class Address {
  final dynamic city;
  final dynamic country;
  final dynamic line1;
  final dynamic line2;
  final String? postalCode;
  final String? state;

  Address({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.postalCode,
    this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    city: json["city"],
    country: json["country"],
    line1: json["line1"],
    line2: json["line2"],
    postalCode: json["postal_code"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "country": country,
    "line1": line1,
    "line2": line2,
    "postal_code": postalCode,
    "state": state,
  };
}
