
import 'package:cgp/common_widgets/custom_circle_avatar.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:cgp/models/order_history_single_order_model.dart';
import 'package:cgp/utils/enams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';
import '../../../routes/app_pages.dart';
import '../../orderDetails/controllers/order_details_controller.dart';

class SingleOrderCard extends StatelessWidget {
  final SingleOrderModel order;

  const SingleOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.put(OrderDetailsController());
        Get.find<OrderDetailsController>().getOrderDetails(orderId: (order.id??"0").toString());
        Get.toNamed(Routes.ORDER_DETAILS);
      },
      child: Row(
        children: [
          CustomCircleAvatar(
            width: 50,
            height: 50,
            image: "",
            localImage: order.orderType == OrderType.transportationOnly.name
                ? AppImagePath.deliveryVan
                : AppImagePath.orderCart,
            bgColor: AppColors.primaryColor.withOpacity(.1),
          ),
          SizedBox(width: AppDimensions.contentPadding.w,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppDimensions.widgetPadding.w,),
                  decoration: BoxDecoration(
                    color: Colors.green, // Background color
                    borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r), // Rounded corners
                  ),
                  child: HeaderText(
                    text: order.orderStatus,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
                BodyText(
                  text: order.orderType == OrderType.transportationOnly.name
                      ? "Transportation Only"
                      : "Product and Transportation",color: AppColors.primaryColor,size: 12,),
                BodyText(text:formatDateTime(dateTimeToConvert: (order.createdAt).toString()),size: 12, )
              ],
            ),
          ),
           Column(
             children: [
               const BodyText(text: "Total"),
               HeaderText(text: order.payableAmount??"0",color: AppColors.primaryColor,size: 14,)
             ],
           ),
           SizedBox(width: AppDimensions.contentPadding.w,),
           const Icon(Icons.arrow_forward_ios_sharp,color: AppColors.placeholderColor,)
        ],
      ),
    );
  }
}
