import 'package:cgp/app/modules/cart/models/my_cart_model.dart';
import 'package:cgp/common_widgets/app_button.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/my_drawer.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../common_widgets/cart_page_header.dart';
import '../../../../../common_widgets/custom_circle_avatar.dart';
import '../../../../../common_widgets/custom_loading_screen.dart';
import '../../../../../constraints/app_colors.dart';
import '../../../../../constraints/dimensions.dart';
import '../../../../../constraints/header_text.dart';
import '../controllers/check_out_controller.dart';

class CheckOutView extends GetView<CheckOutController> {
  CheckOutView({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          key: scaffoldKey,
          appBar: CustomAppBar(
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
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: CartPageHeader(
                        trailingText: "Pricing and Delivery",
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.widgetPadding.h,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
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
                          if ((controller.cartList[0].product?.warehouses ?? [])
                              .isNotEmpty)
                            Expanded(
                              child: HeaderText(
                                text:
                                    "From ${controller.cartList[0].product?.warehouses?[0].warehouseName ?? ""} (${controller.cartList.length} Items)",
                                color: AppColors.primaryColor,
                                size: 14,
                              ),
                            ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                    ),
                    billingAddressSection(),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                    ),
                    deliveryAddressSection(),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: cartItemsSection(),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                    ),
                  ],
                ),
              ),
              if (controller.isLoading.value) const LoadingScreen()
            ],
          ),
        ),
      ),
    );
  }

  Widget billingAddressSection() {
    return SliverToBoxAdapter(
      child: controller.defaultBillingAddress.value.id != null
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleAndSubTitle(
                          title: "Delivery Receiver",
                          subTitle:
                              "${controller.defaultBillingAddress.value.firstName}"
                              " ${controller.defaultBillingAddress.value.lastName}",
                          contentPadding: 10.w),
                      titleAndSubTitle(
                          title: "Contact No",
                          subTitle:
                              "${controller.defaultBillingAddress.value.phoneNumber1}",
                          contentPadding: 10.w),
                      titleAndSubTitle(
                          title: "Address",
                          subTitle:
                              "${controller.defaultBillingAddress.value.address}, "
                              "${controller.defaultBillingAddress.value.city}, "
                              "${controller.defaultBillingAddress.value.state}",
                          contentPadding: 10.w),
                      titleAndSubTitle(
                          title: "Payment Method",
                          subTitle: "N/A",
                          contentPadding: 10.w),
                      titleAndSubTitle(
                          title: "Customer ID",
                          subTitle:
                              "${controller.defaultBillingAddress.value.customerId}",
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
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: BodyText(
                    text: "Please add a billi address first.",
                  ),
                ),
                Expanded(
                  child: Column(
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
                  ),
                )
              ],
            ),
    );
  }

  Widget deliveryAddressSection() {
    return SliverToBoxAdapter(
      child: Column(
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
                text: controller.distance.value,
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
                  if (controller.defaultShippingAddress.value.id == null)
                    Expanded(
                        child: HeaderText(
                      text: "You have no location added right now",
                      maxLine: 5,
                      align: TextAlign.start,
                      size: 12,
                      color: AppColors.inactiveColor,
                    )),
                  if (controller.defaultShippingAddress.value.id != null)
                    Expanded(
                        child: HeaderText(
                      text:
                          "${controller.defaultShippingAddress.value.firstName}"
                          " ${controller.defaultShippingAddress.value.lastName}, "
                          "${controller.defaultShippingAddress.value.address} ,"
                          "${controller.defaultShippingAddress.value.city}, "
                          "${controller.defaultShippingAddress.value.state}",
                      maxLine: 5,
                      align: TextAlign.start,
                      size: 12,
                      color: AppColors.inactiveColor,
                    ))
                ]),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    controller.addOrUpdateAddress();
                  },
                  child: HeaderText(
                    text: "Change Address",
                    color: AppColors.primaryColor,
                    size: 14,
                    align: TextAlign.end,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cartItemsSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodyText(
              text: "Item Details",
              color: AppColors.primaryColor,
              size: 12,
            ),
            BodyText(
              text: "Total Cost",
              color: AppColors.primaryColor,
              size: 12,
            )
          ],
        ),
        SizedBox(
          height: AppDimensions.contentPadding.h,
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (buildContext, index) {
              return singleItem(cartItem: controller.cartList[index]);
            },
            separatorBuilder: (buildContext, index) {
              return Divider();
            },
            itemCount: controller.cartList.length),
        Padding(
          padding: EdgeInsets.only(
            top: AppDimensions.widgetPadding.h,
          ),
          child: Divider(
            thickness: 3,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderText(
              text: "Total Price:",
              size: 12,
            ),
            HeaderText(
              text: "${controller.subTotal} AUD",
              size: 12,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderText(
              text: "Total Weight:",
              size: 12,
            ),
            HeaderText(
              text: "${controller.totalWeight} Kg",
              size: 12,
            ),
          ],
        ),
       /* Divider(
          thickness: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderText(
              text: "Delivery Charge:",
              size: 12,
            ),
            HeaderText(
              text: "${controller.deliveryCharge} AUD",
              size: 12,
            ),
          ],
        ),
        SizedBox(
          height: AppDimensions.contentPadding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderText(
              text: "In Total:",
              size: 14,
              color: AppColors.primaryColor,
            ),
            HeaderText(
              text: "${controller.total} AUD",
              size: 14,
              color: AppColors.primaryColor,
            ),
          ],
        ),*/
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

  Widget singleItem({required SingleCartModel cartItem}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderText(
          text:
              "${cartItem.product?.productName ?? ""} (Qty ${cartItem.quantity})",
          size: 14,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Get.width * .35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderText(
                    text: "Unit Price: ",
                    size: 12,
                  ),
                  BodyText(text: "${cartItem.product?.regularPrice ?? 0}")
                ],
              ),
            ),
            BodyText(
              text:
                  "${double.parse(cartItem.product?.regularPrice ?? "0") * (cartItem.quantity ?? 0)}",
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Get.width * .35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderText(
                    text: "Unit Weight: ",
                    size: 12,
                  ),
                  BodyText(
                      text:
                          "${cartItem.product?.weight ?? ""} ${cartItem.product?.unit ?? "Kg"}")
                ],
              ),
            ),
            BodyText(
              text:
                  " ${(cartItem.quantity ?? 0) * double.parse(cartItem.product?.weight ?? "0")} ${cartItem.product?.unit ?? "Kg"}",
            )
          ],
        ),
      ],
    );
  }

  Widget bottomNavBar() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding.w,
          vertical: AppDimensions.contentPadding.h),
      height: 70.h,
      width: Get.width,
      child: controller.defaultShippingAddress.value.id != null
          ? AppButton(
              bgColor: AppColors.primaryColor,
              showBorder: false,
              text: "Confirm Order",
              onTap: () {
                controller.placeOrder();
              },
            )
          : AppButton(
              bgColor: AppColors.primaryColor,
              showBorder: false,
              text: "Set Location",
              onTap: () {
                controller.addOrUpdateAddress();
                //  Get.toNamed(Routes.SET_LOCATION);
              },
            ),
    );
  }
}
