import 'package:cgp/common_widgets/app_button.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_circle_avatar.dart';
import 'package:cgp/common_widgets/custom_loading_screen.dart';
import 'package:cgp/common_widgets/custom_text_field.dart';
import 'package:cgp/common_widgets/custom_title.dart';
import 'package:cgp/common_widgets/my_drawer.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/review_and_ratings_controller.dart';

class ReviewAndRatingsView extends GetView<ReviewAndRatingsController> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState>scaffoldKey=GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key:scaffoldKey ,
        appBar: CustomAppBar(
          minimal: false,
          scaffoldKey: scaffoldKey,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: bottomNavBar(),
        body: Obx(
          () => SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.horizontalPadding.w,
                    vertical: AppDimensions.verticalPadding.h,
                  ),
                  child: Column(
                    children: [
                      (controller.orderDetails.value.data?.warehouse?.id !=
                              null)
                          ? reviewSection(
                              title: "Review to Warehouse",
                              avatarImage: "",
                              name: controller.orderDetails.value.data
                                      ?.warehouse?.name ??
                                  "Name",
                              reviewController:
                                  controller.wareHouseReviewController,
                              rating: controller.warehouseRating,
                              onRatingUpdate: (rating) {
                                controller.warehouseRating.value = rating;
                              },
                              onSubmit: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  controller.submitWarehouseReview();
                                }
                              },
                              buttonLabel: "Submit Warehouse Review",
                            )
                          : reviewSection(
                              title: "Review to Rider",
                              avatarImage: "",
                              name: controller.orderDetails.value.data
                                      ?.deliveryInfo?.rider?.name ??
                                  "Name",
                              reviewController:
                                  controller.riderReviewController,
                              rating: controller.riderRating,
                              onRatingUpdate: (rating) {
                                controller.riderRating.value = rating;
                              },
                              onSubmit: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  controller.submitRiderReview();
                                }
                              },
                              buttonLabel: "Submit Rider Review",
                            ),
                    ],
                  ),
                ),
                if (controller.isLoading.value) const LoadingScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget reviewSection({
    required String title,
    required String avatarImage,
    required String name,
    required TextEditingController reviewController,
    required RxDouble rating,
    required void Function(double) onRatingUpdate,
    required void Function() onSubmit,
    required String buttonLabel,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.horizontalPadding.w,
        vertical: AppDimensions.verticalPadding.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 10,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitle(title: title),
            SizedBox(height: AppDimensions.widgetPadding.h),
            Row(
              children: [
                CustomCircleAvatar(
                  width: 40,
                  height: 40,
                  image: avatarImage,
                ),
                SizedBox(width: AppDimensions.contentPadding.w),
                Expanded(
                  child: HeaderText(
                    text: name,
                    maxLine: 3,
                    align: TextAlign.start,
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: AppDimensions.widgetPadding.h),
            CustomTextField(
              levelText: "Review",
              hintText: "Write your review here...",
              isRequired: true,
              controller: reviewController,
              maxLine: 5,
              minLine: 3,
              validatorText: "Review is required",
            ),
            SizedBox(height: AppDimensions.widgetPadding.h),
            RatingBar.builder(
              initialRating: rating.value,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: onRatingUpdate,
            ),
            SizedBox(height: AppDimensions.widgetPadding.h),
            HeaderText(text: "Rating: ${rating.value}"),
            SizedBox(height: AppDimensions.widgetPadding.h),
            AppButton(
              text: buttonLabel,
              onTap: onSubmit,
              bgColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomNavBar() {
    return Container(
      height:
          0, // Hide the bottomNavBar since we have separate buttons for submission
    );
  }
}
