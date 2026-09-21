/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../common_widgets/cart_page_header.dart';
import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../constraints/body_text.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../constraints/header_text.dart';
import '../../../../utils/enams.dart';
import '../../../../utils/utils.dart';
import '../controllers/track_order_controller.dart';

class TrackOrderView extends GetView<TrackOrderController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TrackOrderView({super.key});

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
              bottomNavigationBar: backButton(),
              body: Padding(
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
                        ],
                      ),
                    ),

                    SizedBox(height: AppDimensions.widgetPadding.h,),
                    Expanded(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Obx(
                                () => GoogleMap(
                              onMapCreated: controller.onMapCreated,
                              myLocationEnabled: false,
                              mapType: MapType.normal,
                              initialCameraPosition:
                              controller.initialCameraPosition,
                              polylines: controller.polyLines.value,
                              markers: controller.markers,//.toSet(), // Ensure markers are updated
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                      DateTime.now()).toString()),
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
            */
/*Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.widgetPadding.w,
              ),
              decoration: BoxDecoration(
                color: Colors.green, // Background color
                borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadius.r), // Rounded corners
              ),
              child: HeaderText(
                text: controller.orderDetails.value.data?.orderStatus ?? "",
                size: 12,
                color: Colors.white,
              ),
            ),*//*

          ],
        ),
      ],
    );
  }

  Widget backButton() {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
      child: MaterialButton(
        color: AppColors.primaryColor,
        onPressed: () {
          Get.back();
        },
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.contentPadding.r),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeaderText(
                text: "Back",
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../constraints/header_text.dart';
import '../../../../common_widgets/custom_app_bar.dart';
import '../controllers/track_order_controller.dart';

class TrackOrderView extends GetView<TrackOrderController> {
  TrackOrderView({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(minimal: false, scaffoldKey: _scaffoldKey),
        body: Stack(
          children: [
            Obx(
                  () => GoogleMap(
                onMapCreated: controller.onMapCreated,
                initialCameraPosition: controller.initialCameraPosition,
                mapType: MapType.normal,
                markers: controller.markers,
                polylines: controller.polyLines.value,
                myLocationEnabled: false,
                onCameraMoveStarted: () {
                  controller.autoFollowRider.value = false;
                },
              ),
            ),
            Positioned(
              bottom: 20.h,
              left: 20.w,
              right: 20.w,
              child: ElevatedButton(
                onPressed: () {
                  controller.autoFollowRider.value = true;
                  if (controller.markers.isNotEmpty) {
                    final rider = controller.markers
                        .firstWhere((m) => m.markerId.value == 'rider');
                    controller.setCameraPosition(target: rider.position, zoom: 16);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: const HeaderText(
                  text: "Follow Rider",
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}