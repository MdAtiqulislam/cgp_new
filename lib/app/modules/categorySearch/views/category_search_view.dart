import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_title.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:cgp/utils/enams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/category_dropdown.dart';
import '../../../../common_widgets/custom_search_bar.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../../../constraints/dimensions.dart';
import '../../../routes/app_pages.dart';
import '../../shopDetails/controllers/shop_details_controller.dart';
import '../controllers/category_search_controller.dart';

class CategorySearchView extends GetView<CategorySearchController> {
  CategorySearchView({super.key});

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
          body: Padding(
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
                    enabled: false,
                    onTap: () {
                      Get.toNamed(Routes.WAREHOUSE_SEARCH);
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppDimensions.sectionPadding.h,
                  ),
                ),
                SliverToBoxAdapter(
                  child: CategoryDropdown(
                    dropdownSearchFieldController:
                        controller.dropDownController,
                    data: controller.categoryList.value.data ?? [],
                    hintText: "Choose Items Category",
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppDimensions.sectionPadding.h,
                  ),
                ),
                SliverToBoxAdapter(
                  child: CustomTitle(
                    title: "Available ${controller.dropDownController.text}",
                  ),
                ),
                if (controller.isLoading.value)
                  const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (!controller.isLoading.value)
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                        childCount: controller.wareHouseByCategoryModel.value
                                .data?.warehouses?.length ??
                            0, (buildContext, index) {
                      return gridItem(index: index);
                    }),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 180,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget gridItem({required int index}) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 1),
            BoxShadow(
                color: Colors.black38, blurRadius: 5, offset: Offset(0, 3))
          ]),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImagePath.warehouse,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withAlpha((.8 * 255).toInt()),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(
                  text: controller.wareHouseByCategoryModel.value.data
                          ?.warehouses?[index].name ??
                      "",
                  align: TextAlign.start,
                  color: Colors.white,
                  maxLine: 4,
                  size: 12,
                  resizeable: false,
                  fontWeight: FontWeight.w700,
                ),
                // SizedBox(height: AppDimensions.contentPadding,),
                BodyText(
                  text:
                      "${controller.wareHouseByCategoryModel.value.data?.warehouses?[index].productCounts} items",
                  color: Colors.white,
                  align: TextAlign.start,
                  resize: false,
                  size: 10,
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.put(ShopDetailsController());
                  Get.find<ShopDetailsController>().wareHouseId.value=controller.wareHouseByCategoryModel.value.data?.warehouses?[index].id ?? "";
                  Get.find<ShopDetailsController>().branchId.value=controller.wareHouseByCategoryModel.value.data?.warehouses?[index].id ?? "";
                  Get.find<ShopDetailsController>().branchType.value = BranchType.headOffice.name;//warehouse.branchInfo?.branchType??"";
                  Get.find<ShopDetailsController>().getWarehouseDetails();
                  Get.find<ShopDetailsController>().getBranchDetails();
                  Get.find<ShopDetailsController>().getProducts();
                  Get.toNamed(Routes.SHOP_DETAILS);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
