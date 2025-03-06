import 'package:cgp/app/modules/home/models/home_data_model.dart';
import 'package:cgp/models/allproductsModel.dart';
import 'package:cgp/models/single_product_model.dart';
import 'package:cgp/other_controllers/appbar_controller.dart';
import 'package:cgp/services/local_services.dart';
import 'package:cgp/services/pusher_services.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common_widgets/custom_snackbar.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../services/api_endpoints.dart';
import '../../../../utils/utils.dart';
import '../../../routes/app_pages.dart';
import '../../cart/models/my_cart_model.dart';
import '../../notifications/controllers/notifications_controller.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var isLoadingProduct = true.obs;
  var homeDataModel = HomeDataModel().obs;
  var cartModel = MyCartModel().obs;
  var distances = [].obs;
  var currentLocation = Rx<LocationData?>(null);
  var dropDownController = TextEditingController();
  var products=<SingleProductModel>[].obs;
  var productsModel=AllProductsModel().obs;

  ScrollController scrollController = ScrollController();



  @override
  Future<void> onInit() async {
    super.onInit();
    currentLocation.value = await getCurrentLocation();
    await getCustomerInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleForegroundNotification(Get.context!);
    });
    await getHomeData();
    await getProducts();
    getNotificationData();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!isLoadingProduct.value && productsModel.value.currentPage!=productsModel.value.lastPage) {
          getProducts();
        }
      }
    });
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

  Future<void> getProducts() async {
    isLoadingProduct.value = true;
    var endPoint = APIEndPoints.getAllProducts;
    var parameters={
      "page":"${(productsModel.value.currentPage??0)+1}",
      "perPage":AppStrings.paginationProductsPerPage
    };
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint,parameters: parameters);

      if (response != null) {
        productsModel.value = AllProductsModel.fromJson(response);
        productsModel.value.data?.forEach((value){
          products.value.add(value);
        });

      } else {
        CustomSnackBar(
          isSuccess: false,
          msg: AppStrings.httpErrorMSG.value,
        ).showSnackBar();
      }
    } finally {
      isLoadingProduct.value = false;
    }
  }

  void getNotificationData() {
    Get.put(AppbarController());
    Get.find<AppbarController>().getNotifications();
  }


  void handleForegroundNotification(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve notificationId from SharedPreferences
    String? notificationId = prefs.getString('notificationId');
    if (notificationId != null) {
      // Assuming you have already registered the NotificationsController
      Get.put(NotificationsController());
      Get.find<NotificationsController>().getNotification();

      // Navigate to Notifications screen
      Get.toNamed(Routes.NOTIFICATIONS);
      Get.back();

      // Clear the saved data
      await prefs.remove('requestId');
      await prefs.remove('notificationId');
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





/*
class HomeController extends GetxController {
  var isLoading = true.obs;
  var isLoadingProduct = true.obs;
  var homeDataModel = HomeDataModel().obs;
  var cartModel = MyCartModel().obs;
  var distances = [].obs;
  var currentLocation = Rx<LocationData?>(null);
  var dropDownController = TextEditingController();
  var products = <SingleProductModel>[].obs;
  var productsModel = AllProductsModel().obs;

 // Scroll controller

  @override
  Future<void> onInit() async {
    super.onInit();
    currentLocation.value = await getCurrentLocation();
    await getCustomerInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleForegroundNotification(Get.context!);
    });
    await getHomeData();
    await getProducts();
    getNotificationData();

  }

  @override
  void onClose() {
    scrollController.dispose(); // Dispose the scroll controller when the controller is closed
    super.onClose();
  }

  Future<void> getProducts() async {
    if (isLoadingProduct.value) return; // Prevent multiple requests at the same time

    isLoadingProduct.value = true;
    var endPoint = APIEndPoints.getAllProducts;
    var parameters = {
      "page": productsModel.value.currentPage ?? "1",
      "perPage": "10"
    };

    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint, parameters: parameters);

      if (response != null) {
        productsModel.value = AllProductsModel.fromJson(response);
        productsModel.value.data?.forEach((value) {
          products.value.add(value);
        });
      } else {
        CustomSnackBar(
          isSuccess: false,
          msg: AppStrings.httpErrorMSG.value,
        ).showSnackBar();
      }
    } finally {
      isLoadingProduct.value = false;
    }
  }

// Rest of the methods remain the same
}*/
