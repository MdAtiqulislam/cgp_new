import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:cgp/other_controllers/appbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app/routes/app_pages.dart';
import '../constraints/app_colors.dart';
import 'custom_circle_avatar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool minimal;
  final VoidCallback? openDrawer;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  CustomAppBar(
      {this.scaffoldKey, this.openDrawer, this.minimal = true, super.key});

  final appBarController = Get.put(AppbarController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 70.h,
        margin:
            EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.lineColor, width: 1.h),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            minimal
                ? const HeaderText(text: "TradeBar - Customer",color: AppColors.primaryColor,)
                : const HeaderText(text: "TradeBar - Customer",color: AppColors.primaryColor,),
            if (appBarController.isLoading.value)
              const BodyText(text: "Loading..."),
            minimal
                ? const BodyText(
                    text: "Account",
                    color: AppColors.primaryColor,
                    size: 10,
                  )
                : Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          onTap: () {
                            appBarController.openNotificationPage();
                          },
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Center(
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Image.asset(
                                    AppImagePath.notificationIcon,
                                    //height: 50,
                                  ),
                                  if (appBarController
                                          .unreadNotifications.value >
                                      0)
                                    Positioned(
                                      top: -5,
                                      right: -10,
                                      child: Container(
                                        clipBehavior: Clip.none,
                                        height: 18,
                                        width: 18,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.errorColor),
                                        child: Center(
                                          child: BodyText(
                                            text: (appBarController
                                                        .unreadNotifications) >=
                                                    10
                                                ? "9+"
                                                : "${appBarController.unreadNotifications}",
                                            color: Colors.white,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 24.w,
                        ),
                        InkWell(
                          onTap: () {
                            scaffoldKey?.currentState?.openDrawer();
                          },
                          child: CustomCircleAvatar(
                            width: 30,
                            height: 30,
                            image: "",
                          ),
                        ),
                        SizedBox(
                          width: 24.w,
                        ),
                        InkWell(
                          onTap: () {
                            scaffoldKey?.currentState?.openDrawer();
                          },
                          child: Image.asset(
                            AppImagePath.menuBar,
                            height: 30,
                          ),
                        ),
                        /*SizedBox(
                        width: 24.w,
                      )*/
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(Get.width, 70.h);
}
