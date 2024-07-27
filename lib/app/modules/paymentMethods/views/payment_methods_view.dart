import 'package:cgp/app/modules/paymentMethods/views/single_payment_method_card.dart';
import 'package:cgp/common_widgets/app_button.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_loading_screen.dart';
import 'package:cgp/common_widgets/empty_screen.dart';
import 'package:cgp/common_widgets/my_drawer.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../constraints/header_text.dart';
import '../controllers/payment_methods_controller.dart';

class PaymentMethodsView extends GetView<PaymentMethodsController> {
  PaymentMethodsView({super.key});

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
        bottomNavigationBar: bottomNavbar(),
        body: Obx(
              () => SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.horizontalPadding.w,
                      vertical: AppDimensions.verticalPadding.h),
                  child: controller.paymentMethodListModel.value.data
                      ?.paymentMethodList?.data
                      ?.isEmpty ??
                      true && !controller.isLoading.value
                      ? const EmptyScreen(
                      title: "You haven't added any payment methods yet.")
                      : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.paymentMethodListModel.value
                        .data?.paymentMethodList?.data?.length ??
                        0,
                    itemBuilder: (buildContext, index) {
                      return SinglePaymentMethodCard(
                        cardBrand: controller.paymentMethodListModel.value
                            .data?.paymentMethodList?.data?[index]
                            .card?.brand ??
                            "",
                        last4Digits: controller.paymentMethodListModel
                            .value
                            .data
                            ?.paymentMethodList
                            ?.data?[index]
                            .card
                            ?.last4 ??
                            "",
                        expMonth: (controller.paymentMethodListModel.value
                            .data
                            ?.paymentMethodList
                            ?.data?[index]
                            .card
                            ?.expMonth ??
                            0)
                            .toString(),
                        expYear: (controller.paymentMethodListModel.value
                            .data
                            ?.paymentMethodList
                            ?.data?[index]
                            .card
                            ?.expYear ??
                            0)
                            .toString(),
                        isDefault: controller.paymentMethodListModel.value
                            .data?.customer?.invoiceSettings
                            ?.defaultPaymentMethod ==
                            controller.paymentMethodListModel.value.data
                                ?.paymentMethodList?.data?[index].id,
                        onDelete: () {
                          openConfirmDialog(
                              pmId: controller.paymentMethodListModel.value
                                  .data?.paymentMethodList
                                  ?.data?[index].id ??
                                  "");
                        },
                        makeDefault: () {
                          controller.setDefault(
                              pmId: controller.paymentMethodListModel
                                  .value.data?.paymentMethodList
                                  ?.data?[index].id ??
                                  "");
                        },
                      );
                    },
                  ),
                ),
                if (controller.isLoading.value) const LoadingScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomNavbar() {
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding.w,
          vertical: AppDimensions.contentPadding.h),
      child: AppButton(
        onTap: () async {
          Get.bottomSheet(
            isScrollControlled: true,
            ignoreSafeArea: false,
            paymentMethodForm(),
          );
        },
        bgColor: AppColors.primaryColor,
        text: 'Add new payment method',
      ),
    );
  }

  Widget paymentMethodForm() {
    return Obx(
          () => SafeArea(
        child: Stack(
          children: [
            Container(
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
                          text: "Add new payment method",
                          color: Colors.white,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(AppImagePath.cancelIcon),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppDimensions.sectionPadding.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.horizontalPadding.w),
                    child: CardField(
                      onCardChanged: (card) {
                        controller.cardDetails = card;
                      },
                    ),
                  ),
                  SizedBox(
                    height: AppDimensions.sectionPadding.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.horizontalPadding.w),
                    child: AppButton(
                      text: "Add",
                      onTap: () async {
                        await controller.addPaymentMethod();
                      },
                      bgColor: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: AppDimensions.sectionPadding.h,
                  )
                ],
              ),
            ),
            if (controller.isLoading.value)
              const Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  void openConfirmDialog({required String pmId}) {
    showDialog(
      context: Get.context!,
      builder: (buildContext) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPadding.w,
                vertical: AppDimensions.verticalPadding.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppImagePath.warningIcon),
                  SizedBox(height: 16.h),
                  const HeaderText(
                    text: "Are you sure you want to delete this payment method?",
                    maxLine: 10,
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                        text: "Cancel",
                        onTap: () {
                          Get.back();
                        },
                        bgColor: AppColors.primaryColor,
                      ),
                      SizedBox(width: 16.w),
                      AppButton(
                        text: "Confirm",
                        onTap: () {
                          Get.back();
                          controller.deletePaymentMethod(pmId: pmId);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
