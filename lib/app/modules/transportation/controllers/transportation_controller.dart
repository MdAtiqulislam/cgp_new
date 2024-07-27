
import 'package:cgp/app/modules/cart/checkOut/models/address_model.dart';
import 'package:cgp/app/modules/paymentPage/controllers/payment_page_controller.dart';
import 'package:cgp/app/modules/transportation/models/transportation_calculation_model.dart';
import 'package:cgp/app/modules/transportation/models/transportation_order_model.dart';
import 'package:cgp/app/modules/transportation/models/vehicles_model.dart';
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/models/customer_model.dart';
import 'package:cgp/models/single_address_model.dart';
import 'package:cgp/other_controllers/floating_controller.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/local_services.dart';
import 'package:cgp/services/location_services.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:cgp/utils/enams.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import '../../../../other_controllers/appbar_controller.dart';
import '../../notifications/controllers/notifications_controller.dart';
import '../../orderHistory/models/order_history_model.dart';

class TransportationController extends GetxController {
  var isLoading = true.obs;
  var pickupController = TextEditingController();
  var destinationController = TextEditingController();
  var pickupPoint = [].obs;
  var destinationPoint = [].obs;
  var vehiclesModel = VehiclesModel().obs;
  var selectedVehicle = SingleVehicleModel().obs;
  var calculationModel = TransportationCalculationModel().obs;
  var pickupPlaceMark = <Placemark>[].obs;
  var destinationPlaceMark = <Placemark>[].obs;
  var pickUpAddressModel=SingleAddressModel().obs;
  var deliveryAddressModel=SingleAddressModel().obs;

  var allAddresses=AddressListModel().obs;

  var pickupAddress=<SingleAddressModel>[].obs;
  var shippingAddress=<SingleAddressModel>[].obs;

  var selectedPickupAddress=SingleAddressModel().obs;
  var selectedShippingAddress=SingleAddressModel().obs;

  var pickUpFirstNameController = TextEditingController();
  var pickUpLastNameController = TextEditingController();
  var pickUpPhoneController = TextEditingController();
  var pickUpCountryController = TextEditingController();
  var pickUpStateController = TextEditingController();
  var pickUpCityController = TextEditingController();
  var pickUpRoadController = TextEditingController();
  var pickUpBlockController = TextEditingController();
  var pickUpHouseController = TextEditingController();
  var pickUpZipController = TextEditingController();
  var pickUpAddressController = TextEditingController();

  var deliveryFirstNameController = TextEditingController();
  var deliveryLastNameController = TextEditingController();
  var deliveryPhoneController = TextEditingController();
  var deliveryCountryController = TextEditingController();
  var deliveryStateController = TextEditingController();
  var deliveryCityController = TextEditingController();
  var deliveryRoadController = TextEditingController();
  var deliveryBlockController = TextEditingController();
  var deliveryHouseController = TextEditingController();
  var deliveryZipController = TextEditingController();
  var deliveryAddressController = TextEditingController();

 var orderFor=["For Myself","For Other"];
 var selectedOrderFor="For Myself".obs;

  var onGoingRequests = OrderHistoryModel().obs;

 var customer=CustomerModel().obs;

