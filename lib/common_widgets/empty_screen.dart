import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constraints/app_strings.dart';
class EmptyScreen extends StatelessWidget {
  final double? height;
  final double? width;
  final String title;
  final double? scaleFactor;
  final Widget? button;
  
  const EmptyScreen({super.key,
   this.height,
   this.width,
    this.scaleFactor,
    this.button,
  required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width??Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset(AppImagePath.emptyIcon,scale: scaleFactor,),
          SizedBox(height: AppDimensions.contentPadding.h,),
          BodyText(text: title,size: 14,fontWeight: FontWeight.w600,),
          button??const Text(""),
      ],),
    );
  }
}
