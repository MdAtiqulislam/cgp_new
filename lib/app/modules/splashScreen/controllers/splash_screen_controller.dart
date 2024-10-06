import 'dart:io';
import 'package:cgp/app/modules/splashScreen/models/appversion_model.dart';
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/local_services.dart';
import 'package:cgp/services/pusher_services.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/body_text.dart';
import '../../../../constraints/header_text.dart';
import '../../../../services/notification_services.dart';
import 'package:path_provider/path_provider.dart';

class SplashScreenController extends GetxController {
  var isLoading = true.obs;
  var appVersionModel = AppVersionModel().obs;

  NotificationServices notificationServices = NotificationServices();

  @override
  void onInit() {
    super.onInit();
    notificationServices.setupInterruptMessage(Get.context!);
    //  getLoginStatus();
    getAppVersion();
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> getLoginStatus() async {
    final token = await LocalServices.getToken();
    isLoading.value =
        false; // Set isLoading to false regardless of token presence
    if (token != null) {
      //Get.offAllNamed(Routes.HOME); // Navigate to HOME if token exists
      await LocalServices.getUser().then((value) {
        Get.put(PusherService(value!.userId.toString()));
      });
      Get.offAndToNamed(Routes.TRANSPORTATION);
    }
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var currentAppVersion = packageInfo.version;
    print("currentAppVersion:$currentAppVersion");
    var endPoint = APIEndPoints.appVersionEndpoint;
    try {
      var response =
          await RemoteServices.getRequestForResponseBody(endPoint: endPoint);
      if (response != null) {
        appVersionModel.value = AppVersionModel.fromJson(response);
        checkAppVersion(currentAppVersion);
        print("Ios test version: ${appVersionModel.value.iosTestVersion}");
      }
    } finally {}
  }

  void checkAppVersion(String currentAppVersion) {
    if (Platform.isIOS) {
      if (currentAppVersion == appVersionModel.value.iosVersion ||
          currentAppVersion == (appVersionModel.value.iosTestVersion??"1.0.6")) {
        getLoginStatus();
      }else{
        showForceUpdateDialog();
      }
    } else if (Platform.isAndroid) {
      if (currentAppVersion == (appVersionModel.value.androidVersion??"1.0.2") ||
          currentAppVersion == (appVersionModel.value.androidTestVersion??"1.0.2")) {
        getLoginStatus();
      }else{
        showForceUpdateDialog();
      }
    }
  }

  void showForceUpdateDialog() {
    _deleteCacheDir();
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            titlePadding: const EdgeInsets.all(0),
            title: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(AppDimensions.borderRadius.r),topRight: Radius.circular(AppDimensions.borderRadius.r))
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0.h,horizontal: AppDimensions.horizontalPadding.w),
                child: HeaderText(
                  text: appVersionModel.value.majorMsg?.title ?? "",
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
            content: BodyText(
              text: appVersionModel.value.majorMsg?.msg ?? "",
              maxLine: 10,
              size: 14,
            ),
            actions: <Widget>[
              MaterialButton(
                autofocus: true,
                textColor: Colors.white,
                color: AppColors.primaryColor,
                focusColor: AppColors.primaryColor,
                splashColor: AppColors.primaryColor,
                focusElevation: 5,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                // color: AppColors.mainColorRed,
                onPressed: () {
                  if (Platform.isAndroid) {
                    final appId = appVersionModel.value.majorMsg!.url!.apk!
                        .split("id")[1];
                    final url = Uri.parse("market://details?id$appId");
                    launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  }
                  else  if (Platform.isIOS) {
                    final url = Uri.parse(
                        appVersionModel.value.majorMsg!.url!.ios.toString());
                    launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  }
                },
                child: const Text(
                  "Update",
                ),
              ),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textColor: AppColors.primaryColor,
                  splashColor: AppColors.primaryColor,
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text("Cancel"))
            ],
          ),
        );
      },
    );

  }

  Future<void> _deleteCacheDir() async {
    isLoading.value = true;
    try {
      final cacheDir = await getTemporaryDirectory();
      if (cacheDir.existsSync()) {
        cacheDir.deleteSync(recursive: true);
      }
      final appDir = await getApplicationSupportDirectory();
      if (appDir.existsSync()) {
        appDir.deleteSync(recursive: true);
         }
    } finally {
      isLoading.value = false;
      LocalServices.deleteData();
    }
  }
}
