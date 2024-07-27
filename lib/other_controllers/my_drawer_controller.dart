import 'package:cgp/app/modules/orderHistory/models/order_history_model.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/models/customer_model.dart';
import 'package:cgp/other_controllers/floating_controller.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/notification_services.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:cgp/utils/enams.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app/modules/profile/controllers/profile_controller.dart';
import '../app/routes/app_pages.dart';
import '../common_widgets/app_button.dart';
import '../constraints/app_colors.dart';
import '../constraints/app_strings.dart';
import '../constraints/dimensions.dart';
import '../constraints/header_text.dart';
import '../services/local_services.dart';

class MyDrawerController extends GetxController {
  var isLoading = false.obs;
  var customer = CustomerModel().obs;
  var onGoingRequests = OrderHistoryModel().obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserData();
  }

  void logOut() {
    showDialog(
        context: Get.context!,
        builder: (buildContext) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPadding.w,
                  vertical: AppDimensions.verticalPadding.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppImagePath.warningIcon),
                    SizedBox(height: 16.h //AppDimensions.widgetPaddingVer,
                        ),
                    //  const CustomCircleAvatar(width: 50, height: 50, image: AppImagePath.warningIcon),
                    const HeaderText(text: "Are you sure you want to log out?"),
                    SizedBox(height: 32.h //AppDimensions.sectionPaddingVer,
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(
                          text: "Cancel",
                          onTap: () {
                            Get.back();
                          },
                          bgColor: AppColors.primaryColor,
                        ),
                        SizedBox(width: 16.w //AppDimensions.widgetPaddingHor,
                            ),
                        AppButton(
                          text: "Confirm",
                          onTap: () {
                            Get.back();
                            completeLogOut();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> getUserData() async {
    isLoading.value = true;
    await LocalServices.getUser().then((value) {
      if (value != null) {
        customer.value = value;
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    });
  }

  void openProfilePage() {
    Get.put(ProfileController());
    //Get.find<ProfileController>().getUserData();
    Get.find<ProfileController>().getAddresses();

    Get.toNamed(Routes.PROFILE);
  }

  Future<void> completeLogOut() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.logOut;
    var fcmToken = await NotificationServices().getDeviceToken();
    var body = {"device_token": fcmToken};
    try {
      var response = await RemoteServices.postRequestWithJsonData(
          endPoint: endPoint, body: body);

      if (response != null) {
        Get.offAllNamed(Routes.SPLASH_SCREEN);
        Get.find<FloatingController>().hideFloating();
        LocalServices.deleteData();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void requestForTransportation() async {
    isLoading.value = true;

    if(!await pendingOrder()){
      Get.toNamed(Routes.TRANSPORTATION);
    }


  }

  bool checkRequest(Rx<OrderHistoryModel> onGoingRequests) {
    bool isRequestActive = false;

    onGoingRequests.value.data?.forEach((value) {
      if (value.orderStatus != OrderStatus.cancelled.name &&
          value.orderStatus != OrderStatus.expired.name &&
          value.orderStatus != OrderStatus.delivered.name) {
        isRequestActive = true;
        return;
      }
    });

    return isRequestActive;
  }

  Future<bool> pendingOrder() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.orderHistory;

    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);

      // Check for response and specific error message
      if (response != null || AppStrings.httpErrorMSG.value == "Order not found") {
        onGoingRequests.value = OrderHistoryModel.fromJson(response);

        var result = checkRequest(onGoingRequests);
        if (result) {
          CustomSnackBar(
              msg: "You have an active order right now.\nPlease complete the order first.",
              isSuccess: false,
              showButton: true,
              buttonText: "Goto orders",
              onTap: () {
                Get.offAndToNamed(Routes.ORDER_HISTORY);
              }
          ).showSnackBar();
        }
        return result;
      }
    } catch (e) {
      // Handle any potential exceptions
      if (kDebugMode) {
        print("Error fetching order history: $e");
      }
    } finally {
      isLoading.value = false;
    }
    return false;
  }

}
