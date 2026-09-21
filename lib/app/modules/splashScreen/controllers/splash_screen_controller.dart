import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

import 'package:cgp/app/modules/splashScreen/models/appversion_model.dart';
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/local_services.dart';
import 'package:cgp/services/pusher_services.dart';
import 'package:cgp/services/remote_services.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/body_text.dart';
import '../../../../constraints/header_text.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../services/notification_services.dart';

class SplashScreenController extends GetxController {
  var isLoading = true.obs;
  var appVersionModel = AppVersionModel().obs;
  var token = "".obs;

  final NotificationServices notificationServices = NotificationServices();

  @override
  Future<void> onInit() async {
    super.onInit();
    token.value = await LocalServices.getToken() ?? "";
    getAppVersion();
  }

  @override
  void onReady() {
    super.onReady();
    // ✅ Context safe
    if (Get.context != null) {
      notificationServices.setupInterruptMessage(Get.context!);
    }
  }

  // ================= LOGIN CHECK =================

  Future<void> getLoginStatus() async {
    final token = await LocalServices.getToken();

    if (token != null && token.isNotEmpty) {
      final user = await LocalServices.getUser();

      if (user != null) {
        Get.put(PusherService(user.userId.toString()));
      }

      isLoading.value = false;
      Get.offAllNamed(Routes.TRANSPORTATION);
    } else {
      isLoading.value = false;
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  // ================= VERSION CHECK =================

  Future<void> getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      var currentAppVersion = packageInfo.version;

      if (kDebugMode) {
        print("Current Version: $currentAppVersion");
      }

      var response = await RemoteServices.getRequestForResponseBody(
        endPoint: APIEndPoints.appVersionEndpoint,
      );

      if (response != null) {
        appVersionModel.value = AppVersionModel.fromJson(response);
        checkAppVersion(currentAppVersion);
      } else {
        getLoginStatus();
      }
    } catch (e) {
      debugPrint("Version check error: $e");
      getLoginStatus();
    }
  }

  void checkAppVersion(String currentVersion) {
    if (Platform.isIOS) {
      if (currentVersion == appVersionModel.value.iosVersion ||
          currentVersion == appVersionModel.value.iosTestVersion) {
        getLoginStatus();
      } else {
        showForceUpdateDialog();
      }
    } else {
      if (currentVersion == appVersionModel.value.androidVersion ||
          currentVersion == appVersionModel.value.androidTestVersion) {
        getLoginStatus();
      } else {
        showForceUpdateDialog();
      }
    }
  }

  // ================= FORCE UPDATE =================

  void showForceUpdateDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: HeaderText(
              text: appVersionModel.value.majorMsg?.title ?? "Update Required",
              size: 18,
              color: AppColors.primaryColor,
            ),
            content: BodyText(
              text: appVersionModel.value.majorMsg?.msg ??
                  "Please update the app to continue.",
              maxLine: 5,
              size: 14,
            ),
            actions: [
              MaterialButton(
                color: AppColors.primaryColor,
                textColor: Colors.white,
                onPressed: () async {
                  if (Platform.isAndroid) {
                    final url = Uri.parse(
                        appVersionModel.value.majorMsg?.url?.apk ?? "");
                    await launchUrl(url,
                        mode: LaunchMode.externalApplication);
                  } else {
                    final url = Uri.parse(
                        appVersionModel.value.majorMsg?.url?.ios ?? "");
                    await launchUrl(url,
                        mode: LaunchMode.externalApplication);
                  }
                },
                child: const Text("Update"),
              ),
              MaterialButton(
                textColor: AppColors.primaryColor,
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text("Exit"),
              ),
            ],
          ),
        );
      },
    );
  }

  // ================= SAFE CACHE CLEAR (OPTIONAL) =================

/*  Future<void> clearTemporaryCache() async {
    try {
      final cacheDir = await getTemporaryDirectory();
      if (cacheDir.existsSync()) {
        await cacheDir.delete(recursive: true);
      }
    } catch (e) {
      debugPrint("Temp cache delete error: $e");
    }
  }*/
}