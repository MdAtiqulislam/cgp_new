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

  static OrderStatus fromString(String status) {
    switch (status) {
      case 'waiting':
        return OrderStatus.waiting;
      case 'searching':
        return OrderStatus.searching;
      case 'accepted':
        return OrderStatus.accepted;
      case 'reached_at_pickup_point':
        return OrderStatus.reachedAtPickupPoint;
      case 'picked_up':
        return OrderStatus.pickedUp;
      case 'reached_at_delivery_point':
        return OrderStatus.reachedAtDeliveryPoint;
      case 'delivered':
        return OrderStatus.delivered;
      case 'expired':
        return OrderStatus.expired;
      case 'cancelled':
        return OrderStatus.cancelled;
      case 'pending':
        return OrderStatus.pending;
      default:
        throw ArgumentError('Invalid status: $status');
    }
  }
}

String getFormattedStatus(String status) {
  OrderStatus orderStatus = OrderStatusExtension.fromString(status);

  switch (orderStatus) {
    case OrderStatus.waiting:
      return 'Waiting for action';
    case OrderStatus.searching:
      return 'Searching for a driver';
    case OrderStatus.accepted:
      return "Order Accepted";
    case OrderStatus.reachedAtPickupPoint:
      return "Reached at Pickup Point";
    case OrderStatus.pickedUp:
      return "Picked Up";
    case OrderStatus.reachedAtDeliveryPoint:
      return "Reached At Delivery Point";
    case OrderStatus.delivered:
      return "Delivered";
    case OrderStatus.expired:
      return "Order Expired";
    case OrderStatus.cancelled:
      return "Order Cancelled";
    case OrderStatus.pending:
      return "Order Pending";
    default:
      return "Unknown Status";
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