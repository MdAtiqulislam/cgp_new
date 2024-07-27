import 'dart:async';

import 'package:cgp/app/modules/verifyOTP/models/verify_otp_model.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/models/customer_model.dart';
import 'package:cgp/models/login_model.dart';
import 'package:cgp/services/local_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_snackbar.dart';
import '../../../../services/api_endpoints.dart';
import '../../../../services/notification_services.dart';
import '../../../../services/remote_services.dart';
import '../../../routes/app_pages.dart';
import '../../password/controllers/password_controller.dart';

class VerifyOTPController extends GetxController {
  var isLoading = false.obs;
  var isValidate = false.obs;
  var wrongOTP = false.obs;
  var resendOtpTime = 6.obs;
  var otp = "";
  var verifyOTPModel = VerifyOtpModel();
  var loginModel = LoginModel();

  var deviceToken="".obs;

  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final c4 = TextEditingController();
  final c5 = TextEditingController();
  final c6 = TextEditingController();

  Timer? timer;

  var isRegistration = false;
  var isLogin = false;
  var isResetPassword = false;

  String sessionId = "";

  var email="".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    startTimer();
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

  void checkOtpLength(String? value) {
    if ((value ?? "").length >= 6) {
      c1.text = value![0];
      c2.text = value[1];
      c3.text = value[2];
      c4.text = value[3];
      c5.text = value[4];
      c6.text = value[5];
      //verifyOTP();
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendOtpTime.value > 0) {
        resendOtpTime.value--;
      }
      if (resendOtpTime.value <= 0) {
        resendOtpTime.value = 0;
        timer.cancel();
      }
      if (isValidate.value) {
        timer.cancel();
      }
    });
  }

  Future<void> resendOTP() async {
    isLoading.value = true;
    const endPoint = APIEndPoints.reSendOTP;
    final body = {
      "session_id": sessionId,
    };

    try {
      final response = await RemoteServices.postRequest(endPoint: endPoint, body: body);
      if (response != null) {
        isLoading.value = false;
        resendOtpTime.value = 180;
        startTimer();
        CustomSnackBar(
          isSuccess: true,
          msg: response["message"],
        ).showSnackBar();
      } else {
        isLoading.value = false;
        CustomSnackBar(
          isSuccess: false,
          msg: AppStrings.httpErrorMSG.value,
        ).showSnackBar();
      }
    } catch (e) {
      isLoading.value = false;
      CustomSnackBar(
        isSuccess: false,
        msg: '$e',
      ).showSnackBar();
    }
  }


  Future<void> verifyOTP() async {
    isLoading.value = true;
    final endPoint = isLogin ? APIEndPoints.loginVerification : APIEndPoints.emailVerification;
    otp = c1.text + c2.text + c3.text + c4.text + c5.text + c6.text;
    final body = {
      "session_id": sessionId,
      "otp": otp,
       "device_token": deviceToken.value,
    };

    try {
      final response = await RemoteServices.postRequest(endPoint: endPoint, body: body);
      if (response != null) {
        isValidate.value = true;
        isLoading.value = false;
        if (isLogin) {
          loginModel = LoginModel.fromJson(response);
          await LocalServices.storeToken(loginModel.data?.accessToken ?? "");
          await LocalServices().storeUser(loginModel.data?.customer??CustomerModel());
        } else {
          verifyOTPModel = VerifyOtpModel.fromJson(response);
        }
      } else {
        CustomSnackBar(isSuccess: false, msg: AppStrings.httpErrorMSG.value).showSnackBar();
        isLoading.value = false;
        isValidate.value = false;
      }
    } catch (e) {
      CustomSnackBar(isSuccess: false, msg: '$e').showSnackBar(); // Handle error
      isLoading.value = false;
      isValidate.value = false;
    }
  }


  void handelNext() {
    if (isLogin) {
      Get.offAllNamed(Routes.TRANSPORTATION);
    }else if(isResetPassword){
      Get.put(PasswordController());
      Get.find<PasswordController>().isRegistration.value = isRegistration;
      Get.find<PasswordController>().isResetPassword = isResetPassword;
      Get.find<PasswordController>().otp = otp;
      Get.find<PasswordController>().sessionId.value =
          verifyOTPModel.data?.sessionId ?? "";
      Get.toNamed(Routes.PASSWORD);
    }

    else{
      Get.put(PasswordController());
      Get.find<PasswordController>().isRegistration.value = isRegistration;
      Get.find<PasswordController>().sessionId.value =
          verifyOTPModel.data?.sessionId ?? "";
      Get.toNamed(Routes.PASSWORD);
    }


  }
}
