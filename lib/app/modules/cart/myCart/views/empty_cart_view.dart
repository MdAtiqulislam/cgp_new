import 'package:cgp/app/modules/cart/myCart/controllers/my_cart_controller.dart';
import 'package:cgp/common_widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common_widgets/cart_page_header.dart';
import '../../../../../common_widgets/custom_title.dart';
import '../../../../../constraints/dimensions.dart';
import '../../../../routes/app_pages.dart';
import '../../../home/views/single_grid_item.dart';
import '../../../productDetails/controllers/product_details_controller.dart';

class EmptyCartView extends GetView<MyCartController> {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(()=>CustomScrollView(
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

        SliverToBoxAdapter(child: EmptyScreen(title: 'You have not added any items in your cart yet.',),),

        SliverToBoxAdapter(
          child: CustomTitle(
            title: "Recommended for you",
          ),
        ),
        itemsSection(),
        if (controller.isLoadingProduct.value)
          const SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    ),);
  }
  Widget itemsSection() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
          childCount: controller.products.length,
              (buildContext, index) {
            return SingleGridItem(
             // index: index,
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
