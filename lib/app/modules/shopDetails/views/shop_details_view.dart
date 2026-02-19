import 'package:cgp/app/modules/shopDetails/views/shop_details_section.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_circle_avatar.dart';
import 'package:cgp/common_widgets/custom_network_image.dart';
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
            child:controller.isLoading.value
                ? LoadingScreen(showAnimation: controller.showLoadingAnimation.value,)
                : CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppDimensions.widgetPadding.h,
                  ),
                ),
                SliverToBoxAdapter(
                  child:Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(2),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 3
                            )
                          ]
                        ),
                        child: CustomNetworkImage(
                            width: Get.width,
                            height: 250.sp,
                            image: controller.wareHouseDetails.value.data?.thumbnailUrl??"",
                          localImage: AppImagePath.warehouse,
                        //  fit: BoxFit.cover,
                        ),
                      ),
                      if(controller.wareHouseDetails.value.data?.logoUrl!=null)  Positioned(
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
                            image: controller.wareHouseDetails.value.data?.logoUrl??"",
                            fit: BoxFit.cover,
                            bgColor: Colors.transparent,
                            localImage: AppImagePath.noImage,
                          ),
                        ),
                      ),

                      ],
                  )
                  /*CustomImageSlider(
                      items: ["assets/images/slider_image_5.png"],
                      height: 200.h),*/
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
                itemsSection(),
                if (controller.isLoadingProduct.value)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Image.asset(
                        AppImagePath.loadingAnimation,
                        height: 48.r,
                        width: 48.r,
                      ),
                    ),
                  ),
               // SliverToBoxAdapter(child: SizedBox(height: AppDimensions.sectionPadding.h,),),
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
              controller.products.length,
          (buildContext, index) {
        return SingleGridItem(
           // index: index,
            product:
                controller.products[index],
            onTap: () {
              Get.put(ProductDetailsController());
              Get.find<ProductDetailsController>().getDetails(
                  id: controller.products[index].id ??
                      "");
              Get.toNamed(Routes.PRODUCT_DETAILS);
            });
      }),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: .56,
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
              color: Colors.black.withAlpha((.5*255).toInt()),
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
