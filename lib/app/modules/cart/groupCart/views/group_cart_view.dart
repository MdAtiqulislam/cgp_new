import 'package:cgp/app/modules/cart/groupCart/views/single_group_cart_item.dart';
import 'package:cgp/common_widgets/cart_page_header.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_title.dart';
import 'package:cgp/common_widgets/my_drawer.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../home/views/single_grid_item.dart';
import '../controllers/group_cart_controller.dart';

class GroupCartView extends GetView<GroupCartController> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  GroupCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: CustomAppBar(
          minimal: false,
          scaffoldKey: scaffoldKey,
        ),
        drawer: MyDrawer(),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.horizontalPadding.w,
          ),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: CartPageHeader(
                  trailingText: "Listings",
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: AppDimensions.widgetPadding.h,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(childCount: 2,
                    (buildContext, index) {
                  return Column(
                    children: [
                      SingleGroupCartItem(
                        onTap: () {
                          Get.toNamed(Routes.CART_DETAILS);
                        },
                      ),
                      if (index != 2 - 1)
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: AppDimensions.widgetPadding.h),
                          child: const Divider(),
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
              const SliverToBoxAdapter(
                child: CustomTitle(
                  title: "Recommended For You",
                ),
              ),
              itemsSection()
            ],
          ),
        ),
      ),
    );
  }

  Widget itemsSection() {
    return SliverGrid(
      delegate:
          SliverChildBuilderDelegate(childCount: 9, (buildContext, index) {
        return SingleGridItem(
          index: index,
          onTap: () {
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
