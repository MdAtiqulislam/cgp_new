
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/models/login_model.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/local_services.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../models/customer_model.dart';
import '../../../../services/notification_services.dart';

class PasswordController extends GetxController {

  var isRegistration = false.obs;
  var showPassword = false.obs;
  var isLoading = false.obs;
  var deviceToken = "".obs;

  var otp = "";
  var sessionId = "".obs;
  var loginModel=LoginModel();

  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  bool isResetPassword=false;

  @override
  void onInit() async{
    super.onInit();
    await NotificationServices().getDeviceToken().then((value){
      deviceToken.value=value;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> setPassword() async {
    isLoading.value = true;
    const endPoint = APIEndPoints.setPassword;
    final body = {
      "session_id": sessionId.value,
      "password": newPasswordController.text,
      "password_confirmation": confirmPasswordController.text,
      "device_token":deviceToken.value,
    };

    try {
      final response = await RemoteServices.postRequest(endPoint: endPoint, body: body);
      if (response != null) {
        isLoading.value = false;
        loginModel = LoginModel.fromJson(response);
        await LocalServices.storeToken(loginModel.data?.accessToken ?? "");
        await LocalServices().storeUser(loginModel.data?.customer??CustomerModel());
        Get.offAllNamed(Routes.TRANSPORTATION);
        CustomSnackBar(
          msg: response["message"],
          isSuccess: true,
        ).showSnackBar();
      } else {
        CustomSnackBar(
          msg: AppStrings.httpErrorMSG.value,
          isSuccess: false,
        ).showSnackBar();
        isLoading.value = false;
      }
    } catch (e) {
      CustomSnackBar(
        msg: '$e',
        isSuccess: false,
      ).showSnackBar();
      isLoading.value = false;
    }
  }


  Future<void> reSetPassword() async {
    isLoading.value = true;
    const endPoint = APIEndPoints.reSetPassword;
    final body = {
      "session_id": sessionId.value,
      "otp":otp,
      "password": newPasswordController.text,
      "password_confirmation": confirmPasswordController.text,
    };

    try {
      final response = await RemoteServices.postRequest(endPoint: endPoint, body: body);
      if (response != null) {
       // isLoading.value = false;
       // loginModel = LoginModel.fromJson(response);
       // await LocalServices.storeToken(loginModel.data?.accessToken ?? "");
        Get.offAllNamed(Routes.LOGIN);
        CustomSnackBar(
          msg: response["message"],
          isSuccess: true,
        ).showSnackBar();
      } else {
        CustomSnackBar(
          msg: AppStrings.httpErrorMSG.value,
          isSuccess: false,
        ).showSnackBar();
       // isLoading.value = false;
      }
    } catch (e) {
      CustomSnackBar(
        msg: '$e',
        isSuccess: false,
      ).showSnackBar();
      isLoading.value = false;
    }
  }
}
