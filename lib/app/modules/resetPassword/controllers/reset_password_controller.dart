import 'package:cgp/app/modules/verifyOTP/controllers/verify_o_t_p_controller.dart';
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/models/otp_moddel.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  var otpModel=OtpModel();
  var isLoading=false.obs;

  var emailController=TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> getOtp() async {
    isLoading.value=true;
    const endPoint = APIEndPoints.forgotPassword;
    final body = {
      "identity": emailController.text,
    };

    try {
      final response = await RemoteServices.postRequest(endPoint: endPoint, body: body);
      if (response != null) {
        otpModel = OtpModel.fromJson(response);
        CustomSnackBar(
          isSuccess: true,
          msg: otpModel.message ?? "",
        ).showSnackBar();
        isLoading.value = false;
        Get.put(VerifyOTPController());
        Get.find<VerifyOTPController>().email.value=emailController.text;
        Get.find<VerifyOTPController>().isResetPassword=true;
        Get.find<VerifyOTPController>().isLogin=false;
        Get.find<VerifyOTPController>().isRegistration=false;
        Get.find<VerifyOTPController>().sessionId=otpModel.data?.sessionId??"";
        Get.toNamed(Routes.VERIFY_O_T_P);
      } else {
        CustomSnackBar(
          isSuccess: false,
          msg: AppStrings.httpErrorMSG.value,
        ).showSnackBar();
        isLoading.value = false;
      }
    } catch (e) {
      CustomSnackBar(
        isSuccess: false,
        msg: '$e',
      ).showSnackBar();
      isLoading.value = false;
    }
  }

}
