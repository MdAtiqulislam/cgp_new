import 'package:cgp/common_widgets/app_button.dart';
import 'package:cgp/common_widgets/base_screen.dart';
import 'package:cgp/common_widgets/custom_loading_screen.dart';
import 'package:cgp/common_widgets/custom_phone_text_field.dart';
import 'package:cgp/common_widgets/custom_text_field.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../constraints/header_text.dart';
import '../../../routes/app_pages.dart';
import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  RegistrationView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseScreen(
        showSlider: false,
        bottomNavBar: bottomNavBar(),
        body: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    levelText: "First Name",
                    hintText: "Mr.",
                    isRequired: true,
                    controller: controller.firstNameController,
                    validatorText: "Required",
                  ),
                  SizedBox(
                    height: AppDimensions.widgetPadding.h,
                  ),
                  CustomTextField(
                    levelText: "Last Name",
                    hintText: "xyz",
                    isRequired: true,
                    controller: controller.lastNameController,
                    validatorText: "Required",
                  ),
                  SizedBox(
                    height: AppDimensions.widgetPadding.h,
                  ),
                  /*CustomDropDownField(
                      labelText: "Gender",
                      itemList: ["Male", "Female"],
                      suffix: Image.asset(AppImagePath.dropdownIcon),
                      onChange: (value) {}),
                  SizedBox(
                    height: AppDimensions.widgetPadding.h,
                  ),*/
                  CustomTextField(
                    levelText: "Email",
                    hintText: "xyz@mail.com",
                    isRequired: true,
                    controller: controller.emailController,
                    validatorText: "Required",
                  ),
                              SizedBox(
                    height: AppDimensions.widgetPadding.h,
                  ),
                 CustomPhoneTextField(
                   controller: controller.phoneController,
                 ),

                 /* SizedBox(
                    height: AppDimensions.widgetPadding.h,
                  ),
                  CustomTextField(
                    levelText: "Set Password",
                    hintText: "Password",
                    isPassword: !controller.showPassword.value,
                    isRequired: true,
                    controller: controller.passwordNameController,
                    validatorText: "Required",
                    suffix: ShowHidePasswordButton(
                      showPassword: controller.showPassword.value,
                      onTap: () {
                        controller.showPassword.value =
                            !controller.showPassword.value;
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
                    isRequired: true,
                    controller: controller.confirmPasswordNameController,
                    validatorText: "Required",
                    suffix: ShowHidePasswordButton(
                      showPassword: controller.showPassword.value,
                      onTap: () {
                        controller.showPassword.value =
                            !controller.showPassword.value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: AppDimensions.sectionPadding.h,
                  ),*/
                  SizedBox(
                    height: AppDimensions.widgetPadding.h,
                  ),
                  const BodyText(
                    text:
                        "Asterisk * mark indicates must fill up areas. Please use valid information for verification & Safety purpose.",
                    align: TextAlign.start,
                    fontWeight: FontWeight.w400,
                  ),
                  /*SizedBox(
                    height: AppDimensions.sectionPadding.h,
                  ),
                  HeaderText(
                    text: "Send OTP to your",
                    fontWeight: FontWeight.w500,
                    size: 16,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: AppDimensions.widgetPadding.h,),
                  Row(
                    children: [

                      Expanded(
                        child: CustomRadioListTile(
                          title: BodyText(text: controller.otpOptions[0],),
                            value: controller.otpOptions[0],
                            groupValue: controller.selectedOTPOption.value,
                            onChanged: (value){
                              controller.selectedOTPOption.value=value!;
                            },
                            leading: "leading"
                        ),
                      ),
                      Expanded(
                        child: CustomRadioListTile(
                          title:BodyText(text: controller.otpOptions[1].toString(),) ,
                            value: controller.otpOptions[1],
                            groupValue: controller.selectedOTPOption.value,
                            onChanged: (value){
                              controller.selectedOTPOption.value=value!;
                            },
                            leading: ""
                        ),
                      ),

                    ],
                  ),*/
                  SizedBox(
                    height: AppDimensions.sectionPadding.h,
                  ),
                  AppButton(
                    text: "Register",
                    onTap: () {

                      if(_formKey.currentState?.validate()??false){
                        controller.signUp();
                      }

                    /*  Get.put(VerifyOTPController());
                      Get.find<VerifyOTPController>().isRegistration = true;
                      Get.toNamed(Routes.VERIFY_O_T_P);*/
                    },
                    bgColor: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
            if(controller.isLoading.value)const LoadingScreen()
          ],
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
          const BodyText(text: "Already have an account? "),
          SizedBox(
            width: AppDimensions.widgetPadding.w,
          ),
          InkWell(
            onTap: (){
              Get.offAndToNamed(Routes.LOGIN);
            },
            child: const HeaderText(
              text: "Login",
              color: AppColors.primaryColor,
            ),
          )
        ],
      ),
    );
  }

}
