import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_image_slider.dart';
import 'package:cgp/common_widgets/custom_loading_screen.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constraints/app_strings.dart';

class BaseScreen extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavBar;
  final bool showSlider;
  final bool showLoading;

  BaseScreen(
      {required this.body,
      this.showSlider = true,
      this.showLoading = false,
      this.bottomNavBar,
      super.key});

  final List<String> images = [
    "assets/images/slider_1.png",
    "assets/images/slider_2.png",
    "assets/images/slider_3.png",
    "assets/images/slider_4.png",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: bottomNavBar,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                if (showSlider)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.horizontalPadding.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: AppDimensions.sectionPadding.h,
                          ),

                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle
                            ),
                            child: Image.asset(AppImagePath.appIcon,scale: 3,),),
                         // CustomImageSlider(items: images, height: 130.h)

                          /*Container(
                          height: 130.h,
                          width: Get.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: AppDimensions.horizontalPadding.w),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(AppDimensions.borderRadius.r),
                              color: AppColors.placeholderColor),
                          child: const Center(child: HeaderText(text: "Promotional Banner Slider",color: Colors.white,fontWeight: FontWeight.w700,size: 20,),),
                        )*/

                        ],
                      ),
                    ),
                  ),

                SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppDimensions.sectionPadding.h,
                  ),
                ),

                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.horizontalPadding.w),
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(width: Get.width, child: body),
                          SizedBox(
                            height: AppDimensions.sectionPadding.h,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                // SliverPadding(padding: EdgeInsets.only(bottom: AppDimensions.verticalPadding.h))
                //     SliverToBoxAdapter(child: SizedBox(height: AppDimensions.sectionPadding.h,),),
              ],
            ),
            if (showLoading) const LoadingScreen()
          ],
        ),
      ),
    );
  }
}
