import 'package:cgp/app/modules/addOrUpdateAddress/controllers/add_or_update_address_controller.dart';
import 'package:cgp/common_widgets/custom_check_box.dart';
import 'package:cgp/common_widgets/custom_drop_down_field.dart';
import 'package:cgp/common_widgets/custom_phone_text_field.dart';
import 'package:cgp/common_widgets/custom_radio_button.dart';
import 'package:cgp/models/single_address_model.dart';
import 'package:cgp/utils/enams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/app_button.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/custom_text_field.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../constraints/header_text.dart';

class AddOrUpdateAddressForm extends GetView<AddOrUpdateAddressController> {
  final String formType;
  final SingleAddressModel? address;

  AddOrUpdateAddressForm({super.key, required this.formType, this.address});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: Get.width,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPadding.w,
                  vertical: AppDimensions.contentPadding.h),
              width: Get.width,
              color: AppColors.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderText(
                    text: "$formType Address",
                    color: Colors.white,
                  ),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(AppImagePath.cancelIcon))
                ],
              ),
            ),
            Obx(
              () => Flexible(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.horizontalPadding.w),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: AppDimensions.sectionPadding.h,
                              ),
                             if(formType=="Add New") CustomDropDownField(
                                isRequired: true,
                                  validatorText: "required",
                                  lavelText: "Address Type",
                                  hintText: "Address Type",
                                  itemList: controller.addressTypeList,
                                  onChange: (value){
                                  controller.selectedAddressType.value=value??"";
                                  },

                              ),
                              if(formType=="Add New") SizedBox(height: AppDimensions.contentPadding.h,),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      levelText: "First Name",
                                      hintText: "First Name",
                                      isRequired: true,
                                      validatorText: "Required",
                                      controller:
                                          controller.firstNameController,
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppDimensions.contentPadding.w,
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      levelText: "Last Name",
                                      hintText: "Last Name",
                                      isRequired: true,
                                      validatorText: "Required",
                                      controller: controller.lastNameController,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: AppDimensions.contentPadding.h,
                              ),
                              CustomPhoneTextField(
                                controller: controller.phoneController,
                              ),
                              SizedBox(
                                height: AppDimensions.contentPadding.h,
                              ),
                              CustomTextField(
                                levelText: "Country",
                                hintText: "Country",
                                isRequired: true,
                                //  isEnable: false,
                                validatorText: "Required",
                                controller: controller.countryController,
                              ),
                              SizedBox(
                                height: AppDimensions.contentPadding.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      levelText: "State",
                                      hintText: "State",
                                      // isRequired: true,
                                      //   validatorText: "Required",
                                      controller: controller.stateController,
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppDimensions.contentPadding.w,
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      levelText: "City/ Province",
                                      hintText: "City/ Province",
                                      //  isRequired: true,
                                      // validatorText: "Required",
                                      controller: controller.cityController,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: AppDimensions.contentPadding.h,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      levelText: "Road",
                                      hintText: "Road",
                                      // isRequired: ,
                                      //validatorText: "Required",
                                      controller: controller.roadController,
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppDimensions.contentPadding.w,
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      levelText: "Block",
                                      hintText: "Block",
                                      // isRequired: true,
                                      //  validatorText: "Required",
                                      controller: controller.blockController,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: AppDimensions.contentPadding.h,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      levelText: "House",
                                      hintText: "House",
                                      // isRequired: true,
                                      // validatorText: "Required",
                                      controller: controller.houseController,
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppDimensions.contentPadding.w,
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      levelText: "Zip",
                                      hintText: "Zip",
                                      //  isRequired: true,
                                      //  isEnable: false,
                                      //   validatorText: "Required",
                                      controller: controller.zipController,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: AppDimensions.contentPadding.h,
                              ),
                              CustomTextField(
                                levelText: "Address",
                                hintText: "Address",
                                maxLine: 3,
                                minLine: 2,
                                isRequired: true,
                                // isEnable: false,
                                validatorText: "Required",
                                controller: controller.addressController,
                              ),
                              SizedBox(
                                height: AppDimensions.sectionPadding.h,
                              ),
                              CustomCheckBox(
                                  padding: EdgeInsets.zero,
                                  value: controller.isDefault.value,
                                  title: const HeaderText(text: "Make as Default",align: TextAlign.start,color: AppColors.primaryColor,),
                                  onChanged: (value){
                                    controller.isDefault.value=value;

                                  }),
                              SizedBox(height: AppDimensions.sectionPadding.h,),
                              AppButton(
                                text: "Submit",
                                onTap: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    if (formType == "Update") {
                                      controller.updateAddress(
                                          id: (address?.id ?? "").toString(),
                                          lan: address?.longitude.toString(),
                                          lat: address?.latitude.toString(),
                                      );
                                    }else{
                                      controller.saveAddress();
                                    }
                                  }
                                },
                                bgColor: AppColors.primaryColor,
                              ),
                              SizedBox(
                                height: AppDimensions.sectionPadding.h,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (controller.isLoading.value) const LoadingScreen()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
