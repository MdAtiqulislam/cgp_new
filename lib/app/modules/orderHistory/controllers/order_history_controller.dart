import 'package:cgp/app/modules/orderHistory/models/order_history_model.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:get/get.dart';

class OrderHistoryController extends GetxController {

  var isLoading=false.obs;
  var orderHistoryModel=OrderHistoryModel().obs;


  @override
  void onInit() async{
    super.onInit();
   // await getOrderHistory();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void>getOrderHistory()async{
    isLoading.value=true;
    var endPoint=APIEndPoints.orderHistory;
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint);
      if(response!=null){
        orderHistoryModel.value=OrderHistoryModel.fromJson(response);
      }
    } finally {
      isLoading.value=false;
    }
  }
}
