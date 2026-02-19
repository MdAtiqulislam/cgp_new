
import 'package:cgp/app/modules/customFloatingCartButton/custom_floating_cart_button.dart';
import 'package:cgp/app/modules/searchPage/views/single_search_item.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_loading_screen.dart';
import 'package:cgp/common_widgets/custom_radio_button.dart';
import 'package:cgp/common_widgets/custom_search_bar.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common_widgets/my_drawer.dart';
import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
   SearchPageView({super.key});
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
                        onChange: (value){
                          if ((value?.length??0) >= 3) {
                            controller.searchKey.value=value??"";
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
                                "${controller.searchKey.value} (${controller.searchProducts.length} Results)",
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                          filterButton(),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.widgetPadding.h,
                      ),
                    ),
                    /*if (controller.isLoading.value)
                      const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),*/
                  //  if (!controller.isLoading.value)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: controller.searchProducts.length,
                            (buildContext, index) {
                          return SingleSearchItem(
                            product: controller.searchProducts[index],
                            index: index,
                            isCart: index % 2 == 0 ? true : false,
                            isFavourite: index % 2 != 0 ? true : false,
                            onTapCart: (){

                              controller.handelMyCart(id: controller.searchProducts[index].id??"");

                            },
                            onTapFavourite: () {
                              controller.handelWishList(id: controller.searchProducts[index].id??"");

               },
                          );
                        }),
                        /*gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 800,
                        childAspectRatio: 0,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 10.w
                      ),*/
                      ),
                  ],
                ),
              ),
              if(controller.isLoading.value)const LoadingScreen()
            ],
          ),
        ),
      ),
    );
  }

  Widget filterButton() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: AppColors.primaryColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.bottomSheet(
              isScrollControlled: true,
              ignoreSafeArea: false,
              filterSection(),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.contentPadding.w, vertical: 3.h),
            child: Row(
              children: [
                Icon(
                  Icons.filter_list_alt,
                  color: Colors.white,
                  size: 12.sp,
                ),
                SizedBox(
                  width: AppDimensions.contentPadding.w,
                ),
                BodyText(
                  text: "Filter",
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget filterSection() {
    return SafeArea(
      child: Container(
        width: Get.width,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPadding.w,
                  vertical: AppDimensions.contentPadding.h),
              width: Get.width,
              color: AppColors.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const HeaderText(
                    text: "Filter",
                    color: Colors.white,
                  ),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(AppImagePath.cancelIcon))
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.horizontalPadding.w),
                  child: Column(
                    children: [
                      Obx(
                        () => ExpansionTile(
                          visualDensity: const VisualDensity(vertical: -4),
                          trailing: Icon(
                            Icons.add_sharp,
                            size: 20,
                          ),
                          collapsedShape: RoundedRectangleBorder(
                            side: BorderSide.none,
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                          ),
                          tilePadding: EdgeInsets.zero,
                          title: const HeaderText(
                            text: "Price Range",
                            align: TextAlign.start,
                            fontWeight: FontWeight.w500,
                            size: 15,
                            // color: AppColors.bodyTextColor,
                          ),
                          children: [
                            CustomRadioListTile(
                                title: BodyText(
                                  text: controller.otpOptions[0],
                                ),
                                value: controller.otpOptions[0],
                                groupValue: controller.selectedOTPOption.value,
                                onChanged: (value) {
                                  controller.selectedOTPOption.value = value!;
                                },
                                leading: ""),
                            CustomRadioListTile(
                                title: BodyText(
                                  text: controller.otpOptions[1].toString(),
                                ),
                                value: controller.otpOptions[1],
                                groupValue: controller.selectedOTPOption.value,
                                onChanged: (value) {
                                  controller.selectedOTPOption.value = value!;
                                },
                                leading: ""),
                          ],
                        ),
                      ),
                      Divider(),
                      ExpansionTile(
                        visualDensity: const VisualDensity(vertical: -4),
                        trailing: Icon(
                          Icons.add_sharp,
                          size: 20,
                        ),
                        collapsedShape: RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        tilePadding: EdgeInsets.zero,
                        title: const HeaderText(
                          text: "Brand",
                          align: TextAlign.start,
                          fontWeight: FontWeight.w500,
                          size: 15,
                          // color: AppColors.bodyTextColor,
                        ),
                        children: [
                          ListView.builder(
                              itemCount: 10,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (itemBuilder, contex) {
                                return Obx(() => CustomRadioListTile(
                                    title: BodyText(
                                      text: controller.otpOptions[0],
                                    ),
                                    value: controller.otpOptions[0],
                                    groupValue:
                                        controller.selectedOTPOption.value,
                                    onChanged: (value) {
                                      controller.selectedOTPOption.value =
                                          value!;
                                    },
                                    leading: ""));
                              })

                          /* CustomRadioListTile(
                                title: BodyText(
                                  text: controller.otpOptions[0],
                                ),
                                value: controller.otpOptions[0],
                                groupValue: controller.selectedOTPOption.value,
                                onChanged: (value) {
                                  controller.selectedOTPOption.value = value!;
                                },
                                leading: ""),
                            CustomRadioListTile(
                                title: BodyText(
                                  text: controller.otpOptions[1].toString(),
                                ),
                                value: controller.otpOptions[1],
                                groupValue: controller.selectedOTPOption.value,
                                onChanged: (value) {
                                  controller.selectedOTPOption.value = value!;
                                },
                                leading: ""),*/
                        ],
                      ),
                      Divider(),
                      ExpansionTile(
                        visualDensity: const VisualDensity(vertical: -4),
                        trailing: Icon(
                          Icons.add_sharp,
                          size: 20,
                        ),
                        collapsedShape: RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        tilePadding: EdgeInsets.zero,
                        title: const HeaderText(
                          text: "Size",
                          align: TextAlign.start,
                          fontWeight: FontWeight.w500,
                          size: 15,
                          // color: AppColors.bodyTextColor,
                        ),
                        children: [
                          ListView.builder(
                              itemCount: 10,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (itemBuilder, contex) {
                                return Obx(() => CustomRadioListTile(
                                    title: BodyText(
                                      text: controller.otpOptions[0],
                                    ),
                                    value: controller.otpOptions[0],
                                    groupValue:
                                        controller.selectedOTPOption.value,
                                    onChanged: (value) {
                                      controller.selectedOTPOption.value =
                                          value!;
                                    },
                                    leading: ""));
                              })

                          /* CustomRadioListTile(
                                title: BodyText(
                                  text: controller.otpOptions[0],
                                ),
                                value: controller.otpOptions[0],
                                groupValue: controller.selectedOTPOption.value,
                                onChanged: (value) {
                                  controller.selectedOTPOption.value = value!;
                                },
                                leading: ""),
                            CustomRadioListTile(
                                title: BodyText(
                                  text: controller.otpOptions[1].toString(),
                                ),
                                value: controller.otpOptions[1],
                                groupValue: controller.selectedOTPOption.value,
                                onChanged: (value) {
                                  controller.selectedOTPOption.value = value!;
                                },
                                leading: ""),*/
                        ],
                      ),
                      Divider(),
                      ExpansionTile(
                        visualDensity: const VisualDensity(vertical: -4),
                        trailing: Icon(
                          Icons.add_sharp,
                          size: 20,
                        ),
                        collapsedShape: RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        tilePadding: EdgeInsets.zero,
                        title: const HeaderText(
                          text: "Distance",
                          align: TextAlign.start,
                          fontWeight: FontWeight.w500,
                          size: 15,
                          // color: AppColors.bodyTextColor,
                        ),
                        children: [
                          ListView.builder(
                              itemCount: 10,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (itemBuilder, contex) {
                                return Obx(() => CustomRadioListTile(
                                    title: BodyText(
                                      text: controller.otpOptions[0],
                                    ),
                                    value: controller.otpOptions[0],
                                    groupValue:
                                        controller.selectedOTPOption.value,
                                    onChanged: (value) {
                                      controller.selectedOTPOption.value =
                                          value!;
                                    },
                                    leading: ""));
                              })
                        ],
                      ),
                      Divider(),
                      ExpansionTile(
                        visualDensity: const VisualDensity(vertical: -4),
                        trailing: Icon(
                          Icons.add_sharp,
                          size: 20,
                        ),
                        collapsedShape: RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        tilePadding: EdgeInsets.zero,
                        title: const HeaderText(
                          text: "Shop",
                          align: TextAlign.start,
                          fontWeight: FontWeight.w500,
                          size: 15,
                          // color: AppColors.bodyTextColor,
                        ),
                        children: [
                          ListView.builder(
                              itemCount: 10,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (itemBuilder, contex) {
                                return Obx(() => CustomRadioListTile(
                                    title: BodyText(
                                      text: controller.otpOptions[0],
                                    ),
                                    value: controller.otpOptions[0],
                                    groupValue:
                                        controller.selectedOTPOption.value,
                                    onChanged: (value) {
                                      controller.selectedOTPOption.value =
                                          value!;
                                    },
                                    leading: ""));
                              })
                        ],
                      ),
                      SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
