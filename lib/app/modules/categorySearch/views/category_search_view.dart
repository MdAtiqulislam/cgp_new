import 'package:cgp/app/modules/shopDetails/models/products_by_branch_model.dart';
import 'package:cgp/app/modules/warehouseSearch/models/warehouse_search_model.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_network_image.dart';
import 'package:cgp/common_widgets/custom_title.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/category_dropdown.dart';
import '../../../../common_widgets/custom_circle_avatar.dart';
import '../../../../common_widgets/custom_ratings.dart';
import '../../../../common_widgets/custom_search_bar.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../../../constraints/app_colors.dart';
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
              controller: controller.scrollController,
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
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                        childCount: controller.warehousesList.length,
                        (buildContext, index) {
                      return gridItem(
                          warehouse: controller.warehousesList[index]);
                    }),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: .65,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                  ),
                if (controller.isLoading.value)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Image.asset(
                        AppImagePath.loadingAnimation,
                        height: 48.r,
                        width: 48.r,
                      ),
                    ),
                  ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppDimensions.sectionPadding.h,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget gridItem({required SearchWarehouseModel warehouse}) {
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
      child: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(
            flex: 7,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CustomNetworkImage(
                    image: warehouse.logoUrl ?? "",
                    localImage: AppImagePath.warehouse,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black87,
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
                      CustomRatingWidget(
                        ratingValue: double.parse(
                            "${warehouse.avgRating?.averageRating ?? 0}"),
                        textColor: Colors.white,
                      ),
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
                        Get.find<ShopDetailsController>().wareHouseId.value =
                            warehouse.id ?? "";
                        Get.find<ShopDetailsController>()
                            .branchId
                            .value = warehouse
                                .branchInfo?.id ??
                            ""; //controller.wareHouseByCategoryModel.value.data?.warehouses?[index].id ?? ""
                        Get.find<ShopDetailsController>()
                            .branchType
                            .value = warehouse
                                .branchInfo?.branchType ??
                            ""; // BranchType.headOffice.name;//warehouse.branchInfo?.branchType??"";
                        Get.find<ShopDetailsController>().getWarehouseDetails();
                        Get.find<ShopDetailsController>().getBranchDetails();
                        Get.find<ShopDetailsController>()
                            .productByWarehouseBranchModel
                            .value = ProductByWarehouseBranchModel();
                        Get.find<ShopDetailsController>().products.value = [];
                        Get.find<ShopDetailsController>().getProducts();
                        Get.toNamed(Routes.SHOP_DETAILS);
                      },
                    ),
                  ),
                ),
                if(warehouse.logoUrl!=null)  Positioned(
                  top: AppDimensions.contentPadding,
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
                      image: warehouse.logoUrl??"",
                      fit: BoxFit.cover,
                      bgColor: Colors.transparent,
                      localImage: AppImagePath.noImage,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HeaderText(
                    text: warehouse.name ?? "",
                    align: TextAlign.start,
                    //color: Colors.white,
                    maxLine: 2,
                    size: 12,
                    resizeable: false,
                    fontWeight: FontWeight.w700,
                  ),
                  // SizedBox(height: AppDimensions.contentPadding,),
                  BodyText(
                    text: warehouse.branchInfo?.address ?? "",
                    // color: Colors.white,
                    align: TextAlign.start,
                    maxLine: 2,
                    resize: false,
                    size: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
