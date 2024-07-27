import 'package:cgp/app/modules/shopDetails/views/shop_details_section.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_image_slider.dart';
import 'package:cgp/common_widgets/custom_text_field.dart';
import 'package:cgp/common_widgets/custom_title.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/app_button.dart';
import '../../../../common_widgets/custom_check_box.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../models/single_address_model.dart';
import '../../../../utils/enams.dart';
import '../../../routes/app_pages.dart';
import '../../addOrUpdateAddress/controllers/add_or_update_address_controller.dart';
import '../../home/views/single_grid_item.dart';
import '../../productDetails/controllers/product_details_controller.dart';
import '../controllers/shop_details_controller.dart';

class ShopDetailsView extends GetView<ShopDetailsController> {
  ShopDetailsView({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        floatingActionButton: floatingActionButton(),
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
                  child: CustomImageSlider(
                      items: ["assets/images/slider_image_5.png"],
                      height: 200.h),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppDimensions.widgetPadding.h,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: ShopDetailsSection(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppDimensions.sectionPadding.h,
                  ),
                ),
                SliverToBoxAdapter(
                  child: CustomTitle(
                      title:
                          "Products from ${controller.wareHouseDetails.value.data?.name ?? ""}"),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppDimensions.contentPadding.h,
                  ),
                ),
                if (controller.isLoadingProduct.value)
                  const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (!controller.isLoadingProduct.value) itemsSection(),
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

  Widget itemsSection() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
          childCount:
              controller.productsByWareHouse.value.data?.products?.length ?? 0,
          (buildContext, index) {
        return SingleGridItem(
            index: index,
            product:
                controller.productsByWareHouse.value.data?.products?[index],
            onTap: () {
              Get.put(ProductDetailsController());
              Get.find<ProductDetailsController>().getDetails(
                  id: controller.productsByWareHouse.value.data
                          ?.products?[index].id ??
                      "");
              Get.toNamed(Routes.PRODUCT_DETAILS);
            });
      }),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: .6,
          crossAxisSpacing: AppDimensions.contentPadding.w,
          mainAxisSpacing: AppDimensions.contentPadding.h),
    );
  }

  Widget floatingActionButton() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.5),
              blurRadius: 10,
              offset: const Offset(5, 5)
              //spreadRadius: 10
              )
        ],
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        color: AppColors.primaryColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.bottomSheet(
              isScrollControlled: true,
              ignoreSafeArea: false,
              orderRequestForm(),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPadding.w,
                vertical: AppDimensions.verticalPadding.h),
            child: const HeaderText(
              text: "Place Order Request",
              color: Colors.white,
              size: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget orderRequestForm() {
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
                    text: "Order Request",
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
            Obx(
              () => Flexible(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.horizontalPadding.w),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: AppDimensions.sectionPadding.h,
                              ),
                              const CustomTitle(title: "Write what you want"),
                              const CustomTextField(
                                levelText: "Order details",
                                hintText: "Order details",
                                maxLine: 20,
                                minLine: 5,
                              ),
                              SizedBox(height: AppDimensions.widgetPadding.h,),
                              const CustomTitle(title: "Shipping Info"),
                              shippingAddressSection(),
                              SizedBox(
                                height: AppDimensions.sectionPadding.h,
                              ),
                              AppButton(
                                text: "Confirm Order",
                                onTap: () {},
                                bgColor: AppColors.primaryColor,
                              ),
                              SizedBox(
                                height: AppDimensions.sectionPadding.h,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (controller.isLoading.value) const LoadingScreen()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget shippingAddressSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  controller.selectedShippingAddress.value = SingleAddressModel();
                  await Get.toNamed(Routes.LOCATION_SEARCH)?.then((value) {
                    //controller.destinationController.text = value[0];
                   // controller.destinationPoint.value = value;
                  });
                },
                child: const CustomTextField(
                  isEnable: false,
                //  controller: controller.destinationController,
                  hintText: "Select Destination Address",
                  levelText: "Destination Point",
                  maxLength: 3,
                  maxLine: 3,
                  suffix: Icon(Icons.location_on_outlined),
                ),
              ),
            ),
            SizedBox(
              width: AppDimensions.contentPadding.w,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius:
                  BorderRadius.circular(AppDimensions.borderRadius.r)),
              child: IconButton(
                onPressed: () async {
                  controller.isLoading.value = true;
                  Get.put(AddOrUpdateAddressController());
                  Get.find<AddOrUpdateAddressController>().isActiveSelectButton =
                  true;
                  Get.find<AddOrUpdateAddressController>()
                      .selectedAddressType
                      .value = AddressType.shipping.name;
                  await Get.find<AddOrUpdateAddressController>()
                      .getAddresses()
                      .then((value) {
                    Get.find<AddOrUpdateAddressController>().getMySelectedAddress();
                  });
                  await Get.toNamed(Routes.ADD_OR_UPDATE_ADDRESS)?.then((value) {
                    controller.isLoading.value = false;
                    if (value != null) {
                      /*Get.find<AddOrUpdateAddressController>()
                          .isActiveSelectButton = false;
                      controller.selectedShippingAddress.value = value;
                      controller.destinationController.text =
                          controller.selectedShippingAddress.value.address ?? "";*/
                    }
                  });

                  // controller.getAddresses(type:AddressType.pickup.name);
                  /* Get.bottomSheet(
                                          isScrollControlled: true,
                                          ignoreSafeArea: false,
                                          selectAddressSection(
                                              type: AddressType.pickup.name),
                                        );*/
                },
                icon: const Icon(
                  Icons.map,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimensions.widgetPadding.h,),
        CustomCheckBox(
            padding: EdgeInsets.zero,
            value: !controller.isSelfPickup.value,
            title: const HeaderText(text: "For another person",color: AppColors.primaryColor,align: TextAlign.start,),
            onChanged: (value){
              controller.isSelfPickup.value=!controller.isSelfPickup.value;
            }
        ),
        SizedBox(height: AppDimensions.widgetPadding.h,),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomTextField(
                levelText: "First Name",
                hintText: "First Name",
                isRequired: true,
                isEnable: !controller.isSelfPickup.value,
                validatorText: "Required",
                // controller: controller.pickUpFirstNameController,
              ),
            ),
            SizedBox(
              width: AppDimensions.contentPadding.w,
            ),
            Expanded(
              child: CustomTextField(
                levelText: "Last Name",
                hintText: "Last Name",
                isRequired: true,
                isEnable: !controller.isSelfPickup.value,
                validatorText: "Required",
                // controller: controller.pickUpLastNameController,
              ),
            ),
          ],
        ),
        SizedBox(
          height: AppDimensions.contentPadding.h,
        ),
        CustomTextField(
          levelText: "Phone/ Mobile",
          hintText: "Phone/ Mobile",
          isRequired: true,
          isEnable: !controller.isSelfPickup.value,
          validatorText: "Required",
          textInputType: TextInputType.phone,
          //  controller: controller.pickUpPhoneController,
        ),
        SizedBox(
          height: AppDimensions.sectionPadding.h,
        ),
      ],
    );
  }
}
