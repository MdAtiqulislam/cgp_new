import 'package:cgp/app/modules/orderDetails/models/order_details_model.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReviewAndRatingsController extends GetxController {
 // var reviews = <Review>[].obs;
  var orderDetails=OrderDetailsModel().obs;
  var rating = 0.0.obs;
  var usernameController = TextEditingController();
  var commentController = TextEditingController();
  var wareHouseReviewController = TextEditingController();
  var riderReviewController = TextEditingController();
  var warehouseRating=5.0.obs;
  var riderRating=5.0.obs;
  var isLoading=false.obs;

  Future<void> submitRiderReview() async{
    isLoading.value=true;
    var endPoint=APIEndPoints.addReview;
    var body={
      "orderId": orderDetails.value.data?.orderId,
      "given_to": "rider",
      "given_to_id": orderDetails.value.data?.deliveryInfo?.rider?.id,
      "rating": riderRating.value,
      "review": riderReviewController.text
    };
    try {
      var response=await RemoteServices.postRequestWithJsonData(endPoint: endPoint,body: body);
      if(response!=null){
        CustomSnackBar(
          isSuccess: true,
          msg: response["message"]
        ).showSnackBar();
      }else{
        CustomSnackBar(
            isSuccess: false,
            msg: AppStrings.httpErrorMSG.value
        ).showSnackBar();
      }
    } finally {
      isLoading.value=false;
    }
  }

  Future<void> submitWarehouseReview() async{
    isLoading.value=true;
    var endPoint=APIEndPoints.addReview;
    var body={
      "orderId": orderDetails.value.data?.orderId,
      "given_to": "warehouse",
      "given_to_id": orderDetails.value.data?.warehouse?.id,
      "rating": warehouseRating.value,
      "review": wareHouseReviewController.text
    };
    try {
      var response=await RemoteServices.postRequestWithJsonData(endPoint: endPoint,body: body);
      if(response!=null){
        CustomSnackBar(
            isSuccess: true,
            msg: response["message"]
        ).showSnackBar();
      }else{
        CustomSnackBar(
            isSuccess: false,
            msg: AppStrings.httpErrorMSG.value
        ).showSnackBar();
      }
    } finally {
      isLoading.value=false;
    }
  }
}
