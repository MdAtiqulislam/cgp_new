
import 'package:cgp/common_widgets/app_button.dart';
import 'package:cgp/common_widgets/base_screen.dart';
import 'package:cgp/common_widgets/custom_text_field.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {

  final GlobalKey<FormState>_formKey=GlobalKey();

  ResetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(()=>BaseScreen(
      showLoading: controller.isLoading.value,
      showSlider: true,
      bottomNavBar: bottomNavBar(),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderText(
              text: "Enter your Email address",
              size: 20,
              color: AppColors.bodyTextColor,
              align: TextAlign.start,
            ),
            SizedBox(
              height: AppDimensions.sectionPadding.h,
            ),
            CustomTextField(
              levelText: "Email",
              hintText: "Type Email address",
              isRequired: true,
              controller: controller.emailController,
              validatorText: "required",
            ),
            SizedBox(
              height: AppDimensions.sectionPadding.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: const BodyText(
                text:
                "We will send a six digit OTP to your Email.\nPlease type the OTP to reset your password",
                align: TextAlign.start,
              ),
            ),
            SizedBox(
              height: AppDimensions.sectionPadding * 2.h,
            ),
            AppButton(
              text: "Next",
              onTap: () {
                if(_formKey.currentState?.validate()??false){
                  controller.getOtp();
                }
              },
              bgColor: AppColors.primaryColor,
            )
          ],
        ),
      ),
    ),);
  }
  Widget bottomNavBar() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding.w,
          vertical: AppDimensions.verticalPadding.h),
      child: InkWell(
        onTap: (){
          Get.back();
        },
        child: Row(
          children: [
             const Icon(Icons.arrow_back,color: AppColors.primaryColor,),
            SizedBox(
              width: AppDimensions.widgetPadding.w,
            ),
            HeaderText(
              text: "Back",
              color: AppColors.primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
