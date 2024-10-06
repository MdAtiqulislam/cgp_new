import 'package:cgp/app/modules/home/views/single_ware_house.dart';
import 'package:cgp/common_widgets/custom_loading_screen.dart';
import 'package:cgp/common_widgets/custom_title.dart';
import 'package:cgp/models/single_warehouse_branch_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common_widgets/category_dropdown.dart';
import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../common_widgets/custom_search_bar.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../../../constraints/dimensions.dart';
import '../../../routes/app_pages.dart';
import '../controllers/ware_houses_controller.dart';

class WareHousesView extends GetView<WareHousesController> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  WareHousesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar:  CustomAppBar(
          minimal: false,
          scaffoldKey: scaffoldKey,
        ),
        drawer: MyDrawer(),
        body: Obx(
          () => Padding(
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
                   /* enabled: false,
                    onTap: () {
                      Get.put(SearchPageController());
                      Get.find<SearchPageController>().searchController.text =
                          "";
                      Get.toNamed(Routes.SEARCH_PAGE);
                    },*/
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
                    data: controller.categoryList,
                    /*onChange: (value) {
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
                const SliverToBoxAdapter(
                  child: CustomTitle(
                    title: "Ware Houses",
                  ),
                ),
                if(controller.isLoading.value)SliverToBoxAdapter(child: LoadingScreen()),
                SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      childCount: controller.wareHouses.value.data?.length??0,
                            (buildContext, index) {
                      return SingleWareHouse(
                        distance: controller.calculateDistance(
                            lat: double.parse(controller.wareHouses.value.data?[index].branchInfo?.latitude??"0"),
                            lan: double.parse(controller.wareHouses.value.data?[index].branchInfo?.longitude??"0")),
                        warehouse: controller.wareHouses.value.data?[index] ?? SingleWarehouseBranchModel(),

                      );
                    }),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: .54

                    )
                ),
                SliverToBoxAdapter(child: SizedBox(height: AppDimensions.sectionPadding.h,),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
