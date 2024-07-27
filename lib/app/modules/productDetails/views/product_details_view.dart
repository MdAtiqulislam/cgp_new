import 'package:cgp/common_widgets/common_description.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_image_slider.dart';
import 'package:cgp/common_widgets/custom_loading_screen.dart';
import 'package:cgp/common_widgets/custom_title.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../../../constraints/dimensions.dart';
import '../../../routes/app_pages.dart';
import '../../home/views/single_grid_item.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  ProductDetailsView({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.horizontalPadding.w),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.widgetPadding.h,
                      ),
                    ),
                    /*SliverToBoxAdapter(
                      child: CustomSearchBar(
                        enabled: false,
                        onTap: () {
                          Get.put(SearchPageController());
                          Get.find<SearchPageController>().searchController.text =
                              "Trusses";
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
                        hintText: "Choose Items Category",
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                    ),*/
                    SliverToBoxAdapter(
                      child: CustomImageSlider(
                        height: 300,
                        items: [
                          "assets/images/moc_image_9.png",
                          "assets/images/moc_image_8.png",
                          "assets/images/moc_image_7.png",
                          "assets/images/moc_image_6.png",
                        ],
                        autoPlay: false,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppDimensions.widgetPadding.h,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderText(
                              text:
                                  controller.details.value.data?.productName ??
                                      ""),
                          SizedBox(
                            height: AppDimensions.contentPadding.h,
                          ),
                          BodyText(
                            text:
                                controller.details.value.data?.shortDesc ?? "",
                            align: TextAlign.start,
                            maxLine: 3,
                          ),
                          SizedBox(
                            height: AppDimensions.contentPadding.h,
                          ),
                          SizedBox(
                              width: Get.width * .8,
                              child: CommonDescription(
                                price: double.parse(controller
                                        .details.value.data?.regularPrice ??
                                    "0.0"),
                                sizeHeight:
                                    controller.details.value.data?.sizeHeight ??
                                        "",
                                sizeWidth:
                                    controller.details.value.data?.sizeWidth ??
                                        "",
                                sizeLength:
                                    controller.details.value.data?.sizeLength ??
                                        "",
                                brand: controller
                                        .details.value.data?.brand?.name ??
                                    "",
                                material:
                                    controller.details.value.data?.materials ??
                                        "",
                                weight:
                                    "${controller.details.value.data?.weight ?? ""}"
                                    "${controller.details.value.data?.unit ?? ""}",
                              )),
                          SizedBox(
                            height: AppDimensions.widgetPadding.h,
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.handelWishList(
                                      id: controller.details.value.data?.id ??
                                          "");
                                },
                                icon: controller.isFavourite.value
                                    ? Icon(Icons.favorite_outlined)
                                    : Icon(Icons.favorite_border),
                              ),
                              SizedBox(
                                width: AppDimensions.sectionPadding.w,
                              ),
                              Row(
                                children: [
                                  IgnorePointer(
                                    ignoring: controller.quantity.value <= 1,
                                    child: IconButton(
                                        onPressed: () {
                                          controller.decrement();
                                        },
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: controller.quantity.value > 1
                                              ? AppColors.secondaryColor
                                              : AppColors.inactiveColor,
                                        )),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            AppDimensions.horizontalPadding.w),
                                    child: HeaderText(
                                      text:
                                          controller.quantity.value.toString(),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        controller.increment();
                                      },
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: AppColors.secondaryColor,
                                      )),
                                ],
                              ),
                              SizedBox(
                                width: AppDimensions.sectionPadding.w,
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.handelMyCart();
                                },
                                icon: !controller.isCartItem.value
                                    ? const Icon(Icons.shopping_cart_outlined)
                                    : const Icon(Icons.shopping_cart),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: AppDimensions.widgetPadding.h,
                          ),
                          HeaderText(
                            text: "Product Details",
                            align: TextAlign.start,
                          ),
                          SizedBox(
                            height: AppDimensions.widgetPadding.h,
                          ),
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: Get.width,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          color:
                                              controller.selectedIndex.value ==
                                                      0
                                                  ? AppColors.primaryColor
                                                  : AppColors.shadowColor,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                controller.selectedIndex.value =
                                                    0;
                                                controller.dynamicText.value =
                                                    controller
                                                            .details
                                                            .value
                                                            .data
                                                            ?.detailsOverview ??
                                                        "";
                                              },
                                              child: Center(
                                                child: BodyText(
                                                  text: controller.dataList[0],
                                                  color: controller
                                                              .selectedIndex
                                                              .value ==
                                                          0
                                                      ? Colors.white
                                                      : AppColors
                                                          .headerTextColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          color:
                                              controller.selectedIndex.value ==
                                                      1
                                                  ? AppColors.primaryColor
                                                  : AppColors.shadowColor,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                controller.selectedIndex.value =
                                                    1;
                                                controller.dynamicText
                                                    .value = controller
                                                        .details
                                                        .value
                                                        .data
                                                        ?.detailsSpecifications ??
                                                    "";
                                              },
                                              child: Center(
                                                child: BodyText(
                                                  text: controller.dataList[1],
                                                  color: controller
                                                              .selectedIndex
                                                              .value ==
                                                          1
                                                      ? Colors.white
                                                      : AppColors
                                                          .headerTextColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          color:
                                              controller.selectedIndex.value ==
                                                      2
                                                  ? AppColors.primaryColor
                                                  : AppColors.shadowColor,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                controller.selectedIndex.value =
                                                    2;
                                                controller.dynamicText
                                                    .value = controller
                                                        .details
                                                        .value
                                                        .data
                                                        ?.detailsSizeAndMaterials ??
                                                    "";
                                              },
                                              child: Center(
                                                child: BodyText(
                                                  text: controller.dataList[2],
                                                  color: controller
                                                              .selectedIndex
                                                              .value ==
                                                          2
                                                      ? Colors.white
                                                      : AppColors
                                                          .headerTextColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: AppDimensions.widgetPadding.h,
                                ),
                                BodyText(
                                  text: controller.dynamicText.value.isEmpty ||
                                          controller.dynamicText.value
                                                  .toLowerCase() ==
                                              "null"
                                      ? "No content available"
                                      : controller.dynamicText.value,
                                  align: TextAlign.start,
                                  maxLine: 100,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: AppDimensions.sectionPadding.h,
                          )
                        ],
                      ),
                    ),
                    if ((controller.similarProductsModel.value.data ?? [])
                        .isNotEmpty)
                      SliverToBoxAdapter(
                        child: CustomTitle(
                          title: "Related Products",
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

  Widget itemsSection() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
          childCount: controller.similarProductsModel.value.data?.length ?? 0,
          (buildContext, index) {
        return SingleGridItem(
            index: index,
            product: controller.similarProductsModel.value.data?[index],
            onTap: () {
              Get.put(ProductDetailsController());
              Get.find<ProductDetailsController>().getDetails(
                  id: controller.similarProductsModel.value.data?[index].id ??
                      "");
              Get.find<ProductDetailsController>().selectedIndex.value = 0;
              Get.offAndToNamed(Routes.PRODUCT_DETAILS);
            });
      }),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: .6,
          crossAxisSpacing: AppDimensions.contentPadding.w,
          mainAxisSpacing: AppDimensions.contentPadding.h),
    );
  }
}
