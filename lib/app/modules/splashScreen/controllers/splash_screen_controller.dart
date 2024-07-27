import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/services/local_services.dart';
import 'package:cgp/services/pusher_services.dart';
import 'package:get/get.dart';

import '../../../../other_controllers/appbar_controller.dart';
import '../../../../services/notification_services.dart';

class SplashScreenController extends GetxController {
  var isLoading=true.obs;
  NotificationServices notificationServices = NotificationServices();
  @override
  void onInit() {
    super.onInit();
    notificationServices.setupInterruptMessage(Get.context!);
    getLoginStatus();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> getLoginStatus() async {
    final token = await LocalServices.getToken();
    isLoading.value = false; // Set isLoading to false regardless of token presence
    if (token != null) {
      //Get.offAllNamed(Routes.HOME); // Navigate to HOME if token exists
      await LocalServices.getUser().then((value){
        Get.put(PusherService(value!.userId.toString()));
      });
      Get.offAndToNamed(Routes.TRANSPORTATION);

    }
  }



}
