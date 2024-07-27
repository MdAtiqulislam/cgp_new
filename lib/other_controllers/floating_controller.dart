import 'package:cgp/app/modules/orderDetails/controllers/order_details_controller.dart';
import 'package:cgp/app/modules/orderDetails/models/order_details_model.dart';
import 'package:cgp/models/ongoing_order_model.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/local_services.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:cgp/utils/enams.dart';
import 'package:cgp/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get/get.dart';

class FloatingController extends GetxController {
  var isFloatingVisible = false.obs;
  var orderDetails = OrderDetailsModel().obs;
  var ongoingOrder = OngoingOrderData().obs;
  var isLoading = false.obs;
  var isExpand = false.obs; // Initially set to true to show the floating widget
  IO.Socket? socket;

  var distanceText = "--".obs;
  var timeText = "--".obs;

  late LatLng riderLocation;
  late LatLng destination;

  double distanceInMeter = 0.0;
  double timeInSeconds = 0.0;
  var destinationName = "".obs;
  var orderId = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await LocalServices.getOnGoingTrip().then((value) {
      if (value != null) {
        orderId.value = value;
        showFloating();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    disconnectSocket();
  }

  Future<void> showFloating() async {
    isFloatingVisible.value = true;
    await getOrderDetails();
    await getOngoingOrder();
    initializeSocket(); // Ensure the socket is initialized
  }

  void hideFloating() {
    isFloatingVisible.value = false;
    disconnectSocket();
    destinationName.value = "";
    LocalServices.storeOnGoingTrip(null);
  }

  void initializeSocket() {
    print("Initializing socket...");
    if (socket != null) {
      print("Socket already initialized");
      return;
    }else{

    }

    socket = IO.io('https://cgp-rider-api.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket?.connect();
    socket?.on('connect', (_) {
      print('Connected to socket server');
    });

    socket?.on('connect_error', (error) {
      print('Connection Error: $error');
    });

    socket?.on('connect_timeout', (_) {
      print('Connection Timeout');
    });

    socket?.on('error', (error) {
      print('Error: $error');
    });

    socket?.on('disconnect', (_) {
      print('Disconnected from socket server');
    });

    socket?.on('reconnect_attempt', (_) {
      print('Reconnecting...');
    });

    socket?.on('locationUpdated', (data) {
      riderLocation = LatLng(
        data['location']['coordinates'][1], // Latitude
        data['location']['coordinates'][0], // Longitude
      );
      print("newLocation: $riderLocation");
      print('orderStatusUpdated_${orderDetails.value.data?.orderId}');
      handleStatus();
    });

    socket?.on('orderStatusUpdated_${orderDetails.value.data?.orderId}', (data) {
      print("orderStatusUpdate_Data:$data");
      if (data != null) {
        ongoingOrder.value = OngoingOrderData.fromJson(data);
        handleStatus();
        Get.put(OrderDetailsController());
        Get.find<OrderDetailsController>().orderStatus.value =
            ongoingOrder.value.shippingStatus ?? "";
      }
    });
  }

  void disconnectSocket() {
    print("Disconnecting socket...");
    if (socket != null) {
      socket?.disconnect();
      socket?.off('connect');
      socket?.off('connect_error');
      socket?.off('connect_timeout');
      socket?.off('error');
      socket?.off('disconnect');
      socket?.off('reconnect_attempt');
      socket?.off('locationUpdated');
      socket?.off('orderStatusUpdated_${orderDetails.value.data?.orderId}');
      socket?.close();
      socket = null;
    }
  }

  Future<void> handleStatus() async {
    String currentStatus = ongoingOrder.value.shippingStatus ?? "";

    if (kDebugMode) {
      print(currentStatus);
    }
    if (currentStatus == OrderStatus.accepted.name ||
        currentStatus == OrderStatus.reachedAtPickupPoint.name) {
      destinationName.value = "Pickup Point";
      destination = LatLng(
          orderDetails.value.data?.pickupAddress?.latitude ?? 0.0,
          orderDetails.value.data?.pickupAddress?.longitude ?? 0.0);

      distanceInMeter = calculateDistanceInMeter(riderLocation, destination);
      if (kDebugMode) {
        print("distanceInMeter:$distanceInMeter");
      }

      timeInSeconds = (90.0 / 1000.0) * distanceInMeter;
    } else if (currentStatus == OrderStatus.pickedUp.name ||
        currentStatus == "in_trangite") {
      destinationName.value = "Drop-off Point";
      destination = LatLng(
          orderDetails.value.data?.shippingAddress?.latitude ?? 0.0,
          orderDetails.value.data?.shippingAddress?.longitude ?? 0.0);
      distanceInMeter = calculateDistanceInMeter(riderLocation, destination);
      if (kDebugMode) {
        print("distanceInMeter:$distanceInMeter");
      }
      timeInSeconds = (90.0 / 1000.0) * distanceInMeter;
    } else if (currentStatus == OrderStatus.delivered.name ||
        currentStatus == OrderStatus.cancelled.name ||
        currentStatus == OrderStatus.expired.name) {
      hideFloating();
    }
    getDistanceAndTimeText();
  }

  Future<void> getOrderDetails() async {
    isLoading.value = true;
    var endPoint =
    APIEndPoints.getOrderDetails.replaceAll("{orderId}", orderId.value);
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        orderDetails.value = OrderDetailsModel.fromJson(response);
        riderLocation = LatLng(orderDetails.value.data?.pickupAddress?.latitude,
            orderDetails.value.data?.pickupAddress?.longitude);
        destination = LatLng(orderDetails.value.data?.pickupAddress?.latitude,
            orderDetails.value.data?.pickupAddress?.longitude);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getOngoingOrder() async {
    var endPoint =
    APIEndPoints.getOngoingOrder.replaceAll("{orderId}", orderId.value);
    var response = await RemoteServices.getRequest(endPoint: endPoint);
    if (response != null) {
      OngoingOrderModel ongoingOrderModel =
      OngoingOrderModel.fromJson(response);
      ongoingOrder.value = ongoingOrderModel.data ?? OngoingOrderData();
      await handleStatus();
    }
  }

  void getDistanceAndTimeText() {
    if (ongoingOrder.value.shippingStatus == OrderStatus.accepted.name ||
        ongoingOrder.value.shippingStatus == OrderStatus.pickedUp.name) {
      if (distanceInMeter > 150) {
        distanceText.value = formatDistance(
          distanceInMeter: distanceInMeter,
        );
        timeText.value = formatTimeFromSeconds(timeInSeconds.toInt());
      } else {
        distanceText.value = "Almost there";
        timeText.value = "Very soon";
      }
    } else {
      distanceText.value = "--";
      timeText.value = "--";
    }
  }
}

String formatTimeFromSeconds(int totalSeconds) {
  int hours = totalSeconds ~/ 3600;
  int minutes = (totalSeconds % 3600) ~/ 60;

  String hoursPart = hours > 0 ? "${hours.toString().padLeft(2, '0')} ${hours == 1 ? 'hour' : 'hours'}" : "";
  String minutesPart = minutes > 0 ? "${minutes.toString().padLeft(2, '0')} ${minutes == 1 ? 'minute' : 'minutes'}" : "";

  if (hours > 0 && minutes > 0) {
    return "$hoursPart $minutesPart";
  } else if (hours > 0) {
    return hoursPart;
  } else {
    return minutesPart;
  }
}
