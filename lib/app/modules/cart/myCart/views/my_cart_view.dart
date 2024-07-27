import 'package:cgp/app/modules/cart/checkOut/controllers/check_out_controller.dart';
import 'package:cgp/app/modules/cart/models/my_cart_model.dart';
import 'package:cgp/app/modules/cart/myCart/views/single_crt_item.dart';
import 'package:cgp/common_widgets/app_button.dart';
import 'package:cgp/common_widgets/cart_page_header.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_check_box.dart';
import 'package:cgp/common_widgets/custom_circle_avatar.dart';
import 'package:cgp/common_widgets/custom_loading_screen.dart';
import 'package:cgp/common_widgets/custom_title.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../common_widgets/my_drawer.dart';
import '../../../../routes/app_pages.dart';
import '../../../home/views/single_grid_item.dart';
import '../../../productDetails/controllers/product_details_controller.dart';
import '../controllers/my_cart_controller.dart';
import 'empty_cart_view.dart';

class MyCartView extends GetView<MyCartController> {
  MyCartView({super.key});

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
          bottomNavigationBar: bottomNavigationBar(),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.horizontalPadding.w),
                child:(controller.cartModel.value.data??[]).isEmpty
                    ?const EmptyCartView()
                    : CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: CartPageHeader(
                        trailingText: "Details",
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
                          CustomCircleAvatar(
                            width: 30,
                            height: 30,
                            image: "",
                            localImage: "assets/images/moc_image_10.png",
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: AppDimensions.widgetPadding.w,
                          ),
                         if((controller.cartModel.value.data?[0].product?.warehouses??[]).isNotEmpty) Expanded(
                           child: HeaderText(
                              text: "From ${controller.cartModel.value.data?[0].product?.warehouses?[0].warehouseName??""} (${controller.cartModel.value.data?.length??0} Items)",
                              color: AppColors.primaryColor,
                              size: 14,
                            ),
                         ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomCheckBox(
                        label: "Select All",
                        padding: EdgeInsets.symmetric(
                            vertical: AppDimensions.contentPadding.h),
                        value: controller.selectAll.value,
                        onChanged: (value) {
                          controller.selectAll.value = value;
                          if (value) {
                            controller.selectedCartItems.value = [];
                            controller.selectedCartItems
                                .addAll(controller.cartModel.value.data ?? []);
                            controller.changeListen();
                          } else {
                            controller.selectedCartItems.value = [];
                            controller.changeListen();
                          }
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount: controller.cartModel.value.data?.length ??
                              0, (buildContext, index) {
                        return Column(
                          children: [
                            SingleCartItem(
                              index: index,
                              //  value: controller.selectedCartItems.contains(1),
                              cartItem:
                              controller.cartModel.value.data?[index] ??
                                  SingleCartModel(),
                            ),
                            if (index <
                                (controller.cartModel.value.data?.length ?? 0) -
                                    1)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: AppDimensions.contentPadding.h),
                                child: Divider(),
                              )
                          ],
                        );
                      }),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: CustomTitle(
                        title: "Add More Items from Timber Mart",
                      ),
                    ),
                    itemsSection(),
                    if (controller.isLoadingRecommended.value)
                      const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
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

  Widget itemsSection() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
          childCount: controller.recommendedProducts.length,
              (buildContext, index) {
            return SingleGridItem(
              index: index,
              product: controller.recommendedProducts[index],
              onTap: () {
                Get.put(ProductDetailsController());
                Get.find<ProductDetailsController>()
                    .getDetails(id: controller.recommendedProducts[index].id ?? "");
                /*    Get.find<ProductDetailsController>().categoryList.value =
                controller.homeDataModel.value.categories ?? [];*/
                Get.toNamed(Routes.PRODUCT_DETAILS);
              },
            );
          }),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: .7,
          crossAxisSpacing: AppDimensions.contentPadding.w,
          mainAxisSpacing: AppDimensions.contentPadding.h),
    );
  }

  bottomNavigationBar() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
      height: 70.h,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HeaderText(
                text: "Total Price",
                size: 12,
                align: TextAlign.start,
                lineHeight: 0,
              ),
              HeaderText(
                text: "${controller.total.value} AUD",
                color: AppColors.primaryColor,
                size: 18,
                lineHeight: 0,
              )
            ],
          ),
          SizedBox(
            width: AppDimensions.sectionPadding * 2.w,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.contentPadding.h),
              child: IgnorePointer(
                ignoring: controller.selectedCartItems.isEmpty ||
                    controller.isLoading.value,
                child: AppButton(
                  text: "Check Out",
                  onTap: () {
                    Get.put(CheckOutController());
                    Get.find<CheckOutController>().cartList =
                        controller.selectedCartItems;
                    Get.find<CheckOutController>().calculateTotal();
                    Get.toNamed(Routes.CHECK_OUT);
                  },
                  bgColor: controller.selectedCartItems.isEmpty ||
                          controller.isLoading.value
                      ? AppColors.inactiveColor
                      : AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