  @override
  void onInit() async{
    super.onInit();
    getVehiclesData();
    getAllAddress();
    await getCustomerData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleForegroundNotification(Get.context!);
    });
    getNotificationData();


  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> getVehiclesData() async {
    var endPoint = APIEndPoints.getVehicles;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        vehiclesModel.value = VehiclesModel.fromJson(response);
      } else {
        CustomSnackBar(msg: AppStrings.httpErrorMSG.value, isSuccess: false)
            .showSnackBar();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> calculateSummary() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.calculateTransportSummary;


    var body = {
      "pickup_coordinates": selectedPickupAddress.value.id==null
          ?"${pickupPoint[1]}, ${pickupPoint[2]}"
          :"${selectedPickupAddress.value.latitude}, ${selectedPickupAddress.value.longitude}",
      "shipping_coordinates":selectedShippingAddress.value.id==null
          ?"${destinationPoint[1]}, ${destinationPoint[2]}"
          :"${selectedShippingAddress.value.latitude}, ${selectedShippingAddress.value.longitude}",
      "vehicle_type_id": selectedVehicle.value.typeId.toString()
    };
    try {
      var response = await RemoteServices.postRequestWithJsonData(
          endPoint: endPoint, body: body);
      if (response != null) {
        calculationModel.value =
            TransportationCalculationModel.fromJson(response);
      } else {
        CustomSnackBar(msg: AppStrings.httpErrorMSG.value, isSuccess: false)
            .showSnackBar();
      }
    } finally {
      isLoading.value = false;
    }
  }

  String getExtraMillageCost() {
    String extraMillageCost = "";
    double extraMillage =
        double.parse(calculationModel.value.data?.extraMilage ?? "0.0");
    double extraMillageFare =
        double.parse(selectedVehicle.value.perKmFare ?? "0.0");
    var totalCost = extraMillage * extraMillageFare;
    extraMillageCost +=
        "${calculationModel.value.data?.extraMilage ?? "0.0"} X ${selectedVehicle.value.perKmFare ?? "0.0"} = $totalCost AUD";
    return extraMillageCost;
  }

  String getExtraMinuteCost() {
    String extraMinuteCost = "";
    double extraMinute =
        double.parse(calculationModel.value.data?.extraMinute ?? "0.0");
    double extraMinuteFare =
        double.parse(selectedVehicle.value.perMinutesFare ?? "0.0");
    var totalCost = extraMinute * extraMinuteFare;
    extraMinuteCost +=
        "${calculationModel.value.data?.extraMinute ?? "0.0"} X ${selectedVehicle.value.perMinutesFare ?? "0.0"} = $totalCost AUD";
    return extraMinuteCost;
  }

  void getAddressesData() async {
    if(selectedPickupAddress.value.id!=null){
       pickUpFirstNameController.text = selectedPickupAddress.value.firstName??"";
       pickUpLastNameController.text = selectedPickupAddress.value.lastName??"";
       pickUpPhoneController.text = selectedPickupAddress.value.phoneNumber1??"";
       pickUpCountryController.text = selectedPickupAddress.value.countryId??"";
       pickUpStateController.text = selectedPickupAddress.value.state??"";
       pickUpCityController.text = selectedPickupAddress.value.city??"";
       pickUpZipController.text = selectedPickupAddress.value.postalCode??"";
       pickUpAddressController.text = selectedPickupAddress.value.address??"";
    }else{
      pickUpFirstNameController.text=customer.value.firstName??"";
      pickUpLastNameController.text=customer.value.lastName??"";
      pickUpPhoneController.text=customer.value.phone??"";

      pickupPlaceMark.value = await LocationServices.getPlaceMarksFromLatLng(
          lat: pickupPoint[1].toString(), lng: pickupPoint[2].toString());
      pickUpCountryController.text = pickupPlaceMark.first.country ?? "";
      pickUpZipController.text = pickupPlaceMark.first.postalCode ?? "";
      pickUpAddressController.text = pickupPlaceMark.first.street ?? "";
    }
    if(selectedShippingAddress.value.id!=null){
      deliveryFirstNameController.text = selectedShippingAddress.value.firstName??"";
      deliveryLastNameController.text = selectedShippingAddress.value.lastName??"";
      deliveryPhoneController.text = selectedShippingAddress.value.phoneNumber1??"";
      deliveryCountryController.text = selectedShippingAddress.value.countryId??"";
      deliveryStateController.text = selectedShippingAddress.value.state??"";
      deliveryCityController.text = selectedShippingAddress.value.city??"";
      deliveryZipController.text = selectedShippingAddress.value.postalCode??"";
      deliveryAddressController.text = selectedShippingAddress.value.address??"";
    }else{
      deliveryFirstNameController.text=customer.value.firstName??"";
      deliveryLastNameController.text=customer.value.lastName??"";
      deliveryPhoneController.text=customer.value.phone??"";



      destinationPlaceMark.value = await LocationServices.getPlaceMarksFromLatLng(
          lat: destinationPoint[1].toString(),
          lng: destinationPoint[2].toString());
      deliveryCountryController.text = destinationPlaceMark.first.country ?? "";
      deliveryZipController.text = destinationPlaceMark.first.postalCode ?? "";
      deliveryAddressController.text = destinationPlaceMark.first.street ?? "";

    }



  }

  Future<void> placeOrder() async {
    Get.back();
    isLoading.value=true;
    TransportationOrderModel transportationOrderModel=TransportationOrderModel();
    var endPoint = "${APIEndPoints.orderTransport}?payment_client=app";


    if(selectedPickupAddress.value.id!=null){
      pickUpAddressModel.value=selectedPickupAddress.value;
    }else{
      pickUpAddressModel.value=SingleAddressModel.fromJson({
        "first_name": pickUpFirstNameController.text,
        "last_name": pickUpLastNameController.text,
        "phone_number_1": pickUpPhoneController.text,
        "phone_number_2": "",
        "address": pickUpAddressController.text,
        "city": pickUpCityController.text,
        "state": pickUpStateController.text,
        "postal_code": pickUpZipController.text,
        "country_id": pickupPlaceMark.first.country,
        "latitude": pickupPoint[1],
        "longitude":pickupPoint[2],
        "notes": "",
        "address_type": "pickup",
        "is_default": true
      });
    }

    if(selectedShippingAddress.value.id!=null){
      deliveryAddressModel.value=selectedShippingAddress.value;
    }else{
      deliveryAddressModel.value=SingleAddressModel.fromJson({
        "first_name": deliveryFirstNameController.text,
        "last_name": deliveryLastNameController.text,
        "phone_number_1": deliveryPhoneController.text,
        "phone_number_2": "",
        "address": deliveryAddressController.text,
        "city": deliveryCityController.text,
        "state": deliveryStateController.text,
        "postal_code": deliveryZipController.text,
        "country_id": destinationPlaceMark.first.country,
        "latitude": destinationPoint[1],
        "longitude":destinationPoint[2],
        "notes": "",
        "address_type": "shipping",
        "is_default": true
      });
    }



    var body={
      "pickup_address":
      {
        "first_name": pickUpFirstNameController.text,
        "last_name": pickUpLastNameController.text,
        "phone_number_1": pickUpPhoneController.text,
        "phone_number_2": "",
        "address": pickUpAddressController.text,
        "city": pickUpCityController.text,
        "state": pickUpStateController.text,
        "postal_code": pickUpZipController.text,
        "country_id": pickUpCountryController.text,
        "latitude": selectedPickupAddress.value.latitude??pickupPoint[1].toString(),
        "longitude": selectedPickupAddress.value.longitude??pickupPoint[2].toString(),
        "notes": "",
        "address_type": "pickup",
        "is_default": true
      },
      "shipping_address":
      {
        "first_name": deliveryFirstNameController.text,
        "last_name": deliveryLastNameController.text,
        "phone_number_1": deliveryPhoneController.text,
        "phone_number_2": "",
        "address": deliveryAddressController.text,
        "city": deliveryCityController.text,
        "state": deliveryStateController.text,
        "postal_code": deliveryZipController.text,
        "country_id": destinationController.text,
        "latitude":selectedShippingAddress.value.latitude?? destinationPoint[1].toString(),
        "longitude":selectedPickupAddress.value.longitude?? destinationPoint[2].toString(),
        "notes": "",
        "address_type": "shipping",
        "is_default": true
      },
      "distance":calculationModel.value.data?.distance??"0",
      "duration":calculationModel.value.data?.duration??"0",
      "vehicle_type_id": selectedVehicle.value.typeId.toString(),
      "total_cost": calculationModel.value.data?.totalCost??"0",
      "gst": calculationModel.value.data?.gst??"0",
      "payable_amount": calculationModel.value.data?.payableAmount??"0"
    };


    if(selectedPickupAddress.value.id!=null){
      body["pickup_address_id"]=selectedPickupAddress.value.id??0;
    }
    if(selectedShippingAddress.value.id!=null){
      body["shipping_address_id"]=selectedShippingAddress.value.id??0;
    }

    try {
      var response=await RemoteServices.postRequestWithJsonData(endPoint: endPoint,body: body);
      if(response!=null){
        transportationOrderModel=TransportationOrderModel.fromJson(response);

        Get.put(PaymentPageController());
        Get.find<PaymentPageController>().paymentFor="transportation";
        Get.find<PaymentPageController>().transportOrderDetails.value=transportationOrderModel;
        Get.find<PaymentPageController>().selectedVehicle.value=selectedVehicle.value;
        Get.find<PaymentPageController>().calculationModel.value=calculationModel.value;
        Get.find<PaymentPageController>().pickupAddress.value=pickUpAddressModel.value;
        Get.find<PaymentPageController>().deliveryAddress.value=deliveryAddressModel.value;
        Get.find<PaymentPageController>().clientSecret.value=transportationOrderModel.data?.paymentIntent?.clientSecret??"";
      //  Get.find<PaymentPageController>().orderId.value="${transportationOrderModel.data?.order?.id??0}";
        Get.find<PaymentPageController>().makePayment();
        Get.toNamed(Routes.PAYMENT_PAGE);
        CustomSnackBar(
          msg: response["message"],
          isSuccess: true
        ).showSnackBar();
        Get.put(FloatingController());
       // Get.find<FloatingController>().initializeSocket();

        Get.find<FloatingController>().orderId.value=(transportationOrderModel.data?.order?.id).toString();
        Get.find<FloatingController>().showFloating();
        await LocalServices.storeOnGoingTrip((transportationOrderModel.data?.order?.id).toString());

      }else{
        CustomSnackBar(
            msg: AppStrings.httpErrorMSG.value,
            isSuccess: false
        ).showSnackBar();
      }
    } finally {
      isLoading.value=false;
    }
  }

  Future<void> getAllAddress()async {
    isLoading.value=true;
    var endPoint=APIEndPoints.getAddress;
    try {
      var response= await RemoteServices.getRequest(endPoint: endPoint);
      if(response!=null){
        allAddresses.value=AddressListModel.fromJson(response);
        separateAddresses();
      }
    } finally {
      isLoading.value=false;
    }
  }

  void separateAddresses() {
    pickupAddress.value=[];
    shippingAddress.value=[];
    allAddresses.value.data?.forEach((value){
      if(value.addressType==AddressType.pickup.name){
        pickupAddress.add(value);
      }else if(value.addressType==AddressType.shipping.name){
        shippingAddress.add(value);
      }
    });
  }

