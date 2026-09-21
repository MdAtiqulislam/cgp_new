import 'package:cgp/app/modules/notifications/models/notifications_model.dart';
import 'package:cgp/app/modules/orderDetails/controllers/order_details_controller.dart';
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/other_controllers/appbar_controller.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  var isLoading = false.obs;
  var notificationsModel = NotificationsModel().obs;

  @override
  void onInit() async {
    super.onInit();
    Get.put(AppbarController);
    // await getNotification();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> getNotification() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getNotification;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        notificationsModel.value = NotificationsModel.fromJson(response);
        Get.find<AppbarController>().notificationsModel.value =
            notificationsModel.value;
        Get.find<AppbarController>().calculateUnreadNotification();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void handelClick({required SingleNotificationModel notification}) {
    if (notification.data?.orderId != null) {
      Get.put(OrderDetailsController());
      Get.find<OrderDetailsController>()
          .getOrderDetails(orderId: notification.data?.orderId ?? "");
      Get.toNamed(Routes.ORDER_DETAILS);

      markAsRead(notificationId: notification.id ?? "");
    } else {
      CustomSnackBar(msg: "Something went wrong.", isSuccess: false)
          .showSnackBar();
    }
  }

  void markAsRead({required String notificationId}) async {
    var endPoint = APIEndPoints.markNotificationAsRead
        .replaceAll("{notificationId}", notificationId);
    var response = await RemoteServices.putRequest(endPoint: endPoint);
    if (response != null) {
      await getNotification().then((value) {
        Get.find<AppbarController>().notificationsModel.value =
            notificationsModel.value;
        Get.find<AppbarController>().calculateUnreadNotification();
      });
    }
  }

  Future<void> markAllAsRead() async {
    var endPoint = APIEndPoints.markAllAsReadNotification;
    var response = await RemoteServices.putRequest(endPoint: endPoint);
    if (response != null) {
      await getNotification().then((value) {
        Get.find<AppbarController>().notificationsModel.value =
            notificationsModel.value;
        Get.find<AppbarController>().calculateUnreadNotification();
      });
    }
  }

  void deleteNotificationById(String id, int index) {
    var endPoint =
        APIEndPoints.deleteNotificationById.replaceAll("{notificationId}", id);
    RemoteServices.deleteRequest(endPoint: endPoint).then((response) {
      if (response != null) {
        notificationsModel.value.data?.removeAt(index);
        Get.find<AppbarController>().notificationsModel.value =
            notificationsModel.value;
        Get.find<AppbarController>().calculateUnreadNotification();
      }
    });
  }

  Future<void> deleteAllNotifications() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.deleteAllNotifications;
    try {
      var response = await RemoteServices.deleteRequest(endPoint: endPoint);
      if (response != null) {
        notificationsModel.value.data?.clear();
        Get.find<AppbarController>().notificationsModel.value =
            notificationsModel.value;
        Get.find<AppbarController>().calculateUnreadNotification();
        getNotification();
      }
    } finally {
      isLoading.value = false;
    }
  }
}


