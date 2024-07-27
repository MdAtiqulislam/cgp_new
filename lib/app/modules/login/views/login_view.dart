import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/common_widgets/app_button.dart';
import 'package:cgp/common_widgets/base_screen.dart';
import 'package:cgp/common_widgets/custom_text_field.dart';
import 'package:cgp/common_widgets/show_hide_password_button.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseScreen(
        showLoading: controller.isLoading.value,
        bottomNavBar: bottomNavBar(),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderText(
                        text: "Log in to your Account",
                        size: 20,
                        color: AppColors.bodyTextColor,
                      ),
                      SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                      CustomTextField(
                        levelText: "Phone/ Email",
                        hintText: "Phone/ Email",
                        isRequired: true,
                        validatorText: "Required",
                        controller: controller.emailController,
                      ),
                      BodyText(text: "Phone: 0412345678"),
                      SizedBox(
                        height: AppDimensions.widgetPadding.h,
                      ),
                      CustomTextField(
                        levelText: "Password",
                        hintText: "Password",
                        isPassword: !controller.showPassword.value,
                        isRequired: true,
                        validatorText: "required",
                        controller: controller.passwordController,
                        suffix: ShowHidePasswordButton(
                          showPassword: controller.showPassword.value,
                          onTap: () {
                            controller.showPassword.value =
                                !controller.showPassword.value;
                          },
                        ),
                      ),
                      SizedBox(height: AppDimensions.widgetPadding.h),
                      InkWell(
                          onTap: () {
                            Get.toNamed(Routes.RESET_PASSWORD);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: AppDimensions.contentPadding.h,
                                horizontal: 5.w),
                            child: const BodyText(
                              text: "Forgot Password?",
                              size: 12,
                            ),
                          )),
                      SizedBox(
                        height: AppDimensions.sectionPadding * 3.h,
                      ),
                      AppButton(
                        text: "Next",
                        onTap: () {
                          // Get.offAllNamed(Routes.HOME);
                          if (_formKey.currentState?.validate() ?? false) {
                            controller.login();
                          }
                        },
                        bgColor: AppColors.primaryColor,
                        showBorder: false,
                      )
                    ]),
              ),
              // if(controller.isLoading.value)const LoadingScreen()
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavBar() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding.w,
          vertical: AppDimensions.verticalPadding.h),
      child: Row(
        children: [
          const BodyText(text: "Don't have an account? "),
          SizedBox(
            width: AppDimensions.widgetPadding.w,
          ),
          InkWell(
            onTap: (){
              Get.offAndToNamed(Routes.REGISTRATION);
            },
            child: HeaderText(
              text: "Register",
              color: AppColors.primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
