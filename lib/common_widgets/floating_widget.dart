import 'package:cgp/common_widgets/app_button.dart';
import 'package:cgp/utils/enams.dart';
import 'package:cgp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constraints/app_colors.dart';
import '../constraints/app_strings.dart';
import '../constraints/body_text.dart';
import '../constraints/dimensions.dart';
import '../constraints/header_text.dart';
import '../other_controllers/floating_controller.dart';

class FloatingWidget extends StatelessWidget {
  final controller = Get.put(FloatingController());

  FloatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isFloatingVisible.value
          ? ongoingOrderCard()
          : Container(
              height: 0,
            ),
    );
  }

  Widget ongoingOrderCard() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding.w,
          vertical: AppDimensions.contentPadding.h),
      clipBehavior: Clip.hardEdge,
      width: Get.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
          boxShadow: const [
            BoxShadow(
                color: AppColors.shadowColor, blurRadius: 5, spreadRadius: 2)
          ]),
      child: Material(
        child: InkWell(
          onTap: () {
            controller.isExpand.value = !controller.isExpand.value;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                controller.isExpand.value
                    ? AppImagePath.expandMoreIcon
                    : AppImagePath.expandLessIcon,
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.widgetPadding.w,
                    vertical: AppDimensions.contentPadding.h),
                child: controller.isExpand.value
                    ? detailsSection()
                    : const HeaderText(text: "On going order status"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BodyText(
                  text: "Distance",
                  align: TextAlign.start,
                ),
                SizedBox(
                  height: AppDimensions.contentPadding.h,
                ),
                HeaderText(text: controller.distanceText.value)
                /*if (controller.distanceInMeter > 150)
                  HeaderText(
                    text: formatDistance(
                      distanceInMeter: controller.distanceInMeter,
                    ),
                    align: TextAlign.start,
                  ),
                if (controller.distanceInMeter <= 150)
                  const HeaderText(
                    text: "Almost there",
                   // text: "Very close",
                    align: TextAlign.start,
                  ),
                if (controller.ongoingOrder.value.shippingStatus ==
                        OrderStatus.reachedAtPickupPoint.name ||
                    (controller.ongoingOrder.value.shippingStatus ==
                        OrderStatus.reachedAtDeliveryPoint.name))
                  const HeaderText(
                    text: "--",
                    align: TextAlign.start,
                  ),*/
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BodyText(text: "Arriving in"),
                SizedBox(
                  height: AppDimensions.contentPadding.h,
                ),
                HeaderText(text: controller.timeText.value)
              ],
            ),
          ],
        ),
        const Divider(),
        // notificationSection(),
        HeaderText(text: controller.ongoingOrder.value.title ?? ""),
        SizedBox(
          height: AppDimensions.widgetPadding.h,
        ),
        BodyText(
          text: controller.ongoingOrder.value.message ?? "",
          align: TextAlign.start,
        ),
      ],
    );
  }
}
