import 'package:cgp/app/modules/orderHistory/views/single_order_card.dart';
import 'package:cgp/common_widgets/custom_title.dart';
import 'package:cgp/models/order_history_single_order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../../../constraints/dimensions.dart';
import '../controllers/order_history_controller.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  OrderHistoryView({super.key});

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
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.horizontalPadding.w),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: CustomTitle(
                        title: "My Orders",
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount:
                              controller.orderHistoryModel.value.data?.length ??
                                  0, (buildContext, index) {
                        return Column(
                          children: [
                            SingleOrderCard(
                              order:
                                  controller.orderHistoryModel.value.data?[index] ??
                                      SingleOrderModel(),
                            ),
                            if(index<(controller.orderHistoryModel.value.data?.length??0)-1)Padding(
                              padding:  EdgeInsets.symmetric(vertical: AppDimensions.contentPadding.h),
                              child: const Divider(),
                            )
                          ],
                        );
                      }),
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
}
