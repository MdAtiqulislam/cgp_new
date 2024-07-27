import 'package:cgp/app/modules/notifications/views/single_notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/custom_title.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../../../constraints/dimensions.dart';
import '../controllers/notifications_controller.dart';
import '../models/notifications_model.dart';

class NotificationsView extends GetView<NotificationsController> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: scaffoldKey,
          minimal: false,
        ),
        drawer: MyDrawer(
        ),
        body: Obx(
              () => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPadding.w),
              child: Stack(
                children: [
                  bodyContent(),
                  if (controller.isLoading.value) const LoadingScreen()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyContent() {
    return Column(
      children: [
        SizedBox(
          height: AppDimensions.sectionPadding.h,
        ),
        const CustomTitle(title: "Notifications"),
        ListView.builder(
            itemCount: controller.notificationsModel.value.data?.length??0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (buildContext, index) {
              return SingleNotificationCard(
                notificationModel:
                controller.notificationsModel.value.data?[index] ??
                    SingleNotificationModel(),
                onTap: () {
                  controller.handelClick(
                      notification:controller.notificationsModel.value.data?[index]??SingleNotificationModel()
                  );
                },
              );
            })
      ],
    );
  }
}
