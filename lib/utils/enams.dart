enum AddressType { billing, pickup, shipping }

extension AddressTypwExtension on AddressType {
  String get name {
    switch (this) {
      case AddressType.billing:
        return 'billing';
      case AddressType.pickup:
        return 'pickup';
      case AddressType.shipping:
        return 'shipping';
    }
  }
}

enum OrderType {
  productAndTransport,
  transportationOnly,
}

extension OrderTypeExtension on OrderType {
  String get name {
    switch (this) {
      case OrderType.productAndTransport:
        return 'product_and_transport';
      case OrderType.transportationOnly:
        return 'transportation_only';
    }
  }
}

enum OrderStatus {
  pending,
  waiting,
  searching,
  accepted,
  reachedAtPickupPoint,
  pickedUp,
  reachedAtDeliveryPoint,
  delivered,
  expired,
  cancelled,

}

extension OrderStatusExtension on OrderStatus {
  String get name {
    switch (this) {
      case OrderStatus.waiting:
        return 'waiting';
      case OrderStatus.searching:
        return 'searching';
      case OrderStatus.accepted:
        return "accepted";
      case OrderStatus.reachedAtPickupPoint:
        return "reached_at_pickup_point";
      case OrderStatus.pickedUp:
        return "picked_up";
      case OrderStatus.reachedAtDeliveryPoint:
        return "reached_at_delivery_point";
      case OrderStatus.delivered:
        return "delivered";
      case OrderStatus.expired:
        return "expired";
      case OrderStatus.cancelled:
        return "cancelled";
      case OrderStatus.pending:
        return "pending";
    }
  }
}


enum BranchType {
  headOffice,
  branchOffice,
}

extension BranchTypeExtension on BranchType {
  String get name {
    switch (this) {
      case BranchType.branchOffice:
        return 'branch office';
      case BranchType.headOffice:
        return 'head office';
    }
  }
}