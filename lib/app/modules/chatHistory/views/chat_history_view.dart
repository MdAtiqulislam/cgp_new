

import 'package:cgp/common_widgets/my_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../common_widgets/custom_circle_avatar.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/body_text.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../constraints/header_text.dart';
import '../../../routes/app_pages.dart';
import '../../messaging/controllers/messaging_controller.dart';
import '../controllers/chat_history_controller.dart';
import '../models/chat_history_model.dart';

class ChatHistoryView extends GetView<ChatHistoryController> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ChatHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: CustomAppBar(
          minimal: false,
          scaffoldKey: scaffoldKey,
        ),
        drawer: MyDrawer(),
        body: Obx(
              () => Stack(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
                child: ListView.separated(
                  itemCount: controller.chatHistoryModel.value.data?.length ?? 0,
                  itemBuilder: (buildContext, index) {
                    return singleItem(
                        data: controller.chatHistoryModel.value.data?[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                ),
              ),
              if (controller.isLoading.value) const LoadingScreen()
            ],
          ),
        ),
      ),
    );
  }

  Widget singleItem({ChatHistoryData? data}) {
    return ListTile(
      onTap: () {
        controller.changeStatus(orderId: (data?.orderId??"").toString(), receiverId: (data?.receiverId??"").toString());
        Get.put(MessagingController());
        Get.find<MessagingController>().orderId= (data?.orderId??"").toString();
        Get.find<MessagingController>().senderId= (data?.senderId??"").toString();
        Get.find<MessagingController>().receiverId= (data?.receiverId??"").toString();
        Get.find<MessagingController>().replayById= (data?.replyById??"").toString();
        Get.find<MessagingController>().replayToId= (data?.replyToId??"").toString();
        Get.find<MessagingController>().checkOrderStatus();
        Get.find<MessagingController>().chatWith.value= "${data?.customer?.firstName??""} ${data?.customer?.firstName??""}";

        Get.find<MessagingController>().loadPreviousMessage(
        );
        Get.toNamed(Routes.MESSAGING);
      },
      leading: Stack(
        children: [
          CustomCircleAvatar(
            width: 50,
            height: 50,
            image:  "", // Add image if available
          ),
          if ((data?.unreadCount??0)> 0)
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle
                ),
                constraints: BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Center(
                  child: Text(
                    '${data?.unreadCount??0}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
      title: HeaderText(
        text: "${data?.customer?.firstName ?? " "} ${data?.customer?.lastName ?? ""}",align: TextAlign.start,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyText(text: "Order ID: ${data?.orderId ?? ""}"),
          Row(
            children: [
              Expanded(child: BodyText(text: data?.message ?? "",align: TextAlign.start,)),
              HeaderText(text: controller.formatDateTime(data?.updatedAt??DateTime.now()),size: 12,)
            ],
          ),
        ],
      ),
      trailing: Icon(Icons.arrow_forward_ios_sharp, color: AppColors.iconColor),
    );
  }





}
