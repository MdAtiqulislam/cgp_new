import 'dart:async';

import 'package:cgp/app/modules/generalMap/general_map_controller.dart';
import 'package:cgp/app/modules/orderDetails/models/cancel_reasons_model.dart';
import 'package:cgp/app/modules/orderDetails/models/order_details_model.dart';
import 'package:cgp/app/modules/orderHistory/controllers/order_history_controller.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/models/cancel_reason_model.dart';
import 'package:cgp/other_controllers/floating_controller.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:cgp/utils/enams.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderDetailsController extends GetxController {
  var isLoading = false.obs;
  var orderDetails = OrderDetailsModel().obs;
  var cancelReasonsModel = CancelReasonsModel().obs;
  var orderStatus="".obs;
  var selectedCancelReason = CancelReasonModel().obs;
  var showButton = "".obs;


  @override
  void onInit() {
    super.onInit();
   // startPeriodicFunction();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> getOrderDetails({required String orderId,  bool? shouldReload}) async {
    isLoading.value = shouldReload??true;


    var endPoint =
        APIEndPoints.getOrderDetails.replaceAll("{orderId}", orderId);
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        orderDetails.value = OrderDetailsModel.fromJson(response);
        orderStatus.value=orderDetails.value.data?.deliveryInfo?.shippingStatus??"";
        var origin = LatLng(
          orderDetails.value.data?.pickupAddress?.latitude ?? 0.0,
          orderDetails.value.data?.pickupAddress?.longitude ?? 0.0,
        );
        var destination = LatLng(
          orderDetails.value.data?.shippingAddress?.latitude ?? 0.0,
          orderDetails.value.data?.shippingAddress?.longitude ?? 0.0,
        );

        Get.put(MapController());
        Get.find<MapController>().moveToCurrentLocation = false;
        Get.find<MapController>()
            .generateRoute(origin: origin, destination: destination);
        Get.find<MapController>().setCameraPosition(target: origin);

        createShowButton();
        //startPeriodicFunction();
      }
    } finally {
      isLoading.value = false;
    }
  }

  String formatTime(dynamic totalMinutes) {
    int totalMinutesInt =
        totalMinutes.round(); // Convert to the nearest integer
    int hours = totalMinutesInt ~/ 60;
    int minutes = totalMinutesInt % 60;

    String hoursPart = hours > 0
        ? "${hours.toString().padLeft(2, '0')} ${hours == 1 ? 'hour' : 'hours'}"
        : "";
    String minutesPart =
        minutes > 0 ? "$minutes ${minutes == 1 ? 'minute' : 'minutes'}" : "";

    if (hours > 0 && minutes > 0) {
      return "$hoursPart $minutesPart";
    } else if (hours > 0) {
      return hoursPart;
    } else {
      return minutesPart;
    }
  }

  void createShowButton() {
    showButton.value="";
    if (orderDetails.value.data?.orderStatus == OrderStatus.searching.name ||
        orderDetails.value.data?.orderStatus ==
            OrderStatus.reachedAtPickupPoint.name ||
        orderDetails.value.data?.orderStatus == OrderStatus.accepted.name ||
        orderDetails.value.data?.orderStatus == OrderStatus.waiting.name ||
        orderDetails.value.data?.orderStatus == OrderStatus.pending.name) {
      showButton.value = "cancel";
    } else if (orderDetails.value.data?.deliveryInfo?.shippingStatus ==
            OrderStatus.pickedUp.name ||
        orderDetails.value.data?.deliveryInfo?.shippingStatus ==
            OrderStatus.reachedAtDeliveryPoint.name) {
      showButton.value = "track";
    }else if(orderDetails.value.data?.deliveryInfo?.shippingStatus ==
        OrderStatus.delivered.name){
      showButton.value = "review";
     // showButton.value = "track";
    }
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
        Get.find<FloatingController>().hideFloating();
        Get.put(OrderHistoryController()).getOrderHistory();
        CustomSnackBar(
          isSuccess: true,
          msg: response["message"]
        ).showSnackBar();
        getOrderDetails(orderId: "${orderDetails.value.data?.orderId}",shouldReload: true);
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

/*  void startPeriodicFunction() {
    if(orderDetails.value.data?.deliveryInfo?.shippingStatus!="delivered"){
      Timer.periodic(const Duration(seconds: 10), (timer) {
        if(orderStatus.value==OrderStatus.delivered.name){
          timer.cancel();
        }
       else {
          checkOrderStatus();
        }
       // getOrderDetails(orderId: orderDetails.value.data!.orderId.toString(),shouldReload: false);
      });
    }
  }*/

  void checkOrderStatus()async {
    var endPoint =
    APIEndPoints.getOrderDetails.replaceAll("{orderId}", (orderDetails.value.data?.orderId??"").toString());
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
       var newOrderDetails = OrderDetailsModel.fromJson(response);
        orderStatus.value=newOrderDetails.data?.deliveryInfo?.shippingStatus??"";
      }
    } finally {
      isLoading.value = false;
    }
  }
}
