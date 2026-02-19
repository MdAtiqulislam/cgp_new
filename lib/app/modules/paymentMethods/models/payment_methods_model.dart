// To parse this JSON data, do
//
//     final paymentMethodListModel = paymentMethodListModelFromJson(jsonString);

import 'dart:convert';

PaymentMethodListModel paymentMethodListModelFromJson(String str) => PaymentMethodListModel.fromJson(json.decode(str));

String paymentMethodListModelToJson(PaymentMethodListModel data) => json.encode(data.toJson());

class PaymentMethodListModel {
  final String? status;
  final String? message;
  final AllData? data;

  PaymentMethodListModel({
    this.status,
    this.message,
    this.data,
  });

  factory PaymentMethodListModel.fromJson(Map<String, dynamic> json) => PaymentMethodListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : AllData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class AllData {
  final PaymentMethodList? paymentMethodList;
  final Customer? customer;

  AllData({
    this.paymentMethodList,
    this.customer,
  });

  factory AllData.fromJson(Map<String, dynamic> json) => AllData(
    paymentMethodList: json["paymentMethodList"] == null ? null : PaymentMethodList.fromJson(json["paymentMethodList"]),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "paymentMethodList": paymentMethodList?.toJson(),
    "customer": customer?.toJson(),
  };
}

class Customer {
  final String? id;
  final String? object;
  final dynamic address;
  final int? balance;
  final int? created;
  final dynamic currency;
  final dynamic defaultSource;
  final bool? delinquent;
  final dynamic description;
  final dynamic discount;
  final String? email;
  final String? invoicePrefix;
  final InvoiceSettings? invoiceSettings;
  final bool? livemode;
  final Metadata? metadata;
  final dynamic name;
  final int? nextInvoiceSequence;
  final dynamic phone;
  final List<dynamic>? preferredLocales;
  final dynamic shipping;
  final String? taxExempt;
  final dynamic testClock;

  Customer({
    this.id,
    this.object,
    this.address,
    this.balance,
    this.created,
    this.currency,
    this.defaultSource,
    this.delinquent,
    this.description,
    this.discount,
    this.email,
    this.invoicePrefix,
    this.invoiceSettings,
    this.livemode,
    this.metadata,
    this.name,
    this.nextInvoiceSequence,
    this.phone,
    this.preferredLocales,
    this.shipping,
    this.taxExempt,
    this.testClock,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    object: json["object"],
    address: json["address"],
    balance: json["balance"],
    created: json["created"],
    currency: json["currency"],
    defaultSource: json["default_source"],
    delinquent: json["delinquent"],
    description: json["description"],
    discount: json["discount"],
    email: json["email"],
    invoicePrefix: json["invoice_prefix"],
    invoiceSettings: json["invoice_settings"] == null ? null : InvoiceSettings.fromJson(json["invoice_settings"]),
    livemode: json["livemode"],
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
    name: json["name"],
    nextInvoiceSequence: json["next_invoice_sequence"],
    phone: json["phone"],
    preferredLocales: json["preferred_locales"] == null ? [] : List<dynamic>.from(json["preferred_locales"]!.map((x) => x)),
    shipping: json["shipping"],
    taxExempt: json["tax_exempt"],
    testClock: json["test_clock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "address": address,
    "balance": balance,
    "created": created,
    "currency": currency,
    "default_source": defaultSource,
    "delinquent": delinquent,
    "description": description,
    "discount": discount,
    "email": email,
    "invoice_prefix": invoicePrefix,
    "invoice_settings": invoiceSettings?.toJson(),
    "livemode": livemode,
    "metadata": metadata?.toJson(),
    "name": name,
    "next_invoice_sequence": nextInvoiceSequence,
    "phone": phone,
    "preferred_locales": preferredLocales == null ? [] : List<dynamic>.from(preferredLocales!.map((x) => x)),
    "shipping": shipping,
    "tax_exempt": taxExempt,
    "test_clock": testClock,
  };
}

class InvoiceSettings {
  final dynamic customFields;
  final String? defaultPaymentMethod;
  final dynamic footer;
  final dynamic renderingOptions;

  InvoiceSettings({
    this.customFields,
    this.defaultPaymentMethod,
    this.footer,
    this.renderingOptions,
  });

  factory InvoiceSettings.fromJson(Map<String, dynamic> json) => InvoiceSettings(
    customFields: json["custom_fields"],
    defaultPaymentMethod: json["default_payment_method"],
    footer: json["footer"],
    renderingOptions: json["rendering_options"],
  );

  Map<String, dynamic> toJson() => {
    "custom_fields": customFields,
    "default_payment_method": defaultPaymentMethod,
    "footer": footer,
    "rendering_options": renderingOptions,
  };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
  );

  Map<String, dynamic> toJson() => {
  };
}

class PaymentMethodList {
  final String? object;
  final List<SinglePaymentMethod>? data;
  final bool? hasMore;
  final String? url;

  PaymentMethodList({
    this.object,
    this.data,
    this.hasMore,
    this.url,
  });

