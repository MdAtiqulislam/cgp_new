import 'package:cgp/app/modules/home/views/single_grid_item.dart';
import 'package:cgp/app/modules/home/views/single_ware_house.dart';
import 'package:cgp/app/modules/productDetails/controllers/product_details_controller.dart';
import 'package:cgp/app/modules/wareHouses/controllers/ware_houses_controller.dart';
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/common_widgets/category_dropdown.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_loading_screen.dart';
import 'package:cgp/common_widgets/custom_search_bar.dart';
import 'package:cgp/common_widgets/custom_title.dart';
import 'package:cgp/common_widgets/my_drawer.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../models/single_product_model.dart';
import '../../../../models/single_warehouse_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final homeController=Get.put(HomeController());

  HomeView({super.key});

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
        body: Obx(
          () => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.horizontalPadding),
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
                          Get.toNamed(Routes.SEARCH_PAGE);
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
                        homeController.dropDownController,
                        data: homeController.homeDataModel.value.categories ?? [],
                        /* onChange: (value) {
                          controller.dropDownController.text = value;
                          Get.put(CategorySearchController());
                          Get.find<CategorySearchController>()
                              .dropDownController
                              .text = value;
                          Get.toNamed(Routes.CATEGORY_SEARCH);
                        },*/
                        hintText: "Choose Items Category",
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: nearestWareHouseSection(),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.widgetPadding.h,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: CustomTitle(
                        title: 'Select Items from your preferences',
                      ),
                    ),
                    itemsSection(),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.sectionPadding.h,
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

  Widget nearestWareHouseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTitle(title: 'Nearest warehouse Around You'),
        SizedBox(
          height: 350,
          //MediaQuery.of(Get.context!).orientation==Orientation.portrait? 250.h:180.w,
          child: ListView.builder(
              // padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding),
              itemExtent: 200,
              itemCount: homeController.homeDataModel.value.warehouses?.length ?? 0,
              // shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (buildContext, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: AppDimensions.contentPadding.w,
                    bottom: AppDimensions.contentPadding.h,
                  ),
                  child: SingleWareHouse(
                    categoryList:
                    homeController.homeDataModel.value.categories ?? [],
                    index: index,
                    warehouse:
                    homeController.homeDataModel.value.warehouses?[index] ??
                            SingleWarehouseModel(),
                    subTitle: "Interior Equipment, Landscape & Outdoor",
                    address: "Lorem Ipsum Street, 01 Melbourne, Australia",
                    // distance: "2 km away",
                    distanceFuture: distanceFromMyLocation(
                        latitude: homeController.homeDataModel.value
                            .warehouses?[index].mainBranch?.latitude,
                        longitude: homeController.homeDataModel.value
                            .warehouses?[index].mainBranch?.longitude),
                  ),
                );
              }),
        ),
        SizedBox(
          height: AppDimensions.contentPadding.h,
        ),
        MaterialButton(
          onPressed: () {
            Get.put(WareHousesController());
            Get.find<WareHousesController>().categoryList.value =
                homeController.homeDataModel.value.categories ?? [];
            Get.toNamed(Routes.WARE_HOUSES);
          },
          color: AppColors.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: BodyText(
            text: "View More",
            size: 12,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  Widget itemsSection() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
          childCount: homeController.homeDataModel.value.products?.length ?? 0,
          (buildContext, index) {
        return SingleGridItem(
          product: homeController.homeDataModel.value.products?[index] ??
              SingleProductModel(),
          index: index,
          onTap: () {
            Get.put(ProductDetailsController());
            Get.find<ProductDetailsController>().getDetails(
                id: homeController.homeDataModel.value.products?[index].id ?? "");
          /*  Get.find<ProductDetailsController>().categoryList.value =
                controller.homeDataModel.value.categories ?? [];*/
            Get.toNamed(Routes.PRODUCT_DETAILS);
          },
        );
      }),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: .6,
          crossAxisSpacing: AppDimensions.contentPadding.w,
          mainAxisSpacing: AppDimensions.contentPadding.h),
    );
  }
}
