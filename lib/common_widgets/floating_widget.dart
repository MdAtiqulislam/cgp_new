
import 'package:cgp/app/modules/orderDetails/controllers/order_details_controller.dart';
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/common_widgets/app_button.dart';
import 'package:cgp/utils/enams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app/modules/orderDetails/views/single_cancel_reason_card.dart';
import '../constraints/app_colors.dart';
import '../constraints/app_strings.dart';
import '../constraints/body_text.dart';
import '../constraints/dimensions.dart';
import '../constraints/header_text.dart';
import '../models/cancel_reason_model.dart';
import '../other_controllers/floating_controller.dart';
import 'custom_loading_screen.dart';

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
                  child:
                      controller.isExpand.value ? expandCard() : shrinkCard()),
            ],
          ),
        ),
      ),
    );
  }

  Widget expandCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        statusSection(),
        progressBarSection(),
        // notificationSection(),
        HeaderText(text: controller.ongoingOrder.value.title ?? ""),
        SizedBox(
          height: AppDimensions.contentPadding.h,
        ),
        BodyText(
          text: controller.ongoingOrder.value.message ?? "",
          align: TextAlign.start,
        ),
        SizedBox(
          height: AppDimensions.contentPadding.h,
        ),
        if (controller.orderDetails.value.data?.deliveryInfo?.rider?.id != null)
          riderInfoSection(),
        SizedBox(
          height: AppDimensions.contentPadding.h,
        ),
        buttonSection(),
      ],
    );
  }

  Widget progressBarSection() {
    return Row(
      children: [
        progressIndicator(
          isActive: controller.activeProgress.value == 0,
          isCompleted: controller.activeProgress.value > 0,
        ),
        SizedBox(width: AppDimensions.widgetPadding.w),
        progressIndicator(
          isActive: controller.activeProgress.value == 1,
          isCompleted: controller.activeProgress.value > 1,
        ),
        SizedBox(width: AppDimensions.widgetPadding.w),
        progressIndicator(
          isActive: controller.activeProgress.value == 2,
          isCompleted: controller.activeProgress.value > 2,
        ),
      ],
    );
  }

  Widget statusSection() {
    return Column(
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
      ],
    );
  }

  Widget progressIndicator({bool isActive = true, bool isCompleted = false}) {
    return Expanded(
      child: Container(
        height: 8.0, // Increased height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.inactiveColor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: isActive
              ? const AnimatedProgressIndicator()
              : LinearProgressIndicator(
                  value: isCompleted ? 1 : 0,
                  backgroundColor: AppColors.inactiveColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isCompleted
                        ? AppColors.primaryColor
                        : AppColors.inactiveColor,
                  ),
                ),
        ),
      ),
    );
  }

  Widget buttonSection() {
    print(controller.ongoingOrder.value.shippingStatus);
    return Row(
      children: [
        if (controller.ongoingOrder.value.shippingStatus ==
            OrderStatus.waiting.name ||
            controller.ongoingOrder.value.shippingStatus ==
                OrderStatus.pending.name ||
            controller.ongoingOrder.value.shippingStatus ==
                OrderStatus.accepted.name ||
            controller.ongoingOrder.value.shippingStatus ==
                OrderStatus.reachedAtPickupPoint.name)
          Expanded(
            child: MaterialButton(
              padding: EdgeInsets.zero,
              color: AppColors.errorColor,
              onPressed: () {
                controller.isExpand.value = false;
                controller.getCancelReason();
                Get.bottomSheet(
                  isScrollControlled: true,
                  ignoreSafeArea: false,
                  cancelOrderInfo(),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cancel_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: AppDimensions.widgetPadding.w,
                  ),
                  const HeaderText(
                    text: "Cancel Order",
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),

        if (controller.ongoingOrder.value.shippingStatus != OrderStatus.waiting.name &&
            controller.ongoingOrder.value.shippingStatus != OrderStatus.pending.name &&
            controller.ongoingOrder.value.shippingStatus != OrderStatus.accepted.name &&
            controller.ongoingOrder.value.shippingStatus != OrderStatus.reachedAtPickupPoint.name)
          Expanded(
            child: MaterialButton(
              padding: EdgeInsets.zero,
              color: AppColors.primaryColor,
              onPressed: () {
                controller.isExpand.value = false;
                Get.put(OrderDetailsController());
                Get.find<OrderDetailsController>().getOrderDetails(orderId: controller.orderId.value);
                Get.toNamed(Routes.ORDER_DETAILS);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.description_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: AppDimensions.widgetPadding.w,
                  ),
                  const HeaderText(
                    text: "View details",
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        SizedBox(
          width: AppDimensions.sectionPadding.w,
        ),
        if (controller.orderDetails.value.data?.deliveryInfo?.rider?.id != null)
          IconButton(
              onPressed: () {
                controller.callDriver();
              },
              icon: const Icon(Icons.phone)),
        if (controller.orderDetails.value.data?.deliveryInfo?.rider?.id != null)
          IconButton(
              onPressed: () {
                controller.chatWithDriver();
              },
              icon: const Icon(Icons.message)),
        if (controller.orderDetails.value.data?.deliveryInfo?.rider?.id != null)
          IconButton(
              onPressed: () {
                controller.trackOrderOnMap();
              },
              icon: const Icon(Icons.location_on)),
      ],
    );

  }

  Widget riderInfoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              AppImagePath.vehicleNumber,
              height: 25,
              width: 25,
            ),
            SizedBox(
              width: AppDimensions.contentPadding.w,
            ),
            HeaderText(
                text: controller.orderDetails.value.data?.deliveryInfo?.rider
                        ?.vehicleLicensePlate ??
                    ""),
          ],
        ),
        Row(
          children: [
            Image.asset(
              AppImagePath.driver,
              height: 20,
              width: 20,
            ),
            SizedBox(
              width: AppDimensions.contentPadding.w,
            ),
            HeaderText(
                text: controller
                        .orderDetails.value.data?.deliveryInfo?.rider?.name ??
                    ""),
          ],
        ),
      ],
    );
  }

  Widget shrinkCard() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.circle,
              color: AppColors.successColor,
              size: 14,
            ),
            SizedBox(width: AppDimensions.contentPadding.w,),
            Expanded(child: BodyText(text: controller.ongoingOrder.value.title??"Ongoing Order",align: TextAlign.start,))
          ],
        ),
        SizedBox(
          height: AppDimensions.contentPadding.h,
        ),
        buttonSection()
      ],
    );
  }

  Widget cancelOrderInfo() {
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
                    text: "Cancel Reason",
                    color: Colors.white,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(AppImagePath.cancelIcon),
                  ),
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: AppDimensions.sectionPadding.h,
                            ),
                            const HeaderText(
                              text:
                                  "Please select why you want to cancel your order.",
                              maxLine: 20,
                              color: AppColors.primaryColor,
                              align: TextAlign.start,
                            ),
                            SizedBox(
                              height: AppDimensions.sectionPadding.h,
                            ),
                            Card(
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (buildContext, index) {
                                    final cancelReason = controller
                                        .cancelReasonsModel.value.data?[index];

                                    return Obx(() => SingleCancelReasonCard(
                                          reason: cancelReason?.reason ??
                                              'Unknown Reason',
                                          isSelected: controller
                                                  .selectedCancelReason
                                                  .value
                                                  .id ==
                                              cancelReason?.id,
                                          onTap: () {
                                            controller.selectedCancelReason
                                                    .value =
                                                cancelReason ??
                                                    CancelReasonModel();
                                          },
                                        ));
                                  },
                                  separatorBuilder: (buildContext, index) {
                                    return const Divider();
                                  },
                                  itemCount: controller.cancelReasonsModel.value
                                          .data?.length ??
                                      0),
                            ),
                            SizedBox(
                              height: AppDimensions.sectionPadding.h,
                            ),
                            AppButton(
                              text: "Continue",
                              onTap: () {
                                Get.back();
                                controller.cancelOrder();
                              },
                              bgColor: AppColors.primaryColor,
                            ),
                            SizedBox(
                              height: AppDimensions.widgetPadding.h,
                            ),
                          ],
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

class AnimatedProgressIndicator extends StatefulWidget {
  const AnimatedProgressIndicator({super.key});

  @override
  AnimatedProgressIndicatorState createState() =>
      AnimatedProgressIndicatorState();
}

class AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (context, child) {
        return CustomPaint(
          painter: MovingBarPainter(animationController!.value),
          child: Container(),
        );
      },
    );
  }
}

class MovingBarPainter extends CustomPainter {
  final double animationValue;

  MovingBarPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryColor
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round;

    double barWidth = size.width * 0.2; // 20% of the width
    double startX = (size.width - barWidth) * animationValue;

    canvas.drawLine(
      Offset(startX, size.height / 2),
      Offset(startX + barWidth, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
