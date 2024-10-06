import 'package:cgp/app/modules/addOrUpdateAddress/controllers/add_or_update_address_controller.dart';
import 'package:cgp/app/modules/transportation/models/vehicles_model.dart';
import 'package:cgp/app/modules/transportation/views/single_vehicle_card.dart';
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_loading_screen.dart';
import 'package:cgp/common_widgets/custom_radio_button.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/common_widgets/custom_text_field.dart';
import 'package:cgp/common_widgets/custom_title.dart';
import 'package:cgp/common_widgets/my_drawer.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:cgp/models/single_address_model.dart';
import 'package:cgp/utils/enams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/app_button.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/app_strings.dart';
import '../controllers/transportation_controller.dart';

class TransportationView extends GetView<TransportationController> {
  TransportationView({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          key: scaffoldKey,
          appBar: CustomAppBar(
            minimal: false,
            scaffoldKey: scaffoldKey,
            enableBackButton: false,
          ),
          drawer: MyDrawer(),
          bottomNavigationBar: bottomNavBar(),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.horizontalPadding.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                      pickupAddressSection(),
                      SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                      shippingAddressSection(),
                      SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                      const CustomTitle(title: "Select Vehicle"),
                      vehicleSection(),
                      SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                      summarySection(),
                    ],
                  ),
                ),
              ),
              if (controller.isLoading.value) const LoadingScreen()
            ],
          ),
        ),
      ),
    );
  }

  Widget summarySection() {
    return Column(
      children: [
        const CustomTitle(title: "Summary"),
        SizedBox(
          height: AppDimensions.sectionPadding.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "Distance:",
              size: 14,
            ),
            BodyText(
              text:
                  "${controller.calculationModel.value.data?.distance ?? "0.0"} Km",
              size: 14,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "Duration:",
              size: 14,
            ),
            BodyText(
              text:
                  "${controller.calculationModel.value.data?.duration ?? "0.0"} Minutes",
              size: 14,
            )
          ],
        ),
        /* Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "Base Fare:",
              size: 14,
            ),
            BodyText(
              text:
                  "${controller.calculationModel.value.data?.baseFare ?? "0.0"} AUD",
              size: 14,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "Extra Millage Cost:",
              size: 14,
            ),
            BodyText(
              text: "${controller.calculationModel.value.data?.extraMilage ?? "0.0"} AUD",
              size: 14,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "Extra Minutes Cost:",
              size: 14,
            ),
            BodyText(
              text: "${controller.calculationModel.value.data?.extraMinute ?? "0.0"} AUD",
              size: 14,
            )
          ],
        ),*/
        const Divider(
          thickness: 3,
        ),
        /* Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "Total:",
              size: 14,
            ),
            HeaderText(
              text:
                  "${controller.calculationModel.value.data?.totalCost ?? "0.0"} AUD",
              size: 14,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "GST:",
              size: 14,
            ),
            HeaderText(
              text:
                  "${controller.calculationModel.value.data?.gst ?? "0.0"} AUD",
              size: 14,
            )
          ],
        ),
        Divider(),*/
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderText(
              text: "In Total:",
              color: AppColors.primaryColor,
            ),
            HeaderText(
              text: controller.calculationModel.value.data?.payableAmount ??
                  "0.0",
              color: AppColors.primaryColor,
            ),
          ],
        ),
        SizedBox(
          height: AppDimensions.sectionPadding.h,
        )
      ],
    );
  }

  Widget bottomNavBar() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding.w,
          vertical: AppDimensions.contentPadding.h),
      height: 70.h,
      child: Row(
        children: [
          Column(
            children: [
              const HeaderText(
                text: "In Total",
                size: 12,
              ),
              HeaderText(
                text: controller.calculationModel.value.data?.payableAmount ??
                    "0.0",
                color: AppColors.primaryColor,
              )
            ],
          ),
          SizedBox(
            width: AppDimensions.sectionPadding.w,
          ),
          Expanded(
            child: IgnorePointer(
              ignoring: controller.isLoading.value ||
                  (controller.pickupPoint.isEmpty &&
                      controller.selectedPickupAddress.value.id == null) ||
                  (controller.destinationPoint.isEmpty &&
                      controller.selectedShippingAddress.value.id == null) ||
                  controller.selectedVehicle.value.typeId == null,
              child: AppButton(
                text: "Submit",
                bgColor: controller.isLoading.value ||
                        (controller.pickupPoint.isEmpty &&
                            controller.selectedPickupAddress.value.id ==
                                null) ||
                        (controller.destinationPoint.isEmpty &&
                            controller.selectedShippingAddress.value.id ==
                                null) ||
                        controller.selectedVehicle.value.typeId == null
                    ? AppColors.inactiveColor
                    : AppColors.primaryColor,
                onTap: () async {
                  if(!await controller. pendingOrder()){
                    controller.getAddressesData();
                    Get.bottomSheet(
                      isScrollControlled: true,
                      ignoreSafeArea: false,
                      contactInfoSection(),
                    );
                  }


                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contactInfoSection() {
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
                    text: "Contact Info",
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

                              CustomRadioListTile(
                                value: controller.orderFor[0],
                                groupValue: controller.selectedOrderFor.value,
                                onChanged: (value) {
                                  controller.selectedOrderFor.value=controller.orderFor[0];
                                },
                                leading: "",
                                title: HeaderText(text: controller.orderFor[0],color: AppColors.primaryColor,),

                              ),
                              SizedBox(
                                height: AppDimensions.widgetPadding.h,
                              ),
                              CustomRadioListTile(
                                value: controller.orderFor[1],
                                groupValue: controller.selectedOrderFor.value,
                                onChanged: (value) {
                                 controller.selectedOrderFor.value=controller.orderFor[1];
                                },
                                leading: "",
                                title: HeaderText(text: controller.orderFor[1],color: AppColors.primaryColor,),

                              ),
                              SizedBox(
                                height: AppDimensions.widgetPadding.h,
                              ),
                              if (controller.selectedOrderFor.value!=controller.orderFor[0])
                                Column(
                                  children: [
                                    const CustomTitle(title: "Pick up Info"),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: CustomTextField(
                                            levelText: "First Name",
                                            hintText: "First Name",
                                            isRequired: true,
                                            validatorText: "Required",
                                            controller: controller
                                                .pickUpFirstNameController,
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
                                            validatorText: "Required",
                                            controller: controller
                                                .pickUpLastNameController,
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
                                      validatorText: "Required",
                                      textInputType: TextInputType.phone,
                                      controller:
                                          controller.pickUpPhoneController,
                                    ),
                                    SizedBox(
                                      height: AppDimensions.sectionPadding.h,
                                    ),
                                    const CustomTitle(title: "Delivery Info"),
                                    SizedBox(
                                      height: AppDimensions.widgetPadding.h,
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: CustomTextField(
                                            levelText: "First Name",
                                            hintText: "First Name",
                                            isRequired: true,
                                            validatorText: "Required",
                                            controller: controller
                                                .deliveryFirstNameController,
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
                                            validatorText: "Required",
                                            controller: controller
                                                .deliveryLastNameController,
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
                                      validatorText: "Required",
                                      textInputType: TextInputType.phone,
                                      controller:
                                          controller.deliveryPhoneController,
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: AppDimensions.sectionPadding.h,
                              ),
                              AppButton(
                                text: "Confirm Order",
                                onTap: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    controller.placeOrder();
                                  } else {
                                    CustomSnackBar(
                                      msg:
                                          "All fields with '*' marks are required.",
                                      isSuccess: false,
                                    ).showSnackBar();
                                  }
                                },
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

  Widget pickupAddressSection() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              if (await controller.checkDefaultPaymentMethod()) {
                controller.selectedPickupAddress.value = SingleAddressModel();
                await Get.toNamed(Routes.LOCATION_SEARCH)?.then((value) {
                  controller.pickupController.text = value[0];
                  controller.pickupPoint.value = value;
                });
              }
            },
            child: CustomTextField(
              isEnable: false,
              controller: controller.pickupController,
              hintText: "Select Pickup Address",
              levelText: "Pickup Point",
              maxLength: 3,
              maxLine: 3,
              suffix: const Icon(Icons.location_on_outlined),
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
              if(await controller.checkDefaultPaymentMethod()){
                controller.isLoading.value = true;
                Get.put(AddOrUpdateAddressController());
                Get.find<AddOrUpdateAddressController>().isActiveSelectButton =
                true;
                Get.find<AddOrUpdateAddressController>()
                    .selectedAddressType
                    .value = AddressType.pickup.name;
                await Get.find<AddOrUpdateAddressController>()
                    .getAddresses()
                    .then((value) {
                  Get.find<AddOrUpdateAddressController>().getMySelectedAddress();
                });
                await Get.toNamed(Routes.ADD_OR_UPDATE_ADDRESS)?.then((value) {
                  controller.isLoading.value = false;
                  if (value != null) {
                    Get.find<AddOrUpdateAddressController>()
                        .isActiveSelectButton = false;
                    controller.selectedPickupAddress.value = value;
                    controller.pickupController.text =
                        controller.selectedPickupAddress.value.address ?? "";
                  }
                });
              }
            },
            icon: const Icon(
              Icons.map,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget shippingAddressSection() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              if (await controller.checkDefaultPaymentMethod()) {
                controller.selectedShippingAddress.value = SingleAddressModel();
                await Get.toNamed(Routes.LOCATION_SEARCH)?.then((value) {
                  controller.destinationController.text = value[0];
                  controller.destinationPoint.value = value;
                });
              }
            },
            child: CustomTextField(
              isEnable: false,
              controller: controller.destinationController,
              hintText: "Select Destination Address",
              levelText: "Destination Point",
              maxLength: 3,
              maxLine: 3,
              suffix: const Icon(Icons.location_on_outlined),
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
              if(await controller.checkDefaultPaymentMethod()){
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
                    Get.find<AddOrUpdateAddressController>()
                        .isActiveSelectButton = false;
                    controller.selectedShippingAddress.value = value;
                    controller.destinationController.text =
                        controller.selectedShippingAddress.value.address ?? "";
                  }
                });

              }
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
    );
  }

  Widget vehicleSection() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.vehiclesModel.value.data?.length ?? 0,
        itemBuilder: (buildContext, index) {
          return Obx(
            () => IgnorePointer(
              ignoring: (controller.destinationPoint.isEmpty &&
                      controller.selectedShippingAddress.value.id == null) ||
                  (controller.pickupPoint.isEmpty &&
                      controller.selectedPickupAddress.value.id == null),
              child: SingleVehicleCard(
                vehicle: controller.vehiclesModel.value.data?[index] ??
                    SingleVehicleModel(),
                isSelected: controller.selectedVehicle.value ==
                    controller.vehiclesModel.value.data?[index],
                onTap: () {
                  controller.selectedVehicle.value =
                      controller.vehiclesModel.value.data?[index] ??
                          SingleVehicleModel();
                  controller.calculateSummary();
                },
              ),
            ),
          );
        });
  }
}