  factory PaymentMethodList.fromJson(Map<String, dynamic> json) => PaymentMethodList(
    object: json["object"],
    data: json["data"] == null ? [] : List<SinglePaymentMethod>.from(json["data"]!.map((x) => SinglePaymentMethod.fromJson(x))),
    hasMore: json["has_more"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "object": object,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "has_more": hasMore,
    "url": url,
  };
}

class SinglePaymentMethod {
  final String? id;
  final String? object;
  final String? allowRedisplay;
  final BillingDetails? billingDetails;
  final Card? card;
  final int? created;
  final String? customer;
  final bool? livemode;
  final Metadata? metadata;
  final String? type;

  SinglePaymentMethod({
    this.id,
    this.object,
    this.allowRedisplay,
    this.billingDetails,
    this.card,
    this.created,
    this.customer,
    this.livemode,
    this.metadata,
    this.type,
  });

  factory SinglePaymentMethod.fromJson(Map<String, dynamic> json) => SinglePaymentMethod(
    id: json["id"],
    object: json["object"],
    allowRedisplay: json["allow_redisplay"],
    billingDetails: json["billing_details"] == null ? null : BillingDetails.fromJson(json["billing_details"]),
    card: json["card"] == null ? null : Card.fromJson(json["card"]),
    created: json["created"],
    customer: json["customer"],
    livemode: json["livemode"],
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "allow_redisplay": allowRedisplay,
    "billing_details": billingDetails?.toJson(),
    "card": card?.toJson(),
    "created": created,
    "customer": customer,
    "livemode": livemode,
    "metadata": metadata?.toJson(),
    "type": type,
  };
}

class BillingDetails {
  final Address? address;
  final dynamic email;
  final dynamic name;
  final dynamic phone;

  BillingDetails({
    this.address,
    this.email,
    this.name,
    this.phone,
  });

  factory BillingDetails.fromJson(Map<String, dynamic> json) => BillingDetails(
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    email: json["email"],
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "address": address?.toJson(),
    "email": email,
    "name": name,
    "phone": phone,
  };
}

class Address {
  final dynamic city;
  final dynamic country;
  final dynamic line1;
  final dynamic line2;
  final dynamic postalCode;
  final dynamic state;

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

class Card {
  final String? brand;
  final Checks? checks;
  final String? country;
  final String? displayBrand;
  final int? expMonth;
  final int? expYear;
  final String? fingerprint;
  final String? funding;
  final dynamic generatedFrom;
  final String? last4;
  final Networks? networks;
  final ThreeDSecureUsage? threeDSecureUsage;
  final dynamic wallet;

  Card({
    this.brand,
    this.checks,
    this.country,
    this.displayBrand,
    this.expMonth,
    this.expYear,
    this.fingerprint,
    this.funding,
    this.generatedFrom,
    this.last4,
    this.networks,
    this.threeDSecureUsage,
    this.wallet,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    brand: json["brand"],
    checks: json["checks"] == null ? null : Checks.fromJson(json["checks"]),
    country: json["country"],
    displayBrand: json["display_brand"],
    expMonth: json["exp_month"],
    expYear: json["exp_year"],
    fingerprint: json["fingerprint"],
    funding: json["funding"],
    generatedFrom: json["generated_from"],
    last4: json["last4"],
    networks: json["networks"] == null ? null : Networks.fromJson(json["networks"]),
    threeDSecureUsage: json["three_d_secure_usage"] == null ? null : ThreeDSecureUsage.fromJson(json["three_d_secure_usage"]),
    wallet: json["wallet"],
  );

  Map<String, dynamic> toJson() => {
    "brand": brand,
    "checks": checks?.toJson(),
    "country": country,
    "display_brand": displayBrand,
    "exp_month": expMonth,
    "exp_year": expYear,
    "fingerprint": fingerprint,
    "funding": funding,
    "generated_from": generatedFrom,
    "last4": last4,
    "networks": networks?.toJson(),
    "three_d_secure_usage": threeDSecureUsage?.toJson(),
    "wallet": wallet,
  };
}

class Checks {
  final dynamic addressLine1Check;
  final dynamic addressPostalCodeCheck;
  final String? cvcCheck;

  Checks({
    this.addressLine1Check,
    this.addressPostalCodeCheck,
    this.cvcCheck,
  });

  factory Checks.fromJson(Map<String, dynamic> json) => Checks(
    addressLine1Check: json["address_line1_check"],
    addressPostalCodeCheck: json["address_postal_code_check"],
    cvcCheck: json["cvc_check"],
  );

  Map<String, dynamic> toJson() => {
    "address_line1_check": addressLine1Check,
    "address_postal_code_check": addressPostalCodeCheck,
    "cvc_check": cvcCheck,
  };
}

class Networks {
  final List<String>? available;
  final dynamic preferred;

  Networks({
    this.available,
    this.preferred,
  });

  factory Networks.fromJson(Map<String, dynamic> json) => Networks(
    available: json["available"] == null ? [] : List<String>.from(json["available"]!.map((x) => x)),
    preferred: json["preferred"],
  );

  Map<String, dynamic> toJson() => {
    "available": available == null ? [] : List<dynamic>.from(available!.map((x) => x)),
    "preferred": preferred,
  };
}

class ThreeDSecureUsage {
  final bool? supported;

  ThreeDSecureUsage({
    this.supported,
  });

  factory ThreeDSecureUsage.fromJson(Map<String, dynamic> json) => ThreeDSecureUsage(
    supported: json["supported"],
  );

  Map<String, dynamic> toJson() => {
    "supported": supported,
  };
}
