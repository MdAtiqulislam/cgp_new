import 'package:cgp/app/modules/addOrUpdateAddress/controllers/add_or_update_address_controller.dart';
import 'package:cgp/app/modules/addOrUpdateAddress/views/add_or_update_address_form.dart';
import 'package:cgp/common_widgets/app_button.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:cgp/models/single_address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/custom_text_field.dart';

class SelectedAddressSection extends GetView<AddOrUpdateAddressController> {
  
   const SelectedAddressSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>  ListView.separated(
              itemCount: controller.selectedAddresses.value.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (buildContext, index) {
                return singleAddressSection(address: controller.selectedAddresses[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
    );
  }

  Widget singleAddressSection({required SingleAddressModel address}) {
    return Container(
      clipBehavior: Clip.hardEdge,
     decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: (address.isDefault ?? false)
                    ? Colors.green.shade100
                    : Colors.white,
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
          color: Colors.white),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){
            controller.selectedAddress.value=address;
            controller.makeDefault(id:(address.id??"").toString());
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (address.isDefault ?? false)
                  Padding(
                    padding: EdgeInsets.only(top: AppDimensions.contentPadding.h),
                    child: const Icon(
                      Icons.circle,
                      size: 15,
                      color: AppColors.successColor,
                    ),
                  ),
                SizedBox(
                  width: AppDimensions.contentPadding.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText(
                          text:
                              "${address.firstName ?? ""} ${address.lastName ?? ""}"),
                      BodyText(
                        text: "${address.address ?? ""}"
                            " ${address.city == null ? "" : "${address.city},"}"
                            " ${address.state == null ? "" : "${address.state},"}"
                            " ${address.countryId == null ? "" : "${address.countryId},"}",
                        size: 12,
                        maxLine: 5,
                        align: TextAlign.start,
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      controller.setAddressData(address: address);
                      Get.bottomSheet(
                        isScrollControlled: true,
                        ignoreSafeArea: false,
                        AddOrUpdateAddressForm(formType:"Update",address: address,),
                      );
                    },
                    icon: Image.asset(
                      AppImagePath.editIcon,
                      scale: 2,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

/*  Widget contactInfoSection() {
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
                  const HeaderText(
                    text: "Update Address",
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
            Obx(()=>Flexible(
              child: Stack(children: [
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
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  levelText: "First Name",
                                  hintText: "First Name",
                                  isRequired: true,
                                  validatorText: "Required",
                                  controller: controller.firstNameController,
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
                          CustomTextField(
                            levelText: "Phone/ Mobile",
                            hintText: "Phone/ Mobile",
                            isRequired: true,
                            validatorText: "Required",
                            textInputType: TextInputType.phone,
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
                              SizedBox(width: AppDimensions.contentPadding.w,),
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
                          SizedBox(height: AppDimensions.contentPadding.h,),
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
                          AppButton(text: "Submit", onTap: (){
                            if(_formKey.currentState?.validate()??false){

                            }
                          },bgColor: AppColors.primaryColor,)
                        ],
                      ),
                    ),
                  ),),
                if(controller.isLoading.value)const LoadingScreen()

              ],),
            ),),
          ],
        ),
      ),
    );
  }*/
}
