import 'package:cgp/app/modules/notifications/models/notifications_model.dart';
import 'package:cgp/models/customer_model.dart';
import 'package:get/get.dart';

import '../app/modules/notifications/controllers/notifications_controller.dart';
import '../app/routes/app_pages.dart';
import '../services/api_endpoints.dart';
import '../services/local_services.dart';
import '../services/remote_services.dart';

class AppbarController extends GetxController{
  var isLoading=false.obs;
  var customer=CustomerModel().obs;
  var notificationsModel=NotificationsModel().obs;
  var unreadNotifications=0.obs;


  @override
  void onInit() async{
    super.onInit();
    await getUserData();
  }

  Future<void> getUserData() async{
    await LocalServices.getUser().then((value) async {
      if(value!=null){
        customer.value=value;
        if(customer.value.id!=null){
        //  await getNotifications();
        }
      }
    });
  }

  Future<void>getNotifications()async{

    var endPoint=APIEndPoints.getNotification;
    try {
      var data=await RemoteServices.getRequest(endPoint: endPoint);
      if(data!=null){
        notificationsModel.value=NotificationsModel.fromJson(data);

        Get.put(NotificationsController());
        Get.find<NotificationsController>().notificationsModel.value=notificationsModel.value;
        calculateUnreadNotification();
      }
    } finally {
      isLoading.value=false;
    }
  }

  void calculateUnreadNotification() {
    print("Calculating.......");
    unreadNotifications.value=0;
    notificationsModel.value.data?.forEach((value){
      if(!(value.isRead??true)){
        unreadNotifications.value+=1;
      }
    });
    print(unreadNotifications);
  }

  void openNotificationPage() {


    if(Get.currentRoute==Routes.NOTIFICATIONS){
      Get.offAndToNamed(Routes.NOTIFICATIONS);
    }else{
      Get.put(NotificationsController());
      Get.find<NotificationsController>()
          .getNotification();
      Get.toNamed(Routes.NOTIFICATIONS);
    }


  }

}