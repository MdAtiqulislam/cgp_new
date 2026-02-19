import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common_widgets/common_description.dart';

class SingleGroupCartItem extends StatelessWidget {

 final VoidCallback? onTap;
  SingleGroupCartItem({super.key,this.onTap});

  final ScrollController scrollController = ScrollController();

  var currentPosition = 0.0;
  var selectedIndex = 0;
  final items = [
    "assets/images/moc_image_0.png",
    "assets/images/moc_image_1.png",
    "assets/images/moc_image_2.png",
    "assets/images/moc_image_3.png",
    "assets/images/moc_image_4.png",
    "assets/images/moc_image_5.png",
    "assets/images/moc_image_6.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 110.w,
              // height: 100.h,
              child: Image.asset(
                "assets/images/moc_image_6.png",
                width: 100.w,
                //height: 120.sp,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: AppDimensions.widgetPadding.w,
            ),
            detailsSection()
          ],
        ),
        bottomSection(),
      ],
    );
  }

  Widget bottomSection() {
    return Column(
      children: [
        SizedBox(
          height: AppDimensions.contentPadding.h,
        ),
        Row(
          children: [
            SizedBox(
              width: 100.w,
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        if (currentPosition > 0) {
                          currentPosition -= 30;
                        }
                        if (currentPosition < 0) {
                          currentPosition = 0;
                        }
                        scrollController.animateTo(currentPosition,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.bounceIn);
                      },
                      child: Icon(
                        Icons.arrow_circle_left_rounded,
                        size: 20.sp,
                      )),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      height: 30.sp,
                      child: ListView.separated(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (buildContext, index) {
                          return Container(
                            margin: selectedIndex == index
                                ? EdgeInsets.zero
                                : EdgeInsets.all(1),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.r),
                                border: selectedIndex == index
                                    ? Border.all(
                                        color: AppColors.successColor
                                            .withOpacity(.5),
                                        width: 1.5)
                                    : Border.all()),
                            child: Image.asset(items[index]),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 2.w,
                          );
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (currentPosition <=
                          scrollController.position.maxScrollExtent) {
                        currentPosition += 30;
                      } else {}
                      scrollController.animateTo(currentPosition,
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.bounceIn);
                    },
                    child: Icon(
                      Icons.arrow_circle_right_rounded,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: AppDimensions.widgetPadding.w,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const HeaderText(
                    text: 'Total Price: 1500 AUD',
                    size: 12,
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.borderRadius.r),
                        color: AppColors.primaryColor),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onTap,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.contentPadding,
                                vertical: 3.h),
                            child: const HeaderText(
                              text: "Order Now",
                              size: 12,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: AppDimensions.contentPadding.h,
        ),
      ],
    );
  }

  Widget detailsSection() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderText(
                  text: "From Timber Mart (4 Items)",
                  color: AppColors.primaryColor,
                  size: 12,
                ),
                SizedBox(height: 5.h,),
                const HeaderText(text: "Triangular Trusses (Qty 01)",size: 11,fontWeight: FontWeight.w600,),
               /* const CommonDescription(
                  fontSize: 10,
                  contentPadding: 70,
                  price: 500,
                  sizeHeight: ,
                  brand: "Lorem ipsum dolor",
                  material: "Steel, Wood, Iron",
                  weight: "1.2 ton",

                )*/
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Image.asset(
              AppImagePath.deleteIcon,
              height: 20.sp,
            ),
          ),

        ],
      ),
    ) /* */;
  }
}
