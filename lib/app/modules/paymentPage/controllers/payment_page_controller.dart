import 'package:cgp/app/modules/orderDetails/controllers/order_details_controller.dart';
import 'package:cgp/app/modules/transportation/models/transportation_order_model.dart';
import 'package:cgp/app/modules/transportation/models/vehicles_model.dart';
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/models/single_address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import '../../transportation/models/transportation_calculation_model.dart';

class PaymentPageController extends GetxController {

  var clientSecret="".obs;
  var paymentFor="";//"transportation", "product"
  var pickupAddress=SingleAddressModel().obs;
  var deliveryAddress=SingleAddressModel().obs;
  var transportOrderDetails=TransportationOrderModel().obs;
  var selectedVehicle=SingleVehicleModel().obs;
  var calculationModel = TransportationCalculationModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}


  Future<void> makePayment() async {
    try {
      //  paymentIntent = await createPaymentIntent("10", "USD");
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret.value,
            //  applePay: const PaymentSheetApplePay(merchantCountryCode: '+92'),
            // googlePay: const PaymentSheetGooglePay(merchantCountryCode: "+92"),
            style: ThemeMode.light,
            merchantDisplayName: "CGP",
          ))
          .then((value) {
        print(value);
      });
      displayPaymentSheet();
    } on Exception catch (e) {
      print(e);
    }
  }

  void displayPaymentSheet() async {
    try {

      await Stripe.instance.presentPaymentSheet().then((value) {

        CustomSnackBar(
          msg: "Thank you for completing payment.",
          isSuccess: true
        ).showSnackBar();
        Get.offAllNamed(Routes.HOME);
        Get.put(OrderDetailsController());
        Get.find<OrderDetailsController>().getOrderDetails(orderId: "${transportOrderDetails.value.data?.order?.id??""}");
        Get.toNamed(Routes.ORDER_DETAILS);
        clientSecret.value="";
      }).onError((E,x){
        print(x);
      });
    } on Exception catch (e) {
      print(e);
    }
  }


}
