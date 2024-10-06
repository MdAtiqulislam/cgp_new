import 'dart:convert';

import 'package:cgp/common_widgets/app_button.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_circle_avatar.dart';
import 'package:cgp/common_widgets/custom_loading_screen.dart';
import 'package:cgp/common_widgets/custom_phone_text_field.dart';
import 'package:cgp/common_widgets/custom_text_field.dart';
import 'package:cgp/common_widgets/my_drawer.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common_widgets/custom_drop_down_field.dart';
import '../../../../constraints/app_strings.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          minimal: false,
        ),
        drawer: MyDrawer(),
        body: Obx(()=>Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.horizontalPadding.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppDimensions.sectionPadding.h,
                    ),
                    userFormSection(),
                  ],
                ),
              ),
            ),
            if (controller.isLoading.value) const LoadingScreen()
          ],
        ),),
      ),
    );
  }

  Widget userFormSection() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          controller.base64Image.value.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: AppColors.borderColor,
                      color: Colors.black38,
                      border:
                          Border.all(color: AppColors.borderColor, width: 2)),
                  child: CustomCircleAvatar(
                    width: 100,
                    height: 100,
                    image: controller.customer.value.url ?? "",
                    bgColor: AppColors.primaryColor.withAlpha((.5*255).toInt()),
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: AppColors.borderColor,
                      color: Colors.black38,
                      border:
                          Border.all(color: AppColors.borderColor, width: 2)),
                  child: Container(
                    width: 80.r,
                    height: 80.r,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.memory(
                      base64Decode(controller.base64Image.value),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          SizedBox(
            height: AppDimensions.contentPadding.h,
          ),
          InkWell(
            onTap: () {
              Get.bottomSheet(choseImage());
            },
            child: const BodyText(
              text: "Change Picture",
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),
          HeaderText(
              text: "Customer ID: ${controller.customer.value.userId ?? ""}"),
          SizedBox(
            height: AppDimensions.sectionPadding.h,
          ),
          CustomTextField(
            hintText: "First Name",
            levelText: "First Name",
            isRequired: true,
            validatorText: "Required",
            controller: controller.firstNameController,
          ),
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),
          CustomTextField(
            hintText: "Last Name",
            levelText: "Last Name",
            isRequired: true,
            validatorText: "Required",
            controller: controller.lastNameController,
          ),
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),
          CustomPhoneTextField(
            controller: controller.phoneController,
          ),
          /*CustomTextField(
            hintText: "Phone",
            levelText: "Phone",
            isRequired: true,
            validatorText: "Required",
            controller: controller.phoneController,
          ),*/
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),
          CustomTextField(
            hintText: "Email",
            levelText: "Email",
            isRequired: true,
            validatorText: "Required",
            controller: controller.emailController,
          ),
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),
          CustomDropDownField(
              hintText: "Gender",
              lavelText: "Gender",
              isRequired: true,
              value: controller.selectedGender.toUpperCase(),
              itemList: controller.genders,
              onChange: (value) {
                controller.selectedGender = value ?? "";
              }),
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),
          InkWell(
            onTap: () {
              controller.selectDateOfBirth();
            },
            child: CustomTextField(
              levelText: "Date of Birth",
              hintText: "Date of Birth",
              isRequired: true,
              isEnable: false,
              validatorText: "Required",
              controller: controller.dateOfBirthController,
            ),
          ),
          SizedBox(
            height: AppDimensions.sectionPadding.h,
          ),
          AppButton(
            text: "Update",
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                controller.updateUser();
              }
            },
            bgColor: AppColors.primaryColor,
          ),
          SizedBox(
            height: AppDimensions.sectionPadding.h,
          ),
        ],
      ),
    );
  }

  Widget choseImage({CropStyle? cropStyle}) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15.r),
          topLeft: Radius.circular(15.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 32.h,
          ),
          const HeaderText(
            text: "Select an action",
            color: AppColors.primaryColor,
            size: 18,
          ),
          SizedBox(height: 32.h //AppDimensions.widgetPaddingVer,
              ),
          const Divider(
            thickness: 5,
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 32.h // AppDimensions.contentPaddingVer,
              ),
          Container(
            margin: const EdgeInsets.all(5),
            color: Colors.white,
            child: Material(
              child: InkWell(
                onTap: () {
                  controller.selectImage(
                      source: ImageSource.camera, cropStyle: cropStyle);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.w, // AppDimensions.horizontalPadding,
                      vertical: 24.h // AppDimensions.widgetPaddingVer
                      ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImagePath.cameraIcon,
                        height: 40.h,
                      ),
                      SizedBox(width: 24.w // AppDimensions.widgetPaddingHor,
                          ),
                      const HeaderText(text: "Open Camera"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
          // SizedBox(height: Dimensions.widgetPaddingVer,),
          Container(
            margin: const EdgeInsets.all(5),
            color: Colors.white,
            child: Material(
              child: InkWell(
                onTap: () {
                  controller.selectImage(
                      source: ImageSource.gallery, cropStyle: cropStyle);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.w, // AppDimensions.horizontalPadding,
                      vertical: 24.w //AppDimensions.widgetPaddingVer
                      ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImagePath.galleryIcon,
                        height: 40.h,
                      ),
                      SizedBox(width: 16.w // AppDimensions.widgetPaddingHor,
                          ),
                      const HeaderText(text: "Open Gallery"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h //AppDimensions.sectionPaddingVer,
              )
        ],
      ),
    );
  }
}
