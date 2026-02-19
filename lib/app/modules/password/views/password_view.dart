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

import '../../../../common_widgets/show_hide_password_button.dart';
import '../controllers/password_controller.dart';

class PasswordView extends GetView<PasswordController> {
   PasswordView({super.key});
final GlobalKey<FormState>_formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      showSlider: true,
      showLoading: controller.isLoading.value,
      bottomNavBar: bottomNavBar(),
      body: Obx(() =>
          Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderText(
              text: "Set Password",
              size: 20,
              color: AppColors.bodyTextColor,
            ),
            SizedBox(
              height: AppDimensions.sectionPadding.h,
            ),
            CustomTextField(
              levelText:"New Password",
              hintText: "Password",
              isPassword: !controller.showPassword.value,
              isRequired: true,
              controller: controller.newPasswordController,
              validatorText: "required",
              suffix: ShowHidePasswordButton(
                showPassword: controller.showPassword.value,
                onTap: () {
                  controller.showPassword.value = !controller.showPassword.value;
                },
              ),
            ),
            SizedBox(
              height: AppDimensions.widgetPadding.h,
            ),
            CustomTextField(
              levelText: "Confirm Password",
              hintText: "Password",
              isPassword: !controller.showPassword.value,
              controller: controller.confirmPasswordController,
              validatorText: "required",
              isRequired: true,
              suffix: ShowHidePasswordButton(
                showPassword: controller.showPassword.value,
                onTap: () {
                  controller.showPassword.value = !controller.showPassword.value;
                },
              ),
            ),
            SizedBox(
              height: AppDimensions.sectionPadding.h,
            ),
            const BodyText(
              text:
              "Your password must be 8 digits.\nMust Contain one Capital letter, one small letter, one number & one mark.",
              align: TextAlign.start,
            ),
            SizedBox(height: AppDimensions.sectionPadding*3.h,),
            AppButton(text: "Next", onTap: (){
              if(controller.isRegistration.value){

                controller.setPassword();
               // Get.offAllNamed(Routes.COMPLETE_REGISTRATION);

              }else{
               controller.reSetPassword();
              }


            },bgColor: AppColors.primaryColor,)
          ],
        ),
      ),),
    );
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
             const Icon(Icons.home,color: AppColors.primaryColor,),
             SizedBox(
               width: AppDimensions.widgetPadding.w,
             ),
             const HeaderText(
               text: "Go to home",
               color: AppColors.primaryColor,
             )
           ],
         ),
       ),
     );
   }
}
