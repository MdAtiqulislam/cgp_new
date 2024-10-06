import 'package:cgp/app/modules/warehouseSearch/models/warehouse_search_model.dart';
import 'package:cgp/common_widgets/custom_circle_avatar.dart';
import 'package:cgp/common_widgets/custom_network_image.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/custom_search_bar.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/body_text.dart';
import '../../../../constraints/dimensions.dart';
import '../../../routes/app_pages.dart';
import '../../customFloatingCartButton/custom_floating_cart_button.dart';
import '../../shopDetails/controllers/shop_details_controller.dart';
import '../controllers/warehouse_search_controller.dart';

class WarehouseSearchView extends GetView<WarehouseSearchController> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  WarehouseSearchView({super.key});

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
          floatingActionButton: const CustomFloatingCartButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          drawer: MyDrawer(),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.horizontalPadding.w),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.widgetPadding.h,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomSearchBar(
                        searchController: controller.searchController,
                        onChange: (value) {
                          if ((value?.length ?? 0) >= 3) {
                            controller.searchKey.value = value ?? "";
                            controller.fetchData();
                          }
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.widgetPadding.h,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BodyText(
                            text:
                                "${controller.searchKey.value} (${controller.searchWarehouses.length} Results)",
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.widgetPadding.h,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (buildContext, index) {
                          return _buildSearchItem(
                              controller.searchWarehouses[index]);
                        },
                        childCount: controller.searchWarehouses.length,
                      ),
                    ),
                  ],
                ),
              ),
              if (controller.isLoading.value) const LoadingScreen(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchItem(WarehouseSearchData searchWarehouse) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(bottom: AppDimensions.widgetPadding.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 10,
          ),
        ],
        color: Colors.white,
      ),
      child: Material(
        child: InkWell(
          onTap: () {
            Get.put(ShopDetailsController());
            Get.find<ShopDetailsController>().wareHouseId.value=searchWarehouse.id ?? "";
            Get.find<ShopDetailsController>().branchId.value=searchWarehouse.branchInfo?.id ?? "";
            Get.find<ShopDetailsController>().branchType.value = searchWarehouse.branchInfo?.branchType??"";
            Get.find<ShopDetailsController>().getWarehouseDetails();
            Get.find<ShopDetailsController>().getBranchDetails();
            Get.find<ShopDetailsController>().getProducts();
            Get.toNamed(Routes.SHOP_DETAILS);

          },
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CustomNetworkImage(
                      width: MediaQuery.of(Get.context!).orientation ==
                              Orientation.portrait
                          ? 130.sp
                          : 70.sp,
                      height: MediaQuery.of(Get.context!).orientation ==
                              Orientation.portrait
                          ? 130.sp
                          : 70.sp,
                      // height: 100.sp,
                      image: searchWarehouse.thumbnailUrl ?? "",
                      localImage: AppImagePath.warehouse,
                      fit: BoxFit.cover,
                    ),
                    if (searchWarehouse.logoUrl != null)
                      Positioned(
                        bottom: AppDimensions.contentPadding,
                        left: AppDimensions.contentPadding,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // color: AppColors.borderColor,
                              color: Colors.black38,
                              border: Border.all(color: AppColors.borderColor,width: 2)
                          ),
                          child: CustomCircleAvatar(
                            width: 50.r,
                            height: 50.r,
                            image: searchWarehouse.logoUrl,
                          ),
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HeaderText(
                          text:
                              "${searchWarehouse.name ?? ""}: ${searchWarehouse.branchInfo?.name ?? ""}",
                          maxLine: 4,
                          align: TextAlign.start,
                          size: 14,
                        ),
                        const Divider(),
                        _buildInfoRow("ABN Number:", searchWarehouse.abnNumber),
                        _buildInfoRow("Branch Type:",
                            searchWarehouse.branchInfo?.branchType),
                        _buildInfoRow(
                            "Address:", searchWarehouse.branchInfo?.address),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyText(
          text: label,
          fontWeight: FontWeight.bold,
          color: AppColors.headerTextColor,
        ),
        SizedBox(
          width: AppDimensions.contentPadding.w,
        ),
        Expanded(
          child: BodyText(
            text: value ?? "",
            align: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
