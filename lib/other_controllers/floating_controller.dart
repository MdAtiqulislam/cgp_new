
import 'package:flutter/material.dart';
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
import 'package:url_launcher/url_launcher.dart';

import '../app/modules/messaging/controllers/messaging_controller.dart';
import '../app/modules/orderDetails/models/cancel_reasons_model.dart';
import '../app/routes/app_pages.dart';
import '../common_widgets/custom_snackbar.dart';
import '../constraints/app_strings.dart';
import '../models/cancel_reason_model.dart';

class FloatingController extends GetxController with WidgetsBindingObserver {
  var isFloatingVisible = false.obs;
  var orderDetails = OrderDetailsModel().obs;
  var ongoingOrder = OngoingOrderData().obs;
  var isLoading = false.obs;
  var isExpand = true.obs; // Initially set to true to show the floating widget
  IO.Socket? socket;

  var distanceText = "--".obs;
  var timeText = "--".obs;

  late LatLng riderLocation;
  late LatLng destination;

  double distanceInMeter = 0.0;
  double timeInSeconds = 0.0;
  var destinationName = "".obs;
  var orderId = "".obs;

  var activeProgress=0.obs;

  var cancelReasonsModel = CancelReasonsModel().obs;
  var selectedCancelReason = CancelReasonModel().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
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
    WidgetsBinding.instance.removeObserver(this);
    disconnectSocket();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App is in the foreground, update ongoing order status
      if (orderId.value.isNotEmpty) {
        getOngoingOrder();
      }
    }
  }

  Future<void> showFloating() async {
    isFloatingVisible.value = true;
    await getOrderDetails();
    await getOngoingOrder();
    initializeSocket(); // Ensure the socket is initialized
    await initMessaging();
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
    } else {}

    socket = IO.io(APIEndPoints.baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket?.connect();
    socket?.on('connect', (_) {
      if (kDebugMode) {
        print('Connected to socket server');
      }
    });

    socket?.on('connect_error', (error) {
      if (kDebugMode) {
        print('Connection Error: $error');
      }
    });

    socket?.on('connect_timeout', (_) {
      if (kDebugMode) {
        print('Connection Timeout');
      }
    });

    socket?.on('error', (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    });

    socket?.on('disconnect', (_) {
      if (kDebugMode) {
        print('Disconnected from socket server');
      }
    });

    socket?.on('reconnect_attempt', (_) {
      if (kDebugMode) {
        print('Reconnecting...');
      }
    });

   // socket?.on('locationUpdated', (data) {
    print('riderLocationUpdated_${orderDetails.value.data?.deliveryInfo?.rider?.id}');

    socket?.on('riderLocationUpdated_${orderDetails.value.data?.deliveryInfo?.rider?.id}', (data) {
      print('riderLocationUpdated_${orderDetails.value.data?.deliveryInfo?.rider?.id}');


      riderLocation = LatLng(
        data['location']['coordinates'][1], // Latitude
        data['location']['coordinates'][0], // Longitude
      );
      if (kDebugMode) {
        print("Rider location: $riderLocation");
      }
      handleStatus();
    });

    socket?.on('orderStatusUpdated_${orderDetails.value.data?.orderId}', (data) {
      if (kDebugMode) {
        print("orderStatusUpdate_Data:$data");


      }
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
    if (currentStatus == OrderStatus.accepted.name ||
        currentStatus == OrderStatus.reachedAtPickupPoint.name) {
     if(orderDetails.value.data?.deliveryInfo?.rider?.location==null){
       await getOrderDetails().then((value){
         handleStatus();
       });
     }
       else{
       destinationName.value = "Pickup Point";
       riderLocation = LatLng(
           orderDetails.value.data?.deliveryInfo?.rider?.location?.latitude ?? 0.0,
           orderDetails.value.data?.deliveryInfo?.rider?.location?.longitude ?? 0.0);
       destination = LatLng(
           orderDetails.value.data?.pickupAddress?.latitude ?? 0.0,
           orderDetails.value.data?.pickupAddress?.longitude ?? 0.0);
       if (ongoingOrder.value.duration!=null && ongoingOrder.value.distance!=null) {
        distanceInMeter=double.parse(ongoingOrder.value.distance??"0.0");
        timeInSeconds=double.parse(ongoingOrder.value.duration??"0.0");
       }else{
         distanceInMeter = calculateDistanceInMeter(riderLocation, destination);
         if (kDebugMode) {
           print("distanceInMeter:$distanceInMeter");
         }
         timeInSeconds = (90.0 / 1000.0) * distanceInMeter;
       }
     }
    } else if (currentStatus == OrderStatus.pickedUp.name ||
        currentStatus == "in_trangite") {
      destinationName.value = "Drop-off Point";
      destination = LatLng(
          orderDetails.value.data?.shippingAddress?.latitude ?? 0.0,
          orderDetails.value.data?.shippingAddress?.longitude ?? 0.0);
      riderLocation = LatLng(
          orderDetails.value.data?.deliveryInfo?.rider?.location?.latitude ?? 0.0,
          orderDetails.value.data?.deliveryInfo?.rider?.location?.longitude ?? 0.0);

      if (ongoingOrder.value.duration!=null && ongoingOrder.value.distance!=null) {
        distanceInMeter=double.parse(ongoingOrder.value.distance??"0.0");
        timeInSeconds=double.parse(ongoingOrder.value.duration??"0.0");
      }else{
        distanceInMeter = calculateDistanceInMeter(riderLocation, destination);
        if (kDebugMode) {
          print("distanceInMeter:$distanceInMeter");
        }
        timeInSeconds = (90.0 / 1000.0) * distanceInMeter;
      }
    } else if (currentStatus == OrderStatus.delivered.name ||
        currentStatus == OrderStatus.cancelled.name ||
        currentStatus == OrderStatus.expired.name) {
      hideFloating();
    }
    getDistanceAndTimeText();
    progressStatus(currentStatus:currentStatus);
  }

  Future<void> getOrderDetails() async {
    isLoading.value = true;
    var endPoint =
    APIEndPoints.getOrderDetails.replaceAll("{orderId}", orderId.value);
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {

        if (kDebugMode) {
          print(response);
        }
        orderDetails.value = OrderDetailsModel.fromJson(response);
        riderLocation = LatLng(orderDetails.value.data?.deliveryInfo?.rider?.location?.latitude??0.0,
            orderDetails.value.data?.deliveryInfo?.rider?.location?.longitude??0.0);
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
        timeText.value =formatTimeFromSeconds(timeInSeconds.toInt());
      } else {
        distanceText.value = "Almost there";
        timeText.value = "Very soon";
      }
    } else {
      distanceText.value = "--";
      timeText.value = "--";
    }
  }

  void progressStatus({required String currentStatus}) {
    if(currentStatus==OrderStatus.pending.name||currentStatus==OrderStatus.searching.name){
      activeProgress.value=0;
    }else if(currentStatus==OrderStatus.accepted.name||currentStatus==OrderStatus.reachedAtPickupPoint.name){
      activeProgress.value=1;
    }else if(currentStatus==OrderStatus.pickedUp.name){
      activeProgress.value=2;
    }else if(currentStatus==OrderStatus.reachedAtDeliveryPoint.name||currentStatus==OrderStatus.delivered.name){
      activeProgress.value=3;
    }

  }
 Future<void> initMessaging()async {
await getOrderDetails().then((value){
  Get.put(MessagingController());
  Get.find<MessagingController>().initValue();
  Get.find<MessagingController>().orderDetails.value=orderDetails.value;
  Get.find<MessagingController>().imageLink.value=orderDetails.value.data?.deliveryInfo?.rider?.url??"";
  Get.find<MessagingController>().chatWith.value=orderDetails.value.data?.deliveryInfo?.rider?.name??"";
});

 }

  Future<void> cancelOrder() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.cancelOrder
        .replaceAll("{orderId}", "${orderDetails.value.data?.orderId}")
        .replaceAll(
        "{orderCancelReasonId}", "${selectedCancelReason.value.id}");
    try {
      var response=await RemoteServices.putRequest(endPoint: endPoint);
      if(response!=null){

        Get.find<FloatingController>().showFloating();
        CustomSnackBar(
            isSuccess: true,
            msg: response["message"]
        ).showSnackBar();
        getOrderDetails();
      }else{
        CustomSnackBar(
            isSuccess: true,
            msg: AppStrings.httpErrorMSG.value
        ).showSnackBar();
      }
    } finally {
      isLoading.value=false;
    }
  }

  Future<void> getCancelReason() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getCancelReason;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        cancelReasonsModel.value = CancelReasonsModel.fromJson(response);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> callDriver() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: orderDetails.value.data
          ?.deliveryInfo?.rider?.phone ??
          "",
    );
    await launchUrl(launchUri);
  }

  void chatWithDriver() {
    Get.put(MessagingController());
    Get.find<MessagingController>().initValue();
    Get.find<MessagingController>().orderDetails.value=orderDetails.value;
    Get.find<MessagingController>().imageLink.value=orderDetails.value.data?.deliveryInfo?.rider?.url??"";
    Get.find<MessagingController>().chatWith.value=orderDetails.value.data?.deliveryInfo?.rider?.name??"";
    Get.find<MessagingController>().loadPreviousMessage();
    Get.toNamed(Routes.MESSAGING);
  }

}




