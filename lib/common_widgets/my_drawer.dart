import 'dart:ui';

import 'package:cgp/app/modules/orderHistory/controllers/order_history_controller.dart';
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constraints/app_colors.dart';
import '../constraints/dimensions.dart';
import '../constraints/header_text.dart';
import '../other_controllers/my_drawer_controller.dart';
import 'custom_circle_avatar.dart';
import 'custom_loading_screen.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final MyDrawerController controller = Get.put(MyDrawerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Stack(
          children: [
            Drawer(
              backgroundColor: Colors.white,
              width: MediaQuery.of(context).orientation == Orientation.portrait
                  ? Get.width * .8
                  : Get.width * .5,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: 24.w, //AppDimensions.horizontalPadding,
                    vertical: 24.h //AppDimensions.verticalPadding
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*SizedBox(
                        height: 32.h//AppDimensions.sectionPaddingVer,
                      ),*/
                    Stack(
                      children: [
                        CustomCircleAvatar(
                          width: 70,
                          height: 70,
                          image:
                              controller.customer.value.profileImageUrl ?? "",
                          bgColor: AppColors.primaryColor.withOpacity(.5),
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.white54,
                                  onTap: () {
                                    // controller.chooseImage();

                                    //  Get.bottomSheet(choseImage());
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: AppDimensions.contentPadding.h,
                    ),
                    HeaderText(
                      text:
                          "${controller.customer.value.firstName ?? ""} ${controller.customer.value.lastName ?? ""}",
                      align: TextAlign.start,
                      maxLine: 3,
                    ),
                    const Divider(),
                    drawerButton(
                        onTap: () {
                          Get.offAllNamed(Routes.TRANSPORTATION);
                        },
                        icon: const Icon(Icons.home_outlined,size: 16,color: AppColors.iconColor,),
                        imageIcon: "",
                        text: "Home"),
                    drawerButton(
                        onTap: () {
                          Get.offAllNamed(Routes.HOME);
                        },
                        icon: const Icon(Icons.pages,size: 16,color: AppColors.iconColor,),
                        imageIcon: "",
                        text: "Brows products"),
                    drawerButton(
                        onTap: () {
                          controller.openProfilePage();
                        },
                        imageIcon: AppImagePath.account,
                        text: "Profile"),
                    const Divider(),
                    drawerButton(
                        onTap: () {
                          Get.toNamed(Routes.CART_DETAILS);
                        },
                        imageIcon: AppImagePath.shoppingCart,
                        text: "Cart"),
                    drawerButton(
                        onTap: () {
                          Get.toNamed(Routes.WISH_LIST);
                        },
                        imageIcon: AppImagePath.favourite,
                        text: "Wish List"),
                    /*drawerButton(
                      onTap: () {},
                      icon: AppImagePath.shoppingBag,
                      text: "Shop/Warehouses"),*/
                    Divider(),
                    drawerButton(
                        onTap: () {
                          Get.back();
                          /*Get.put(OrderHistoryController());
                        Get.find<OrderHistoryController>().getOrderHistory();*/
                          Get.toNamed(Routes.ORDER_HISTORY);
                        },
                        imageIcon: AppImagePath.orderCart,
                        text: "Orders"),
                    /*drawerButton(
                      onTap: () {},
                      icon: AppImagePath.deliveryVan,
                      text: "Shipping Information"),*/
                    drawerButton(
                        onTap: () {
                          Get.back();
                          Get.toNamed(Routes.PAYMENT_METHODS);
                        },
                        imageIcon: AppImagePath.payment,
                        text: "Payment Method"),
                    IgnorePointer(
                      ignoring: false,//controller.customer.value.,
                      child: drawerButton(
                          onTap: () {
                            controller.requestForTransportation();
                          },
                          imageIcon: AppImagePath.deliveryVan,
                          text: "Request For Transport"),
                    ),
                    const Divider(),
                    drawerButton(
                        onTap: () {
                          //Get.toNamed(Routes.REVIEW_AND_RATINGS);
                        },
                        imageIcon: AppImagePath.support,
                        text: "Customer Support/Helpline"),
                    drawerButton(
                        onTap: () {
                          Get.back();
                          Get.toNamed(Routes.CHAT_HISTORY);
                        },
                        icon: Icon(Icons.chat,size: 16,color: AppColors.iconColor,),
                        imageIcon: AppImagePath.support,
                        text: "Chat History"),
                    drawerButton(
                        onTap: () {
                          controller.logOut();
                        },
                        imageIcon: AppImagePath.logoutIcon,
                        text: "Log out"),
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

  Widget drawerButton(
      {required VoidCallback onTap,
        required String imageIcon,
        Widget? icon,
        required String text}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppDimensions.contentPadding.h),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r)),
      child: Material(
        color: Colors.transparent,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h),
            child: Row(
              children: [
                icon ?? Image.asset(
                  imageIcon,
                  height: 16,
                  width: 16,
                ),
                SizedBox(
                  width: AppDimensions.widgetPadding.w,
                ),
                HeaderText(
                  text: text,
                  size: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

/*  Widget choseImage() {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.r),
              topLeft: Radius.circular(15.r),),),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height:32.h,
          ),
          const HeaderText(
            text: "Select an action",
            color: AppColors.primaryColor,
            size: 18,
          ),
          SizedBox(
            height: 32.h//AppDimensions.widgetPaddingVer,
          ),
          const Divider(
            thickness: 5,
            color: AppColors.primaryColor,
          ),
          SizedBox(
            height:32.h// AppDimensions.contentPaddingVer,
          ),
          Container(
            margin: const EdgeInsets.all(5),
            color: Colors.white,
            child: Material(
              child: InkWell(
                onTap: () {
                  controller.selectImage(source: ImageSource.camera);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:24.w,// AppDimensions.horizontalPadding,
                      vertical:24.h// AppDimensions.widgetPaddingVer
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImagePath.cameraIcon,
                        height: 40.h,
                      ),
                      SizedBox(
                        width:24.w// AppDimensions.widgetPaddingHor,
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
                  controller.selectImage(source: ImageSource.gallery);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:24.w,// AppDimensions.horizontalPadding,
                      vertical: 24.w//AppDimensions.widgetPaddingVer
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImagePath.galleryIcon,
                        height: 40.h,
                      ),
                      SizedBox(
                        width:16.w// AppDimensions.widgetPaddingHor,
                      ),
                      const HeaderText(text: "Open Gallery"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 32.h//AppDimensions.sectionPaddingVer,
          )
        ],
      ),
    );
  }*/
}
