import 'package:cgp/common_widgets/custom_app_bar.dart';
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

  const BaseScreen(
      {required this.body,
      this.showSlider = true,
      this.showLoading = false,
      this.bottomNavBar,
      super.key});

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
