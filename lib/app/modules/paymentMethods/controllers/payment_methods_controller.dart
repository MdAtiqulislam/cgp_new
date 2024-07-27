
import 'package:cgp/app/modules/paymentMethods/models/payment_methods_model.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class PaymentMethodsController extends GetxController {
  var isLoading = false.obs;

  var paymentMethodListModel=PaymentMethodListModel().obs;

  CardFieldInputDetails? cardDetails;

  @override
  Future<void> onInit() async {
    super.onInit();
   await getAllPaymentMethods();
   Stripe.instance;
  }
  Future<void> addPaymentMethod() async {
    if (cardDetails == null || !cardDetails!.complete) {
      Get.snackbar("Error", "Card details not complete");
      return;
    }

    isLoading(true);
    try {
      // Create a payment method
      final paymentMethod = await Stripe.instance.createPaymentMethod(
       params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      String paymentMethodId = paymentMethod.id;
      print("Payment Method ID: $paymentMethodId");

      // Now send the payment method ID to your backend
      await savePaymentMethod(paymentMethodId);

    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
  Future<void> savePaymentMethod(String paymentMethodId) async {
    isLoading.value=true;
   var endPoint=APIEndPoints.addPaymentMethod;
   var body={
     "pmID": paymentMethodId,
     "isDefault": true
   };
   try {
     var response=await RemoteServices.postRequestWithJsonData(endPoint: endPoint,body: body);
     if(response!=null){
       Get.back();
       CustomSnackBar(
         isSuccess: true, msg: response["message"],
       ).showSnackBar();
       await getAllPaymentMethods();
     }else{
       CustomSnackBar(
         isSuccess: false, msg: AppStrings.httpErrorMSG.value,
       ).showSnackBar();
     }
   } finally {
     isLoading.value=false;
   }
  }

  Future<void>getAllPaymentMethods()async{
    isLoading.value=true;
    var endPoint=APIEndPoints.getPaymentMethods;
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint);
      if(response!=null){
        paymentMethodListModel.value=PaymentMethodListModel.fromJson(response);
      }
    } finally {
      isLoading.value=false;
    }
  }

  Future<void> deletePaymentMethod({required String pmId})async {
    isLoading.value=true;
    var endPoint=APIEndPoints.deletePaymentMethod.replaceAll("{pmID}", pmId);
    try {
      var response=await RemoteServices.deleteRequest(endPoint: endPoint);
      if(response!=null){
        await getAllPaymentMethods();
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

  Future<void> setDefault({required String pmId})async {
    isLoading.value=true;
    var endPoint=APIEndPoints.setDefaultPaymentMethod.replaceAll("{pmID}", pmId);
    try {
      var response=await RemoteServices.putRequest(endPoint: endPoint);
      if(response!=null){
        await getAllPaymentMethods();
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
