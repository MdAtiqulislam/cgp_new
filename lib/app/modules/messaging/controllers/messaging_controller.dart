
import 'package:cgp/app/modules/orderDetails/models/order_details_model.dart';
import 'package:cgp/models/customer_model.dart';
import 'package:cgp/models/message_data_model.dart';
import 'package:cgp/models/send_message_response_model.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/utils/enams.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_snackbar.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../models/load_message_model.dart';
import '../../../../services/local_services.dart';
import '../../../../services/pusher_services.dart';
import '../../../../services/remote_services.dart';


class MessagingController extends GetxController {

  var isLoading=false.obs;
 var imageLink="".obs;
  var chatWith="".obs;
  var customer=CustomerModel().obs;
  var sendMessageResponseModel=SendMessageResponseModel();
 var loadMessageResponseModel = LoadMessageModel();

 var messages = <MessageDataModel>[].obs;
  var messageController = TextEditingController();

  late PusherService messageService;

  var orderDetails=OrderDetailsModel().obs;
 String? senderId;
 String? receiverId;
 String? orderId;
 String? replayById;
 String? replayToId;

 var disableChat=false.obs;



  @override
  Future<void> onInit() async {
    super.onInit();
    customer.value=await LocalServices.getUser()??CustomerModel();

  }

  void fetchMessages(String senderId) async {
    try {
      // var fetchedMessages = await messageService.fetchMessagesBySenderId(senderId);
      //  messages.assignAll(fetchedMessages);
    } catch (e) {
      print('Failed to load messages: $e');
    }
  }

  Future<void> sendMessage() async {
    final text = messageController.text;
    var url="https://cgp.studypress.org/api/v1/messaging/ajax/send-message";
    if (text.isNotEmpty) {
      var body={
        "sender_id":customer.value.userId,
        "receiver_id":orderDetails.value.data?.deliveryInfo?.rider?.userId,
        "order_id":orderDetails.value.data?.orderId,
        "reply_by_id":customer.value.id,//customer id
        "reply_to_id":orderDetails.value.data?.deliveryInfo?.rider?.id,// rider id
        "reply_by_type_id":24, // 24
        "reply_to_type_id":23,  //23
        "message":text,
      };

      messageController.clear();

      try {
        var response=await RemoteServices.chatPostRequest(url:url,body: body);
        if(response!=null){
          sendMessageResponseModel=SendMessageResponseModel.fromJson(response);
          messages.add(sendMessageResponseModel.data??MessageDataModel());

        }else{
          CustomSnackBar(
              isSuccess: false,
              msg: AppStrings.httpErrorMSG.value
          ).showSnackBar();
        }
      } finally {
        // TODO
      }


    }
  }
 Future<void> loadPreviousMessage() async {

   messages.value=[];
   isLoading.value=true;
   var link="https://cgp.studypress.org/api/v1/messaging/ajax/get-message-list";
   var parameters={
     "senderId": senderId??customer.value.userId.toString(),
     "receiverId": receiverId??orderDetails.value.data?.deliveryInfo?.rider?.userId.toString(),
     "orderId": orderId??orderDetails.value.data?.orderId.toString(),
   };
   try {
     var response=await RemoteServices.chatGetRequest(link: link,parameters: parameters);
     if(response!=null){
       loadMessageResponseModel=LoadMessageModel.fromJson(response);
       loadMessageResponseModel.data?.forEach((value){
         messages.value.add(value);
       });

     }
   } finally {
     isLoading.value=false;
   }
 }

 void initValue(){
   senderId=null;
   receiverId=null;
   orderId=null;
   replayById=null;
   replayToId=null;
 }

 void checkOrderStatus()async{
    isLoading.value=true;
    var endPoint=APIEndPoints.getOrderDetails.replaceAll("{orderId}", orderId??"");
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint);
      if(response!=null){
        orderDetails.value=OrderDetailsModel.fromJson(response);
        if(orderDetails.value.data?.deliveryInfo?.shippingStatus==OrderStatus.delivered.name){
          disableChat.value=true;
        }else{
          disableChat.value=false;
        }
      }else{
        disableChat.value=true;
      }
    } finally {
      isLoading.value=false;
    }
 }
}
