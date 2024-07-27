import 'package:cgp/app/modules/shopDetails/controllers/shop_details_controller.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopDetailsSection extends GetView<ShopDetailsController> {
  const ShopDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderText(
            text: controller.wareHouseDetails.value.data?.name ?? "",
          ),
          SizedBox(
            height: AppDimensions.contentPadding.h,
          ),
          Row(
            children: [
              Image.asset(
                AppImagePath.locationIcon,
                height: 12.sp,
              ),
              SizedBox(
                width: AppDimensions.contentPadding.w,
              ),
              BodyText(
                  text: controller.wareHouseDetails.value.data?.mainBranch?.address??"")
            ],
          ),
          Row(
            children: [
              Image.asset(
                AppImagePath.deliveryVan,
                height: 12.sp,
              ),
              SizedBox(
                width: AppDimensions.contentPadding.w,
              ),
              BodyText(text: controller.distance.value)
            ],
          ),

          SizedBox(height: AppDimensions.widgetPadding.h,),
          InkWell(
            onTap: () async {
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: controller.wareHouseDetails.value.data?.mainBranch?.phone,
              );
              await launchUrl(launchUri);
            },
            child: Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: AppDimensions.widgetPadding.w,),
                HeaderText(
                  text: controller.wareHouseDetails.value.data?.mainBranch?.phone??"",
                  color: AppColors.primaryColor,)
              ],
            ),
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppDimensions.widgetPadding.h,
              ),
              Text.rich(
                  TextSpan(children: [
                TextSpan(
                    text: "Brand: ",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.headerTextColor,
                        fontSize: 10.sp)),
                TextSpan(
                  text:controller.wareHouseDetails.value.data?.brands?.map((brand) => brand.name).join(', '),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.bodyTextColor,
                      fontSize: 10.sp),
                )
              ]),),
              SizedBox(
                height: AppDimensions.contentPadding.h,
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: "Available Categories: ",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.headerTextColor,
                          fontSize: 10.sp),),
                  TextSpan(
                    text:controller.wareHouseDetails.value.data?.categories?.map((category) => category.name).join(', '),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.bodyTextColor,
                        fontSize: 10.sp),
                  )
                ]),
              ),
              SizedBox(
                height: AppDimensions.widgetPadding.h,
              ),
            ],
          )
        ],
      ),
    );
  }
}
