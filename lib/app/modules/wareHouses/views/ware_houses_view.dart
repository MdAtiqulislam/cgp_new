import 'package:cgp/app/modules/home/views/single_ware_house.dart';
import 'package:cgp/common_widgets/custom_loading_screen.dart';
import 'package:cgp/common_widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common_widgets/category_dropdown.dart';
import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../common_widgets/custom_search_bar.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../models/single_warehouse_model.dart';
import '../../../../utils/utils.dart';
import '../../../routes/app_pages.dart';
import '../../home/models/home_data_model.dart';
import '../../searchPage/controllers/search_page_controller.dart';
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
                    enabled: false,
                    onTap: () {
                      Get.put(SearchPageController());
                      Get.find<SearchPageController>().searchController.text =
                          "";
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
                        index: index,
                        categoryList: controller.categoryList,
                        warehouse: controller.wareHouses.value.data?[index] ?? SingleWarehouseModel(),
                        subTitle: "Interior Equipment, Landscape & Outdoor",
                        address: "Lorem Ipsum Street, 01 Melbourne, Australia",
                        distanceFuture: distanceFromMyLocation(
                      latitude: controller.wareHouses.value
                          .data?[index].mainBranch?.latitude,
                          longitude: controller.wareHouses.value
                              .data?[index].mainBranch?.longitude),

                      );
                    }),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: .5

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
