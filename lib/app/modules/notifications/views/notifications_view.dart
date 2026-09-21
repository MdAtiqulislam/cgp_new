/*
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
*/


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
        drawer: MyDrawer(),
        body: Obx(
              () => Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.horizontalPadding.w,
                  ),
                  child: bodyContent(context),
                ),
              ),

              /// 🔥 Loading
              if (controller.isLoading.value) const LoadingScreen(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyContent(BuildContext context) {
    final list = controller.notificationsModel.value.data ?? [];

    return Column(
      children: [
        SizedBox(height: AppDimensions.sectionPadding.h),

        /// 🔥 Header
        Row(
          children: [
            const Expanded(child: CustomTitle(title: "Notifications")),

            /// 👉 Show menu only if list not empty
            if (list.isNotEmpty)
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == "read_all") {
                    controller.markAllAsRead();
                  } else if (value == "delete_all") {
                    final confirm = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Delete All Notifications"),
                          content: const Text(
                              "Are you sure you want to delete all notifications?"),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(false),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(true),
                              child: const Text("Delete All"),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm == true) {
                      controller.deleteAllNotifications();
                    }
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: "read_all",
                    child: Text("Mark all as read"),
                  ),
                  PopupMenuItem(
                    value: "delete_all",
                    child: Text("Delete all"),
                  ),
                ],
              ),
          ],
        ),

        SizedBox(height: 10.h),

        /// 🔥 Empty State
        if (list.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: const Text("No notifications"),
          ),

        /// 🔥 List
        ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final notification = list[index];

            return Dismissible(
              key: Key(notification.id ?? index.toString()),
              direction: DismissDirection.horizontal,

              /// 👉 Left
              background: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),

              /// 👉 Right
              secondaryBackground: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),

              /// 🔥 Confirm before delete
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Delete Notification"),
                      content: const Text(
                          "Are you sure you want to delete this?"),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pop(false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pop(true),
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                );
              },

              /// 👉 After confirm
              onDismissed: (direction) {
                controller.deleteNotificationById(
                  notification.id ?? "",
                  index,
                );
              },

              child: SingleNotificationCard(
                notificationModel:
                notification ?? SingleNotificationModel(),
                onTap: () {
                  controller.handelClick(
                    notification: notification ??
                        SingleNotificationModel(),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}