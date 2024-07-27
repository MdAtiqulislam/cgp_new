import 'package:cgp/app/modules/orderDetails/controllers/order_details_controller.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:cgp/models/cancel_reason_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constraints/dimensions.dart';

class SingleCancelReasonCard extends GetView<OrderDetailsController> {
  final CancelReasonModel cancelReason;
  const SingleCancelReasonCard(
      {super.key, required this.cancelReason});

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Material(
      color: Colors.transparent,
      child: InkWell(
        onTap:(){
          controller.selectedCancelReason.value=cancelReason;
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPadding.w,
              vertical: AppDimensions.contentPadding.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(controller.selectedCancelReason.value.id==cancelReason.id)const Icon(Icons.circle,color: AppColors.successColor,size: 16,),
              if(controller.selectedCancelReason.value.id!=cancelReason.id)const Icon(Icons.circle_outlined,color: AppColors.inactiveColor,size: 16,),
              SizedBox(width: AppDimensions.contentPadding.w,),
              HeaderText(text: cancelReason.reason??'',maxLine: 20,color: AppColors.primaryColor,size: 12,)
            ],
          ),
        ),
      ),
    ),);
  }
}
