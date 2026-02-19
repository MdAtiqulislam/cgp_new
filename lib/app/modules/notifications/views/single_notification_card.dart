
import 'package:cgp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/body_text.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../constraints/header_text.dart';
import '../models/notifications_model.dart';

class SingleNotificationCard extends StatelessWidget {
  final SingleNotificationModel notificationModel;
  final Function() onTap;
  const SingleNotificationCard({
    required this.notificationModel,
    required this.onTap,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(vertical: AppDimensions.contentPadding.h),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
          boxShadow: const [BoxShadow(color: AppColors.shadowColor, blurRadius: 10)]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){
            onTap();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPadding.w,
                vertical: AppDimensions.contentPadding.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText(text: notificationModel.title ?? "",maxLine: 3,align: TextAlign.start,),
                      BodyText(text: notificationModel.message ?? "",align: TextAlign.start,),
                      SizedBox(height: AppDimensions.contentPadding.h,),
                      SizedBox(
                        width: Get.width,
                        child: BodyText(
                          text:
                              formatDateTime(dateTimeToConvert: notificationModel.createdAt.toString()),
                          color: AppColors.primaryColor,
                          align: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
                if (!(notificationModel.isRead ?? true))
                  const Icon(
                    Icons.circle,
                    color: AppColors.successColor,
                    size: 15,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
