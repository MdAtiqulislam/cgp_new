
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../models/single_product_model.dart';

class SingleGridItem extends StatelessWidget {
  final int index;//index is used only for dummy images
  final SingleProductModel? product;
  final VoidCallback onTap;

  const SingleGridItem({
   required this.onTap,
    required this.index,
     this.product,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        border: Border.all(width: 1,color: AppColors.shadowColor),
        boxShadow: const [BoxShadow(
          color: AppColors.shadowColor,
          blurRadius: 10,
        )]
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius.r)),
                  child: Image.asset(
                    "assets/images/moc_image_${index % 10}.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                  flex: 5,
                  child: Container(
                    width: Get.width,
                    //  color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: AppDimensions.contentPadding.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.h,),
                         HeaderText(
                          text: product?.productName??"",
                          size: 14,
                          align: TextAlign.start,
                          resizeable: false,
                           maxLine: 2,
                        ),
                        BodyText(text: product?.shortDesc??"",align: TextAlign.start,maxLine: 2,size: 12,resize: false,),
                        Text.rich(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          TextSpan(
                              text: "Brand: ",
                              style: TextStyle(
                                  color: AppColors.headerTextColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                              children: [
                                TextSpan(
                                  text: product?.brandName??"",
                                  style: TextStyle(
                                      color: AppColors.bodyTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                        ),
                        if(double.parse((product?.regularPrice??"0.0"))>0) Text.rich(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          TextSpan(
                              text: "Price: ",
                              style: TextStyle(
                                  color: AppColors.headerTextColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                              children: [
                                TextSpan(
                                  text: product?.regularPrice??"",
                                  style: TextStyle(
                                      color: AppColors.bodyTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),),
            ],
          ),
        ),
      ),
    );
  }
}
