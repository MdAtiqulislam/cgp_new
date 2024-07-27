import 'package:cgp/app/modules/transportation/views/single_vehicle_card.dart';
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/common_widgets/app_button.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_title.dart';
import 'package:cgp/common_widgets/my_drawer.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:cgp/models/single_address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../constraints/body_text.dart';
import '../controllers/payment_page_controller.dart';

class PaymentPageView extends GetView<PaymentPageController> {
   PaymentPageView({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey=GlobalKey<ScaffoldState>();

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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPadding.w),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width:100,child: HeaderText(text: "Status",align: TextAlign.start,)),
                    BodyText(
                        text:
                            ": ${controller.transportOrderDetails.value.data?.order?.orderStatus ?? ""}")
                  ],
                ),
                SizedBox(height: AppDimensions.sectionPadding.h,),
                const CustomTitle(title: "Vehicle Info"),
                IgnorePointer(
                  child: SingleVehicleCard(
                      vehicle: controller.selectedVehicle.value,
                      onTap: () {},
                      isSelected: true),
                ),
                SizedBox(
                  height: AppDimensions.sectionPadding.h,
                ),
                const CustomTitle(title: "Pick up address"),
                singleAddressSection(address: controller.pickupAddress.value),
                SizedBox(
                  height: AppDimensions.sectionPadding.h,
                ),
                const CustomTitle(title: "Delivery up address"),
                singleAddressSection(address: controller.deliveryAddress.value),
                SizedBox(
                  height: AppDimensions.sectionPadding.h,
                ),
                const CustomTitle(title: "Order Summary"),
                orderSummarySection(),
                SizedBox(
                  height: AppDimensions.sectionPadding.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget singleAddressSection({required SingleAddressModel address}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
                width: 100,
                child: HeaderText(
                  text: "Name",
                  size: 12,
                  align: TextAlign.start,
                )),
            Expanded(
                child: BodyText(
              text: ": ${address.firstName ?? ""} ${address.lastName ?? ""}",
              align: TextAlign.start,
            ))
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
                width: 100,
                child: HeaderText(
                  text: "Phone",
                  size: 12,
                  align: TextAlign.start,
                )),
            Expanded(
                child: BodyText(
              text: ": ${address.phoneNumber1 ?? ""}",
              align: TextAlign.start,
            ))
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
                width: 100,
                child: HeaderText(
                  text: "Address",
                  size: 12,
                  align: TextAlign.start,
                )),
            Expanded(
                child: BodyText(
              text: ": ${address.address ?? ""}, ${address.countryId}",
              align: TextAlign.start,
            ))
          ],
        ),
      ],
    );
  }

  Widget orderSummarySection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderText(
              text: "Distance:",
              size: 14,
            ),
            BodyText(
              text:
                  "${controller.calculationModel.value.data?.distance ?? "0.0"} Km",
              size: 14,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "Duration:",
              size: 14,
            ),
            BodyText(
              text:
                  "${controller.calculationModel.value.data?.duration ?? "0.0"} Minutes",
              size: 14,
            )
          ],
        ),

        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "Base Fare:",
              size: 14,
            ),
            BodyText(
              text:
                  "${controller.calculationModel.value.data?.baseFare ?? "0.0"} AUD",
              size: 14,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "Extra Millage Cost:",
              size: 14,
            ),
            BodyText(
              text:
                  "${controller.calculationModel.value.data?.extraMilage ?? "0.0"} AUD",
              size: 14,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "Extra Minutes Cost:",
              size: 14,
            ),
            BodyText(
              text:
                  "${controller.calculationModel.value.data?.extraMinute ?? "0.0"} AUD",
              size: 14,
            )
          ],
        ),*/

        Divider(
          thickness: 3,
        ),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "Total:",
              size: 14,
            ),
            HeaderText(
              text:
                  "${controller.calculationModel.value.data?.totalCost ?? "0.0"} AUD",
              size: 14,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "GST:",
              size: 14,
            ),
            HeaderText(
              text:
                  "${controller.calculationModel.value.data?.gst ?? "0.0"} AUD",
              size: 14,
            )
          ],
        ),
        Divider(),*/

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "In Total:",
              color: AppColors.primaryColor,
            ),
            HeaderText(
              text: controller.calculationModel.value.data?.payableAmount ??
                  "0.0",
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ],
    );
  }

 Widget bottomNavBar() {
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w,vertical: AppDimensions.contentPadding.h),
      child: AppButton(
        text: "Go to home",
        bgColor: AppColors.primaryColor,
        onTap: (){
        Get.offAllNamed(Routes.TRANSPORTATION);
      },),
    );
 }
}
