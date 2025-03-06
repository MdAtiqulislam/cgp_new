import 'package:cgp/app/modules/orderHistory/controllers/order_history_controller.dart';
import 'package:cgp/app/modules/orderHistory/models/order_history_model.dart';
import 'package:cgp/app/modules/splashScreen/controllers/splash_screen_controller.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/models/customer_model.dart';
import 'package:cgp/models/logged_in_customer_profile_model.dart';
import 'package:cgp/other_controllers/floating_controller.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/notification_services.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../app/modules/profile/controllers/profile_controller.dart';
import '../app/routes/app_pages.dart';
import '../common_widgets/app_button.dart';
import '../constraints/app_colors.dart';
import '../constraints/app_strings.dart';
import '../constraints/body_text.dart';
import '../constraints/dimensions.dart';
import '../constraints/header_text.dart';
import '../services/local_services.dart';

class MyDrawerController extends GetxController {
  var isLoading = false.obs;
  var customer = CustomerModel().obs;
  var onGoingRequests = OrderHistoryModel().obs;
  var loggedInCustomerProfileModel=LoggedInCustomerProfileModel().obs;

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
        CustomSnackBar(
          msg: "You have successfully logged out. See you next time!",
          isSuccess: true
        ).showSnackBar();
      }
    } finally {
      Get.put(SplashScreenController()).token.value="";
      Get.put(SplashScreenController()).isLoading.value=false;
      Get.offAllNamed(Routes.SPLASH_SCREEN);
      Get.find<FloatingController>().hideFloating();
      LocalServices.deleteData();
      isLoading.value = false;
    }
  }

  void requestForTransportation() async {
    isLoading.value = true;

    if(!await pendingOrder()){
      Get.back();
      Get.toNamed(Routes.TRANSPORTATION);
    }


  }

/*  bool checkRequest(Rx<OrderHistoryModel> onGoingRequests) {
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
  }*/

  Future<bool> pendingOrder() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.loggedInCustomerProfile;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        loggedInCustomerProfileModel.value=LoggedInCustomerProfileModel.fromJson(response);

        await LocalServices().storeUser(loggedInCustomerProfileModel.value.data??CustomerModel());
       // var result = checkRequest(onGoingRequests);
        if (loggedInCustomerProfileModel.value.data?.ongoingDelivery!=null) {
          CustomSnackBar(
              msg: "You have an active order right now.\nPlease complete the order first.",
              isSuccess: false,
              showButton: true,
              buttonText: "Goto orders",
              onTap: () {
                Get.back();
                Get.put(OrderHistoryController()).getOrderHistory();;
                Get.toNamed(Routes.ORDER_HISTORY);
              }
          ).showSnackBar();
        }
        return loggedInCustomerProfileModel.value.data?.ongoingDelivery!=null;
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




  void deleteAccount() {
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
                    const HeaderText(text: "Are you sure you want to Remove your account?",maxLine: 3,),
                    Divider(),
                    SizedBox(height: 16.h,),
                    const BodyText(text: "If you remove the account, all of your information will be lost permanently.",maxLine: 10,),
                    SizedBox(height: 32.h //AppDimensions.sectionPaddingVer,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(
                          text: "Cancel",
                          showBorder: true,
                          onTap: () {
                            Get.back();
                          },
                          bgColor: AppColors.primaryColor,
                        ),
                        SizedBox(width: 16.w //AppDimensions.widgetPaddingHor,
                        ),
                        AppButton(
                          text: "Confirm",
                          borderColor: AppColors.primaryColor,
                          showBorder: true,
                          onTap: () async {
                            Get.back();
                            completeRemoveAccount();
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

  void completeRemoveAccount()async {
    isLoading.value=true;
    var endPoint = APIEndPoints.removeAccount;
    try {
      var response=await RemoteServices.deleteRequest(endPoint: endPoint);
      if(response!=null){
        CustomSnackBar(
            msg: response["message"],
            isSuccess: true
        ).showSnackBar();
      }else{
        CustomSnackBar(
            msg: AppStrings.httpErrorMSG.value,
            isSuccess: false
        ).showSnackBar();
      }
    } finally {
      isLoading.value=false;
      LocalServices.deleteData();
      Get.offAllNamed(Routes.LOGIN);
    }


  }

}
