import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/common_widgets/app_button.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_check_box.dart';
import 'package:cgp/common_widgets/custom_loading_screen.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/complete_registration_controller.dart';

class CompleteRegistrationView extends GetView<CompleteRegistrationController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          appBar:  CustomAppBar(),
          body: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.horizontalPadding.w),
                  child: Container(
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderText(
                          text: "Congratulations!",
                          color: AppColors.primaryColor,
                          size: 20,
                          fontWeight: FontWeight.w700,
                          align: TextAlign.start,
                        ),
                        SizedBox(
                          height: AppDimensions.contentPadding.h,
                        ),
                        BodyText(
                          text: "Your profile has been created",
                          size: 16,
                          align: TextAlign.start,
                        ),
                        SizedBox(
                          height: AppDimensions.sectionPadding * 3.h,
                        ),
                        BodyText(
                          text:
                              "Set your preferences which will be shown on your timeline.\nTap to select. You can select multiple options.",
                          color: AppColors.primaryColor,
                          align: TextAlign.start,
                        ),
                        SizedBox(
                          height: AppDimensions.sectionPadding.h,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.checkBoxItems.length,
                            itemBuilder: (buildContext, index) {
                              return Obx(() => CustomCheckBox(
                                label: controller.checkBoxItems[index],
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                value: controller.checkBoxValue[index],
                                onChanged: (value) {
                                  controller.checkBoxValue[index] = value ?? false;
                                },
                              ));
                            }),
                        SizedBox(height: AppDimensions.sectionPadding*2.h,),
                        AppButton(text: "Skip", onTap: (){
                          Get.offAllNamed(Routes.HOME);
                        },showBorder: true,),
                        SizedBox(height: AppDimensions.sectionPadding.h,),
                        AppButton(text: "Next", onTap: (){
                          Get.offAllNamed(Routes.HOME);
                        },bgColor: AppColors.primaryColor,)
                      ],
                    ),
                  ),
                ),
              ),

              if(controller.isLoading.value)const LoadingScreen()
            ],
          ),
        ),
      ),
    );
  }
}
