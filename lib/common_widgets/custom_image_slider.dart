import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../constraints/app_colors.dart';
import '../constraints/app_strings.dart';
import '../constraints/dimensions.dart';
import 'custom_network_image.dart';

class ImageSliderController extends GetxController {
  RxInt dotPosition = 0.obs;

  void updatePosition(int index) {
    dotPosition.value = index;
  }
}

class CustomImageSlider extends StatelessWidget {
  final List items;
  final double height;
  final bool autoPlay;
  final bool revers;

  CustomImageSlider({
    super.key,
    required this.items,
    required this.height,
    this.autoPlay = true,
    this.revers = false,
  });

  final ImageSliderController controller = Get.put(ImageSliderController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (items.isEmpty)
          Container(
            height: height,
            width: Get.width,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 2),
              ],
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
            ),
            child: Image.asset(
              AppImagePath.noImage,
              fit: BoxFit.cover,
            ),
          ),
        CarouselSlider(
          items: items.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: Get.width,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2),
                    ],
                    borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
                  ),
                  child: CustomNetworkImage(
                    image: i,
                    localImage: AppImagePath.noImage,
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            onPageChanged: (i, r) {
              controller.updatePosition(i);
            },
            height: height,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: revers,
            autoPlay: autoPlay,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPadding.w,
              vertical: AppDimensions.verticalPadding.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppDimensions.borderRadius.r),
                bottomRight: Radius.circular(AppDimensions.borderRadius.r),
              ),
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ],
              ),
            ),
            child: dotIndicator(),
          ),
        ),
      ],
    );
  }

  Widget dotIndicator() {
    return Obx(
          () => Center(
        child: DotsIndicator(
          dotsCount: items.isEmpty ? 1 : items.length,
          position: controller.dotPosition.value,
          decorator: DotsDecorator(
           // color: Colors.white,
            activeColor: AppColors.primaryColor,
            size: const Size.square(9.0),
            activeSize: const Size(25.0, 12),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }
}
