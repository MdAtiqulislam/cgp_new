import 'package:cgp/common_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common_widgets/app_button.dart';
import '../../../../common_widgets/cart_page_header.dart';
import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../common_widgets/custom_circle_avatar.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../constraints/body_text.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../constraints/header_text.dart';
import '../controllers/set_location_controller.dart';

class SetLocationView extends GetView<SetLocationController> {
  SetLocationView({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar:  CustomAppBar(
          minimal: false,
          scaffoldKey: scaffoldKey,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: bottomNavBar(),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPadding.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CartPageHeader(
                      trailingText: "Location Preferences",
                      image: AppImagePath.colorLocationIcon,
                      title: "Select Location",
                    ),
                    cartInfoSection(),
                    SizedBox(
                      height: AppDimensions.sectionPadding.h,
                    ),
                    HeaderText(
                      text: "Set Your Location Preferences",
                      size: 12,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: AppDimensions.widgetPadding.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.horizontalPadding.w,
                          vertical: AppDimensions.contentPadding.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius:
                            BorderRadius.circular(AppDimensions.borderRadius.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.map,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(
                            width: AppDimensions.contentPadding.w,
                          ),
                          BodyText(text: "Select from Map")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppDimensions.widgetPadding.h,
                    ),
                    HeaderText(
                      text: "Select From Previous Location",
                      size: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    Divider(),
                    BodyText(
                      text: "You haven't any location Added",
                      size: 12,
                    ),
                    SizedBox(
                      height: AppDimensions.widgetPadding.h,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Get.bottomSheet(
                          isScrollControlled: true,
                          ignoreSafeArea: false,
                          addLocationForm(),
                        );
                      },
                      child: HeaderText(
                        text: "Add New",
                        color: Colors.white,
                      ),
                      color: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //  if (controller.isLoading.value) const LoadingScreen()
          ],
        ),
      ),
    );
  }

  Widget bottomNavBar() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding.w,
          vertical: AppDimensions.contentPadding.h),
      height: 70.h,
      width: Get.width,
      child: AppButton(
        bgColor: AppColors.inactiveColor,
        showBorder: false,
        text: "Select Location",
        onTap: () {
          // Get.toNamed(Routes.SET_LOCATION);
        },
      ),
    );
  }

  Widget billingAddressSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleAndSubTitle(
                  title: "Delivery Receiver",
                  subTitle: "Mr. xyz",
                  contentPadding: 10.w),
              titleAndSubTitle(
                  title: "Contact No",
                  subTitle: "+3998023",
                  contentPadding: 10.w),
              titleAndSubTitle(
                  title: "Payment Method",
                  subTitle: "N/A",
                  contentPadding: 10.w),
              titleAndSubTitle(
                  title: "Customer ID",
                  subTitle: "3998023",
                  contentPadding: 10.w),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              onTap: () {},
              child: Image.asset(
                AppImagePath.editIcon,
                height: 20,
              ),
            ),
            SizedBox(
              height: AppDimensions.sectionPadding.h,
            ),
            const InkWell(
              child: HeaderText(
                text: "Add Payment Card",
                color: AppColors.primaryColor,
                size: 14,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget deliveryAddressSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: HeaderText(
                text: "Your Location Distance",
                size: 14,
                fontWeight: FontWeight.w600,
                align: TextAlign.start,
              ),
            ),
            BodyText(
              text: "N/A",
              size: 14,
            )
          ],
        ),
        SizedBox(
          height: AppDimensions.sectionPadding.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(children: [
                Image.asset(AppImagePath.colorLocationIcon),
                SizedBox(
                  width: AppDimensions.contentPadding.w,
                ),
                Expanded(
                    child: HeaderText(
                  text: "You have no location added right now",
                  maxLine: 5,
                  align: TextAlign.start,
                  size: 12,
                  color: AppColors.inactiveColor,
                ))
              ]),
            ),
            Expanded(
                child: HeaderText(
              text: "Set your Location",
              color: AppColors.primaryColor,
              size: 14,
              align: TextAlign.end,
              fontWeight: FontWeight.w600,
            ))
          ],
        ),
      ],
    );
  }

  Widget titleAndSubTitle(
      {required String title,
      required String subTitle,
      required double contentPadding}) {
    return Row(
      children: [
        HeaderText(
          text: "$title: ",
          size: 12,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          width: contentPadding,
        ),
        BodyText(
          text: subTitle,
          size: 12,
        ),
      ],
    );
  }

  Widget cartInfoSection() {
    return Column(
      children: [
        SizedBox(
          height: AppDimensions.widgetPadding.h,
        ),
        Row(
          children: [
            const CustomCircleAvatar(
              width: 30,
              height: 30,
              image: "",
              localImage: "assets/images/moc_image_10.png",
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: AppDimensions.widgetPadding.w,
            ),
            const HeaderText(
              text: "From Timber Mart (4 Items)",
              color: AppColors.primaryColor,
              size: 14,
            ),
          ],
        ),
        SizedBox(
          height: AppDimensions.sectionPadding.h,
        ),
        billingAddressSection(),
        SizedBox(
          height: AppDimensions.sectionPadding.h,
        ),
        deliveryAddressSection(),
        SizedBox(
          height: AppDimensions.sectionPadding.h,
        ),
      ],
    );
  }

  Widget addLocationForm() {
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
                    text: "Add New Location Manually",
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
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.horizontalPadding.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                isRequired: true,
                                validatorText: "Required",
                                controller: controller.stateController,
                              ),
                            ),
                            SizedBox(width: AppDimensions.contentPadding.w,),
                            Expanded(
                              child: CustomTextField(
                                levelText: "City/ Province",
                                hintText: "City/ Province",
                                isRequired: true,
                                validatorText: "Required",
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
                                isRequired: true,
                                validatorText: "Required",
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
                                isRequired: true,
                                validatorText: "Required",
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
                                isRequired: true,
                                validatorText: "Required",
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
                                isRequired: true,
                                validatorText: "Required",
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
                          validatorText: "Required",
                          controller: controller.addressController,
                        ),
                        SizedBox(
                          height: AppDimensions.sectionPadding.h,
                        ),
                        MaterialButton(
                          onPressed: () {
                            if(_formKey.currentState?.validate()??false){
                              controller.saveLocation();
                            }
                          },
                          color: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: HeaderText(text: "Add Location",color: Colors.white,),
                        ),
                        SizedBox(height: AppDimensions.sectionPadding.h,)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
