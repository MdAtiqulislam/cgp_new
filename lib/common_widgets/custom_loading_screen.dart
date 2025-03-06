import 'package:cgp/constraints/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constraints/app_colors.dart';

class LoadingScreen extends StatelessWidget {
  final bool showAnimation;
  final bool transparentBackground;

  const LoadingScreen({
    this.transparentBackground=true,
    this.showAnimation = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      color:showAnimation
          ?Colors.white
          : Colors.black12,
      child: showAnimation
          ? Center(
              child: Image.asset(
                AppImagePath.loadingAnimation,
                height: 48.r,
                width: 48.r,
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
    );
  }
}
