import 'package:cgp/app/modules/wishList/views/single_wish_list_product.dart';
import 'package:cgp/common_widgets/cart_page_header.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_loading_screen.dart';
import 'package:cgp/common_widgets/empty_screen.dart';
import 'package:cgp/common_widgets/my_drawer.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/app_button.dart';
import '../../../../common_widgets/custom_title.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/header_text.dart';
import '../../../../models/single_product_model.dart';
import '../../../routes/app_pages.dart';
import '../../home/views/single_grid_item.dart';
import '../../productDetails/controllers/product_details_controller.dart';
import '../controllers/wish_list_controller.dart';

class WishListView extends GetView<WishListController> {
   WishListView({super.key});
   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          key: scaffoldKey,
          appBar:  CustomAppBar(
            minimal: false,
            scaffoldKey: scaffoldKey,
          ),
          drawer: MyDrawer(),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPadding.w,
                ),
                child: CustomScrollView(
                  controller: controller.scrollController,
                  slivers: [
                    const SliverToBoxAdapter(
                      child: CartPageHeader(
                        image: AppImagePath.favourite,
                        title: "Your Choice list",
                        trailingText: "Listings",
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount:
                              controller.wishListModel.value.data?.length ?? 0,
                          (buildContext, index) {
                        return Column(
                          children: [
                            SingleWishListProduct(
                              index: index,
                              product: controller.wishListModel.value
                                      .data?[index].product ??
                                  SingleProductModel(),
                              delete: () {
                                showDialog(
                                    context: Get.context!,
                                    builder: (buildContext) {
                                      return Dialog(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: AppDimensions.horizontalPadding.w,
                                              vertical: AppDimensions.verticalPadding.h
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(15.r)
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(AppImagePath.warningIcon),
                                                SizedBox(height: 16.h//AppDimensions.widgetPaddingVer,
                                                ),
                                                //  const CustomCircleAvatar(width: 50, height: 50, image: AppImagePath.warningIcon),
                                                const HeaderText(text: "Are you sure you want to delete this from wishlist?",maxLine: 3,),
                                                SizedBox(height: 32.h//AppDimensions.sectionPaddingVer,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AppButton(text: "Cancel", showBorder:true,onTap: (){
                                                      Get.back();
                                                    },bgColor: AppColors.primaryColor,),
                                                    SizedBox(width: 16.w//AppDimensions.widgetPaddingHor,
                                                    ),
                                                    AppButton(text: "Confirm",borderColor: AppColors.primaryColor,showBorder: true, onTap: (){
                                                      Get.back();
                                                      controller.handleWishList(
                                                          id: controller.wishListModel.value
                                                              .data?[index].product?.id ??
                                                              "");
                                                    },),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              addToCart: () {

                                controller.handleMyCart(
                                    id: controller.wishListModel.value
                                            .data?[index].product?.id ??
                                        "");
                              },
                            ),
                            if (index <
                                ((controller.wishListModel.value.data?.length ??
                                        0) -
                                    1))
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: AppDimensions.contentPadding.h),
                                child: Divider(),
                              )
                          ],
                        );
                      }),
                    ),
                    if ((controller.wishListModel.value.data?.length ?? 0) == 0)
                      SliverToBoxAdapter(
                          child: EmptyScreen(
                        title: 'You have no added items in your choice list',
                      )),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: CustomTitle(
                        title: "Recommended For You",
                      ),
                    ),
                    itemsSection(),
                    if (controller.isLoadingProduct.value)
                      SliverToBoxAdapter(
                        child: Center(
                          child: Image.asset(
                            AppImagePath.loadingAnimation,
                            height: 48.r,
                            width: 48.r,
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(child: SizedBox(height: AppDimensions.sectionPadding.h,),),
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
          childCount: controller.products.length,
          (buildContext, index) {
        return SingleGridItem(
       //   index: index,
          product: controller.products[index],
          onTap: () {
            Get.put(ProductDetailsController());
            Get.find<ProductDetailsController>()
                .getDetails(id: controller.products[index].id ?? "");
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
}