Future<void>  getCustomerData()async {
    customer.value=await LocalServices.getUser()??CustomerModel();
}



  bool checkRequest(Rx<OrderHistoryModel> onGoingRequests) {
    bool isRequestActive = false;

    onGoingRequests.value.data?.forEach((value) {
      if (value.orderStatus != OrderStatus.cancelled.name &&
          value.orderStatus != OrderStatus.expired.name &&
          value.orderStatus != OrderStatus.delivered.name) {
        isRequestActive = true;
        return;
      }
    });

    return isRequestActive;
  }

  Future<bool> pendingOrder() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.orderHistory;

    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);

      // Check for response and specific error message
      if (response != null || AppStrings.httpErrorMSG.value == "Order not found") {
        onGoingRequests.value = OrderHistoryModel.fromJson(response);

        var result = checkRequest(onGoingRequests);
        if (result) {
          CustomSnackBar(
              msg: "You have an active order right now.\nPlease complete the order first.",
              isSuccess: false,
              showButton: true,
              buttonText: "Goto orders",
              onTap: () {
                Get.offAndToNamed(Routes.ORDER_HISTORY);
              }
          ).showSnackBar();
        }
        return result;
      }
    } catch (e) {
      // Handle any potential exceptions
      if (kDebugMode) {
        print("Error fetching order history: $e");
      }
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  void getNotificationData() {
    Get.put(AppbarController());
    Get.find<AppbarController>().getNotifications();
  }
  void handleForegroundNotification(BuildContext context) async {
    const storage = FlutterSecureStorage();
    //String? requestId = await storage.read(key: 'requestId');
    String? notificationId = await storage.read(key: 'notificationId');

    if ( notificationId != null) {
      // Assuming you have already registered the TripRequestController
      Get.put(NotificationsController());
      Get.find<NotificationsController>().getNotification();
      Get.toNamed(Routes.NOTIFICATIONS);
      Get.back();

      // Clear the saved data
      await storage.delete(key: 'requestId');
      await storage.delete(key: 'notificationId');
    }
  }



}