/*String formatTimeFromSeconds(int totalSeconds) {
  int hours = totalSeconds ~/ 3600;
  int minutes = (totalSeconds % 3600) ~/ 60;

  String hoursPart = hours > 0
      ? "${hours.toString().padLeft(2, '0')} ${hours == 1 ? 'hour' : 'hours'}"
      : "";
  String minutesPart = minutes > 0
      ? "${minutes.toString().padLeft(2, '0')} ${minutes == 1 ? 'minute' : 'minutes'}"
      : "";

  if (hours > 0 && minutes > 0) {
    return "$hoursPart $minutesPart";
  } else if (hours > 0) {
    return hoursPart;
  } else {
    return minutesPart;
  }
}*/
String formatTimeFromSeconds(int totalSeconds) {
  int hours = totalSeconds ~/ 3600;
  int minutes = (totalSeconds % 3600) ~/ 60;
  int seconds = totalSeconds % 60;

  String hoursPart = hours > 0
      ? "${hours.toString().padLeft(2, '0')} ${hours == 1 ? 'hour' : 'hours'}"
      : "";
  String minutesPart = minutes > 0
      ? "${minutes.toString().padLeft(2, '0')} ${minutes == 1 ? 'minute' : 'minutes'}"
      : "";
  String secondsPart = seconds > 0
      ? "${seconds.toString().padLeft(2, '0')} ${seconds == 1 ? 'second' : 'seconds'}"
      : "";

  if (hours > 0 && minutes > 0) {
    return "$hoursPart $minutesPart";
  } else if (hours > 0) {
    return hoursPart;
  } else if (minutes > 0) {
    return minutesPart;
  } else {
    return secondsPart;
  }
}
