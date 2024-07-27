import 'package:cgp/app/modules/home/models/home_data_model.dart';
import 'package:cgp/other_controllers/appbar_controller.dart';
import 'package:cgp/services/local_services.dart';
import 'package:cgp/services/pusher_services.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_snackbar.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../services/api_endpoints.dart';
import '../../../routes/app_pages.dart';
import '../../notifications/controllers/notifications_controller.dart';

class HomeController extends GetxController {

var isLoading=true.obs;
var homeDataModel=HomeDataModel().obs;


  var dropDownController=TextEditingController();
  @override
  Future<void> onInit() async {
    super.onInit();
    await getCustomerInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleForegroundNotification(Get.context!);
    });
    getHomeData();
    getNotificationData();

   // getMyLocation();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getHomeData()async {
    var endPoint=APIEndPoints.homeData;

    try {
      var response =
      await RemoteServices.getRequest(endPoint: endPoint);

      if (response != null) {
        homeDataModel.value=HomeDataModel.fromJson(response);
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

/*  void getMyLocation() async{
    
   // CustomLocation targetLocation=;
    await distanceFromMyLocation(latitude:"-33.873832", longitude: "151.205263").then((value){
      print("${value} ");
    });


  }*/


  void handleForegroundNotification(BuildContext context) async {
    final storage = FlutterSecureStorage();
    //String? requestId = await storage.read(key: 'requestId');
    String? notificationId = await storage.read(key: 'notificationId');

    if ( notificationId != null) {
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

Future<void>  getCustomerInfo() async{

    await LocalServices.getUser().then((value){

      Get.put(PusherService((value?.userId??"").toString()));

    });
}
}
