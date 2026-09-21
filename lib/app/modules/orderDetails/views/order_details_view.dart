import 'package:cgp/app/modules/messaging/controllers/messaging_controller.dart';
import 'package:cgp/app/modules/orderDetails/models/order_details_model.dart';
import 'package:cgp/app/modules/orderDetails/views/single_cancel_reason_card.dart';
import 'package:cgp/app/modules/orderDetails/views/single_order_product_card.dart';
import 'package:cgp/app/modules/reviewAndRatings/controllers/review_and_ratings_controller.dart';
import 'package:cgp/app/modules/trackOrder/controllers/track_order_controller.dart';
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/common_widgets/app_button.dart';
import 'package:cgp/common_widgets/cart_page_header.dart';
import 'package:cgp/common_widgets/custom_network_image.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:cgp/models/cancel_reason_model.dart';
import 'package:cgp/utils/enams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/fullscreen_image_dialog.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../utils/utils.dart';
import '../../generalMap/geneal_map_widget.dart';
import '../controllers/order_details_controller.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  OrderDetailsView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Stack(
          children: [
            Scaffold(
              key: _scaffoldKey,
              appBar: CustomAppBar(
                minimal: false,
                scaffoldKey: _scaffoldKey,
              ),
              drawer: MyDrawer(),
              bottomNavigationBar: bottomNavBar(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.horizontalPadding.w),
                  child: Column(
                    children: [
                      CartPageHeader(
                        title: "My Order",
                        trailingText: "Details",
                        image: controller.orderDetails.value.data?.orderType ==
                                OrderType.transportationOnly.name
                            ? AppImagePath.deliveryVan
                            : AppImagePath.orderCart,
                      ),
                      SizedBox(
                        height: AppDimensions.widgetPadding.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.horizontalPadding.w,
                            vertical: AppDimensions.verticalPadding.h),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                AppDimensions.borderRadius.r),
                            boxShadow: const [
                              BoxShadow(
                                  color: AppColors.shadowColor, blurRadius: 10),
                            ]),
                        child: Column(
                          children: [
                            headerSection(),
                            SizedBox(
                              height: AppDimensions.contentPadding.h,
                            ),
                            const Divider(),
                            addressSection(),
                            SizedBox(
                              height: AppDimensions.contentPadding.h,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 300,
                              child: GeneralMapWidget(
                                myLocationEnabled: false,
                              ),
                            ),
                            SizedBox(
                              height: AppDimensions.contentPadding.h,
                            ),
                            const Divider(),
                            deliveryInfoSection(),
                            SizedBox(
                              height: AppDimensions.contentPadding.h,
                            ),
                            const Divider(),
                            riderInfoSection(),
                            SizedBox(
                              height: AppDimensions.contentPadding.h,
                            ),
                            const Divider(),
                            if (controller.orderDetails.value.data?.orderType ==
                                OrderType.productAndTransport.name)
                              productSection(),
                            SizedBox(
                              height: AppDimensions.contentPadding.h,
                            ),
                            paymentSection(),
                          ],
                        ),
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
    );
  }

  Widget headerSection() {
    return Column(
      children: [
        Row(
          children: [
            const HeaderText(
              text: "Order Id: ",
              size: 12,
            ),
            SizedBox(
              width: AppDimensions.contentPadding.w,
            ),
            BodyText(
              text: "${controller.orderDetails.value.data?.orderId}",
              color: AppColors.primaryColor,
            ),
          ],
        ),
        Row(
          children: [
            const HeaderText(
              text: "Time and Date: ",
              size: 12,
            ),
            SizedBox(
              width: AppDimensions.contentPadding.w,
            ),
            BodyText(
              text: formatDateTime(
                  dateTimeToConvert:
                      (controller.orderDetails.value.data?.createdAt ??
                              DateTime.now())
                          .toString()),
              color: AppColors.primaryColor,
            ),
          ],
        ),
        SizedBox(
          height: AppDimensions.contentPadding.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodyText(
              text: controller.orderDetails.value.data?.orderType ==
                      OrderType.transportationOnly.name
                  ? "Transportation Only"
                  : "Product and Transportation",
              color: AppColors.primaryColor,
              size: 12,
            ),
            SizedBox(
              width: AppDimensions.contentPadding.w,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.contentPadding.w,
                ),
                decoration: BoxDecoration(
                  color: Colors.green, // Background color
                  borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadius.r), // Rounded corners
                ),
                child: HeaderText(
                  text: controller.orderStatus.value,
                  size: 15,
                  color: Colors.white,
                  maxLine: 3,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget addressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BodyText(
          text: "Route completed",
          color: AppColors.primaryColor,
          size: 10,
        ),
        SizedBox(
          height: AppDimensions.contentPadding.h,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderText(
                    text: "Pickup Location",
                    color: AppColors.primaryColor,
                    size: 12,
                  ),
                  BodyText(
                    text: controller
                            .orderDetails.value.data?.pickupAddress?.address ??
                        "",
                    maxLine: 3,
                  )
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_outlined,
              color: AppColors.primaryColor,
              size: 20,
            ),
            SizedBox(
              width: AppDimensions.contentPadding.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderText(
                    text: "Drop Point",
                    color: AppColors.primaryColor,
                    size: 12,
                  ),
                  BodyText(
                    text: controller.orderDetails.value.data?.shippingAddress
                            ?.address ??
                        "",
                    maxLine: 3,
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget productSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyText(
          text: "Order products",
          size: 10,
          color: AppColors.primaryColor,
        ),
        SizedBox(
          height: AppDimensions.widgetPadding.h,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.orderDetails.value.data?.lineItems?.length ?? 0,
          itemBuilder: (buildContext, index) {
            return SingleOrderProductCard(
              product: controller.orderDetails.value.data?.lineItems?[index] ??
                  OrderDetailsLineItem(),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
        SizedBox(
          height: AppDimensions.contentPadding.h,
        ),
        const Divider(),
      ],
    );
  }

  Widget deliveryInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BodyText(
          text: "Delivery Info",
          color: AppColors.primaryColor,
          size: 10,
        ),
        SizedBox(
          height: AppDimensions.contentPadding.h,
        ),
        Column(
          children: [
            Row(
              children: [
                const HeaderText(
                  text: "Accepted at: ",
                  size: 12,
                ),
                BodyText(
                    text: formatDateTime(
                        dateTimeToConvert: (controller.orderDetails.value.data
                                ?.deliveryInfo?.acceptedAt)
                            .toString()))
              ],
            ),
            Row(
              children: [
                const HeaderText(
                  text: "Picked up at: ",
                  size: 12,
                ),
                BodyText(
                  text: formatDateTime(
                      dateTimeToConvert: (controller.orderDetails.value.data
                              ?.deliveryInfo?.pickedUpAt)
                          .toString()),
                ),
              ],
            ),
            Row(
              children: [
                const HeaderText(
                  text: "Delivered at: ",
                  size: 12,
                ),
                BodyText(
                  text: formatDateTime(
                      dateTimeToConvert: (controller
                          .orderDetails.value.data?.deliveryInfo?.deliveredAt)),
                ),
              ],
            ),

            if((controller.orderDetails.value.data?.images??[]).isNotEmpty)
              SizedBox(
                height: 100.h,
                child: ListView.builder(
                 // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: (controller.orderDetails.value.data?.images??[]).length,
                  itemBuilder: (context, index) {
                    var image=controller.orderDetails.value.data?.images?[index]??"";
                    return GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (context) => FullScreenImageDialog(
                            images: controller.orderDetails.value.data?.images ?? [],
                            initialIndex: index,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red
                        ),
                        margin:  EdgeInsets.symmetric(
                            horizontal: AppDimensions.contentPadding.w,vertical: AppDimensions.contentPadding.h),
                        child: CustomNetworkImage(image: image),
                      ),
                    );
                  },
                ),
              )

          ],
        )
      ],
    );
  }

  Widget riderInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BodyText(
          text: "Rider Info",
          color: AppColors.primaryColor,
          size: 10,
        ),
        SizedBox(
          height: AppDimensions.contentPadding.h,
        ),
        (controller.orderDetails.value.data?.deliveryInfo?.rider?.id != null)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const HeaderText(
                        text: "Name: ",
                        size: 12,
                      ),
                      BodyText(
                          text: controller.orderDetails.value.data?.deliveryInfo
                                  ?.rider?.name ??
                              "")
                    ],
                  ),
                  Row(
                    children: [
                      const HeaderText(
                        text: "Vehicle No: ",
                        size: 12,
                      ),
                      BodyText(
                        text: controller.orderDetails.value.data?.deliveryInfo
                                ?.rider?.vehicleLicensePlate ??
                            "N/A",
                      ),
                    ],
                  ),
                  if (controller.orderDetails.value.data?.deliveryInfo
                              ?.shippingStatus !=
                          OrderStatus.delivered.name &&
                      controller.orderDetails.value.data?.deliveryInfo
                              ?.shippingStatus !=
                          OrderStatus.cancelled.name&&
                  controller.orderDetails.value.data?.deliveryInfo
                      ?.shippingStatus?.toLowerCase() !="cancel")
                    Column(
                      children: [
                        Row(
                          children: [
                            const HeaderText(
                              text: "Remaining Distance: ",
                              size: 12,
                            ),
                            BodyText(
                                text:
                                    "${controller.orderDetails.value.data?.deliveryInfo?.estimatedRemainingDistance ?? 0.0} KM")
                          ],
                        ),
                        Row(
                          children: [
                            const HeaderText(
                              text: "Remaining Time: ",
                              size: 12,
                            ),
                            BodyText(
                                text: controller.formatTime(controller
                                        .orderDetails
                                        .value
                                        .data
                                        ?.deliveryInfo
                                        ?.estimatedRemainingTime ??
                                    0.0)),
                          ],
                        ),
                        SizedBox(
                          height: AppDimensions.widgetPadding.h,
                        ),
                        InkWell(
                          onTap: () async {
                            final phone = controller.orderDetails.value.data
                                ?.deliveryInfo?.rider?.phone;

                            // Add country code if missing
                            final formattedPhone = phone != null
                                ? (phone.startsWith('04') ? phone : '04$phone')
                                : "";

                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: formattedPhone,
                            );

                            if (formattedPhone.isNotEmpty) {
                              await launchUrl(launchUri);
                            } else {
                              // Handle the case where the phone number is not available
                              print('Phone number is missing');
                            }
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: AppDimensions.widgetPadding.w,
                              ),
                              HeaderText(
                                text: controller.orderDetails.value.data
                                            ?.deliveryInfo?.rider?.phone !=
                                        null
                                    ? (controller.orderDetails.value.data!
                                            .deliveryInfo!.rider!.phone!
                                            .startsWith('04')
                                        ? controller.orderDetails.value.data!
                                            .deliveryInfo!.rider!.phone!
                                        : '04${controller.orderDetails.value.data!.deliveryInfo!.rider!.phone!}')
                                    : "",
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppDimensions.widgetPadding.h,
                        ),
                        InkWell(
                          onTap: () {
                            Get.put(MessagingController());
                            Get.find<MessagingController>().initValue();
                            Get.find<MessagingController>().orderDetails.value =
                                controller.orderDetails.value;
                            Get.find<MessagingController>().imageLink.value =
                                controller.orderDetails.value.data?.deliveryInfo
                                        ?.rider?.url ??
                                    "";
                            Get.find<MessagingController>().chatWith.value =
                                controller.orderDetails.value.data?.deliveryInfo
                                        ?.rider?.name ??
                                    "";
                            Get.find<MessagingController>()
                                .loadPreviousMessage();
                            Get.toNamed(Routes.MESSAGING);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.message,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: AppDimensions.contentPadding.w,
                              ),
                              const HeaderText(
                                text: "Live chat with rider",
                                color: AppColors.primaryColor,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                ],
              )
            : SizedBox(
                width: Get.width,
                child: const HeaderText(
                  text: "Your order is not accepted by any driver yet.",
                  size: 12,
                  maxLine: 3,
                  align: TextAlign.start,
                ),
              ),
      ],
    );
  }

  Widget paymentSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "Net Payable:",
              size: 16,
            ),
            HeaderText(
              text:
                  "${controller.orderDetails.value.data?.payableAmount ?? "0"} AUD",
              size: 16,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget bottomNavBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (controller.showButton.value == "track") trackOrderButton(),
        if (controller.showButton.value == "cancel") cancelButton(),
        if (controller.showButton.value == "review") reviewButton(),
      ],
    );
  }

  Widget trackOrderButton() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
      child: MaterialButton(
        color: AppColors.primaryColor,
        onPressed: () async {
          var origin = LatLng(
              controller.orderDetails.value.data?.pickupAddress?.latitude ??
                  0.0,
              controller.orderDetails.value.data?.pickupAddress?.longitude ??
                  0.0);
          var destination = LatLng(
              controller.orderDetails.value.data?.shippingAddress?.latitude ??
                  0.0,
              controller.orderDetails.value.data?.shippingAddress?.longitude ??
                  0.0);
          var currentLocation = LatLng(
              controller.orderDetails.value.data?.deliveryInfo?.rider?.location
                      ?.latitude ??
                  0.0,
              controller.orderDetails.value.data?.deliveryInfo?.rider?.location
                      ?.longitude ??
                  0.0);

          Get.put(TrackOrderController());
          Get.find<TrackOrderController>().orderDetails.value =
              controller.orderDetails.value;
          Get.find<TrackOrderController>().generateRoute(
              origin: origin,
              destination: destination,
              riderLocation: currentLocation);
         // Get.find<TrackOrderController>().setCameraPosition(target: destination);
          await Get.toNamed(Routes.TRACK_ORDER)?.then((value) {
            controller.getOrderDetails(
                orderId:
                    "${controller.orderDetails.value.data?.orderId ?? ""}");
          });
        },
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.contentPadding.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeaderText(
                text: "Track Order",
                color: Colors.white,
                size: 18,
              ),
              SizedBox(
                width: AppDimensions.contentPadding.w,
              ),
              Icon(Icons.arrow_forward_ios_sharp)
            ],
          ),
        ),
      ),
    );
  }

  Widget cancelButton() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
      child: MaterialButton(
        color: AppColors.errorColor,
        onPressed: () async {
          if ((controller.cancelReasonsModel.value.data ?? []).isEmpty) {
            await controller.getCancelReason().then((value) {
              Get.bottomSheet(
                isScrollControlled: true,
                ignoreSafeArea: false,
                cancelOrderInfo(),
              );
            });
          } else {
            Get.bottomSheet(
              isScrollControlled: true,
              ignoreSafeArea: false,
              cancelOrderInfo(),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.contentPadding.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HeaderText(
                text: "Cancel Order",
                color: Colors.white,
                size: 18,
              ),
              SizedBox(
                width: AppDimensions.contentPadding.w,
              ),
              const Icon(Icons.cancel_outlined)
            ],
          ),
        ),
      ),
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

  Widget reviewButton() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
      child: Row(
        children: [
          if (controller.orderDetails.value.data?.reviews?.given != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyText(text: "Your Rating"),
                HeaderText(
                  text:
                      "${controller.orderDetails.value.data?.reviews?.given?.rating ?? 0}",
                  size: 18,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          if (controller.orderDetails.value.data?.reviews?.given != null)
            SizedBox(width: AppDimensions.widgetPadding.w),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.all(AppDimensions.contentPadding.r),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.borderRadius.r),
                ),
              ),
              onPressed: () async {
                Get.put(ReviewAndRatingsController());
                Get.find<ReviewAndRatingsController>().orderDetails.value =
                    controller.orderDetails.value;
                await Get.toNamed(Routes.REVIEW_AND_RATINGS)?.then((value) {
                  controller.getOrderDetails(
                      orderId:
                          (controller.orderDetails.value.data?.orderId ?? 0)
                              .toString());
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeaderText(
                    text: (controller.orderDetails.value.data?.reviews?.given !=
                            null)
                        ? "Review again"
                        : "Review this Order",
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: AppDimensions.contentPadding.w),
                  const Icon(Icons.rate_review_outlined, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
