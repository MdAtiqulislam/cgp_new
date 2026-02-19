import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/app_button.dart';
import '../../../../common_widgets/base_screen.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/body_text.dart';
import '../../../../constraints/dimensions.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? loadingScreen()
          : BaseScreen(
              showLoading: controller.isLoading.value,
              body: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(children: [
                  AppButton(
                    text: "Create Account",
                    onTap: () {
                      Get.toNamed(Routes.REGISTRATION);
                    },
                    bgColor: AppColors.primaryColor,
                    showBorder: false,
                  ),
                  SizedBox(
                    height: AppDimensions.sectionPadding.h,
                  ),
                  const BodyText(
                    text: "Already have an account?",
                  ),
                  SizedBox(
                    height: AppDimensions.widgetPadding.h,
                  ),
                  AppButton(
                    text: "Login",
                    onTap: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    bgColor: AppColors.primaryColor,
                  ),
                  SizedBox(
                    height: AppDimensions.sectionPadding.h,
                  ),
                  /*AppButton(
                  text: "Access Without account",
                  onTap: () {
                    Get.offAllNamed(Routes.HOME);
                  },
                  bgColor: AppColors.secondaryColor,
                ),*/
                ]),
              ),),
    );
  }

  Widget loadingScreen() {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          minimal: true,
        ),
        body: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeaderText(
                text: "Welcome to TradeBar",
                color: AppColors.primaryColor,
                size: 20,
                align: TextAlign.start,
              ),
              SizedBox(
                height: AppDimensions.sectionPadding.h * 2,
              ),
              Container(
                  width: 200.sp,
                  height: 200.sp,
                  margin: EdgeInsets.symmetric(
                      horizontal: AppDimensions.horizontalPadding.w),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(AppImagePath.appIcon)),
            ],
          ),
        ),
      ),
    );
  }
}
