
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constraints/app_colors.dart';
import '../../../../constraints/body_text.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../constraints/header_text.dart';
import '../../../../models/single_warehouse_model.dart';
import '../../../routes/app_pages.dart';
import '../../shopDetails/controllers/shop_details_controller.dart';
import '../models/home_data_model.dart';


class SingleWareHouse extends StatelessWidget {
  final int index;
  final SingleWarehouseModel warehouse;
  final List<Category> categoryList;
  final String subTitle;
  final String address;
  final Future<String?> distanceFuture; // Future for distance

  const SingleWareHouse({
    required this.index,
    required this.warehouse,
    required this.categoryList,
    required this.subTitle,
    required this.address,
    required this.distanceFuture,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: distanceFuture,
      builder: (context, snapshot) {
        final distance = snapshot.data ?? "__";
        return _buildSingleWarehouse(distance);
      },
    );
  }

  Widget _buildSingleWarehouse(String distance) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [BoxShadow(color: AppColors.shadowColor, blurRadius: 10)],
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        border: Border.all(width: 1, color: AppColors.shadowColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.put(ShopDetailsController());
            Get.find<ShopDetailsController>().categoryList.value = categoryList;
            Get.find<ShopDetailsController>().getDetails(id: warehouse.id ?? "");
            Get.find<ShopDetailsController>().getProductsByWareHouse(wareHouseId: warehouse.id ?? "");
            Get.toNamed(Routes.SHOP_DETAILS);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                        color: AppColors.placeholderColor,
                      ),
                      child: Image.asset(
                        "assets/images/moc_image_${index%10}.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(.8),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: AppDimensions.contentPadding,
                      left: AppDimensions.contentPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BodyText(
                            text: "Always open",
                            color: Colors.white,
                            size: 14,
                            resize: false,
                          ),
                          SizedBox(height: 3.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < 5; i++)
                                Icon(
                                  Icons.star,
                                  color: i < 4 ? AppColors.warningColor : Colors.white,
                                  size: 14,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.contentPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText(
                        text: warehouse.name ?? "",
                        color: AppColors.primaryColor,
                        size: 13,
                        resizeable: false,
                        maxLine: 2,
                        align: TextAlign.start,
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Items: ",
                          style: TextStyle(
                            color: AppColors.bodyTextColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: warehouse.brands?.join(", "),
                              style: TextStyle(
                                color: AppColors.bodyTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: AppDimensions.contentPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.h, right: 3.w),
                            child: Icon(
                              Icons.location_on_sharp,
                              color: AppColors.primaryColor,
                              size: 12,
                            ),
                          ),
                          Expanded(
                            child: BodyText(
                              text: warehouse.mainBranch?.address ?? "",
                              size: 12,
                              resize: false,
                              align: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.h, right: 3.w),
                            child: Icon(
                              Icons.fire_truck,
                              color: AppColors.primaryColor,
                              size: 12,
                            ),
                          ),
                          Expanded(
                            child: BodyText(
                              text: "$distance away",
                              size: 12,
                              resize: false,
                              align: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



/*class SingleWareHouse extends StatelessWidget {
  final int index;
  final Warehouse warehouse;
  final List<Category> categoryList;
  final String subTitle;
  final String address;
  final Future<String?> distanceFuture; // Future for distance

  const SingleWareHouse({
    required this.index,
    required this.warehouse,
    required this.categoryList,
    required this.subTitle,
    required this.address,
    required this.distanceFuture,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: distanceFuture,
      builder: (context, snapshot) {
        final distance = snapshot.data ??
            "__"; // Get the distance from the snapshot or default to 0.0
        return _buildSingleWarehouse(distance);
      },
    );
  }

  Widget _buildSingleWarehouse(String distance) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: AppColors.shadowColor, blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
          border: Border.all(width: 1, color: AppColors.shadowColor)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.put(ShopDetailsController());
            Get.find<ShopDetailsController>().categoryList.value = categoryList;
            Get.find<ShopDetailsController>()
                .getDetails(id: warehouse.id ?? "");
            Get.find<ShopDetailsController>()
                .getProductsByWareHouse(wareHouseId: warehouse.id ?? "");

            // Get.find<ShopDetailsController>().shopName="P&G Warehouse";

            Get.toNamed(Routes.SHOP_DETAILS);
          },
          child: Flex(
            direction: Axis.vertical,
            children: [
              Flexible(
                flex: 5,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              AppDimensions.borderRadius.r),
                          color: AppColors.placeholderColor),
                      child: Image.asset(
                        "assets/images/moc_image_$index.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                              Colors.black.withOpacity(.8),
                              Colors.transparent
                            ])),
                      ),
                    ),
                    Positioned(
                      bottom: AppDimensions.contentPadding.h,
                      left: AppDimensions.contentPadding.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BodyText(
                            text: "Always open",
                            color: Colors.white,
                            size: 14,
                            resize: false,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.warningColor,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors.warningColor,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors.warningColor,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors.warningColor,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 14,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.contentPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText(
                        text: warehouse.name ?? "",
                        color: AppColors.primaryColor,
                        size: 13,
                        resizeable: false,
                        maxLine: 2,
                        align: TextAlign.start,
                      ),
                      Text.rich(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        TextSpan(
                            text: "Items: ",
                            style: TextStyle(
                                color: AppColors.bodyTextColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 12),
                            children: [
                              TextSpan(
                                text: subTitle,
                                style: TextStyle(
                                    color: AppColors.bodyTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: AppDimensions.contentPadding.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.h, right: 3.w),
                            child: Icon(Icons.location_on_sharp,
                                color: AppColors.primaryColor, size: 12),
                          ),
                          Expanded(
                            child: BodyText(
                              text: warehouse.mainBranch?.address ?? "",
                              size: 12,
                              resize: false,
                              align: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.h, right: 3.w),
                            child: Icon(Icons.fire_truck,
                                color: AppColors.primaryColor, size: 12),
                          ),
                          Expanded(
                            child: BodyText(
                              text: "$distance away",
                              size: 12,
                              resize: false,
                              align: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Your existing widget structure here
// Replace the usage of 'distance' with the calculated distance value
// Ensure to adjust any layout based on the distance value
}*/
