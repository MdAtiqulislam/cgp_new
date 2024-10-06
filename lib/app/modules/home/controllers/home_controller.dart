import 'package:cgp/app/modules/home/models/home_data_model.dart';
import 'package:cgp/other_controllers/appbar_controller.dart';
import 'package:cgp/services/local_services.dart';
import 'package:cgp/services/pusher_services.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../../../common_widgets/custom_snackbar.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../services/api_endpoints.dart';
import '../../../../utils/utils.dart';
import '../../../routes/app_pages.dart';
import '../../cart/models/my_cart_model.dart';
import '../../notifications/controllers/notifications_controller.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var homeDataModel = HomeDataModel().obs;
  var cartModel = MyCartModel().obs;
  var distances = [].obs;
  var currentLocation = Rx<LocationData?>(null);

  var dropDownController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    currentLocation.value = await getCurrentLocation();
    await getCustomerInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleForegroundNotification(Get.context!);
    });
    await getHomeData();
    getNotificationData();
  }

  @override
  void onClose() {}

  Future<void> getHomeData() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.homeDataWithWarehouseBranch;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);

      if (response != null) {
        homeDataModel.value = HomeDataModel.fromJson(response);
      } else {
        CustomSnackBar(
          isSuccess: false,
          msg: AppStrings.httpErrorMSG.value,
        ).showSnackBar();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void getNotificationData() {
    Get.put(AppbarController());
    Get.find<AppbarController>().getNotifications();
  }

  void handleForegroundNotification(BuildContext context) async {
    const storage = FlutterSecureStorage();
    //String? requestId = await storage.read(key: 'requestId');
    String? notificationId = await storage.read(key: 'notificationId');

    if (notificationId != null) {
      // Assuming you have already registered the TripRequestController
      Get.put(NotificationsController());
      Get.find<NotificationsController>().getNotification();
      Get.toNamed(Routes.NOTIFICATIONS);
      Get.back();

      // Clear the saved data
      await storage.delete(key: 'requestId');
      await storage.delete(key: 'notificationId');
    }
  }

  Future<void> getCustomerInfo() async {
    await LocalServices.getUser().then((value) {
      Get.put(PusherService((value?.userId ?? "").toString()));
    });
  }

  String calculateDistance({required double lat, required double lan}) {
    var distance = lat != 0 && lan != 0 && currentLocation.value?.latitude!=null && currentLocation.value?.longitude!=null
        ? formatDistance(
            distanceInMeter: calculateDistanceInMeter(
                LatLng(currentLocation.value?.latitude ?? 0,
                    currentLocation.value?.longitude ?? 0),
                LatLng(lat, lan)))
        : "--";
    return distance;
  }
}
