import 'package:cgp/app/modules/cart/checkOut/models/address_model.dart';
import 'package:cgp/app/modules/cart/checkOut/models/place_order_model.dart';
import 'package:cgp/app/modules/cart/models/my_cart_model.dart';
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/models/order_products_model.dart';
import 'package:cgp/models/single_address_model.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:cgp/utils/utils.dart';
import 'package:get/get.dart';
import '../../../../../utils/enams.dart';
import '../../../addOrUpdateAddress/controllers/add_or_update_address_controller.dart';
import '../../../orderDetails/controllers/order_details_controller.dart';

class CheckOutController extends GetxController {
  var isLoading = false.obs;
  var cartList = <SingleCartModel>[].obs;
  var subTotal = 0.0.obs;
  var total = 0.0.obs;
  var totalWeight = 0.0.obs;
  var deliveryCharge = 68.obs;
  var billingAddress = AddressListModel().obs;
  var shippingAddress = AddressListModel().obs;
  var defaultBillingAddress = SingleAddressModel().obs;
  var defaultShippingAddress = SingleAddressModel().obs;
  var distance = "N/A".obs;

  @override
  void onInit() {
    super.onInit();
    getAddress();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void calculateTotal() {
    subTotal.value = 0.0;
    totalWeight.value = 0.0;
    for (var value in cartList) {
      subTotal.value +=
          (value.quantity ?? 0) * double.parse(value.product?.regularPrice ?? "0");
      totalWeight.value +=
          (value.quantity ?? 0) * double.parse(value.product?.weight ?? "0");
    }
    total.value = subTotal.value /*+ deliveryCharge.value*/;
  }

  Future<void> getAddress() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getAddress;
    var shippingParameter = {"type": "shipping"};
    var billingParameter = {"type": "billing"};
    var shippingResponse = await RemoteServices.getRequest(
        endPoint: endPoint, parameters: shippingParameter);
    var billingResponse = await RemoteServices.getRequest(
        endPoint: endPoint, parameters: billingParameter);
    try {
      if (shippingResponse != null) {
        shippingAddress.value = AddressListModel.fromJson(shippingResponse);
        for (var value
            in (shippingAddress.value.data ?? <SingleAddressModel>[])) {
          if (value.isDefault ?? false) {
            defaultShippingAddress.value = value;
            distance.value = (await distanceFromMyLocation(
                    latitude: "${defaultShippingAddress.value.longitude??0.0}",
                    longitude: "${defaultShippingAddress.value.longitude??0.0}")) ??
                "N/A";
            break;
          }
        }
      }
      if (billingResponse != null) {
        billingAddress.value = AddressListModel.fromJson(billingResponse);
        for (var value
            in (billingAddress.value.data ?? <SingleAddressModel>[])) {
          if (value.isDefault ?? false) {
            defaultBillingAddress.value = value;
            break;
          }
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  void placeOrder() async {
    PlaceOrderModel placeOrderModel = PlaceOrderModel();
    List<OrderProductsModel> orderProductModel = [];
    for (var value in cartList) {
      orderProductModel.add(
        OrderProductsModel(
            productId: int.parse(value.product?.id ?? "0"),
            offerId:0,
            quantity: value.quantity,
            regularPrice: double.parse(value.product?.regularPrice ?? "0.0").toInt(),
            salesPrice: double.parse(value.product?.salesPrice ?? "0.0").toInt(),)
      );
    }

    isLoading.value = true;
    var endPoint = APIEndPoints.placeOrder;
    var body = {
      "warehouse_id":((cartList[0].product?.warehouses??[]).isNotEmpty)
          ?(cartList[0].product?.warehouses?[0].warehouseId):"0",
      "warehouse_branch_id":((cartList[0].product?.warehouses??[]).isNotEmpty)
          ?(cartList[0].product?.warehouses?[0].warehouseId):"0",
      "shipping_address_id": "${defaultShippingAddress.value.id??1}",

      "shipping_address": {
        "first_name": defaultShippingAddress.value.firstName??"",
        "last_name": defaultShippingAddress.value.lastName??"",
        "phone_number_1": defaultShippingAddress.value.phoneNumber1??"",
        "phone_number_2": defaultShippingAddress.value.phoneNumber2??"",
        "address": defaultShippingAddress.value.address??"",
        "city": defaultShippingAddress.value.city??"",
        "state": defaultShippingAddress.value.state??"",
        "postal_code": defaultShippingAddress.value.postalCode??"",
        "country_id": defaultShippingAddress.value.countryId??"",
        "latitude": defaultShippingAddress.value.latitude??"",
        "longitude": defaultShippingAddress.value.longitude??"",
        "notes": defaultShippingAddress.value.notes??"",
        "address_type": defaultShippingAddress.value.addressType??"",
        "is_default": true
      },

     // "billing_address_id": "${defaultBillingAddress.value.id??2}",
      "products": orderProductModel.map((product) => product.toJson()).toList(),
    };

    var response = await RemoteServices.postRequestWithJsonData(
        endPoint: endPoint, body: body);
    if (response != null) {
      placeOrderModel = PlaceOrderModel.fromJson(response);
      CustomSnackBar(
          msg: placeOrderModel.message ?? "",
          isSuccess: true,
          showButton: true,
          buttonText: "View Order Details",
          onTap: () {
           Get.put(OrderDetailsController());
            Get.find<OrderDetailsController>().getOrderDetails(
                orderId: (placeOrderModel.data?.id ?? 0).toString());
            Get.toNamed(Routes.ORDER_DETAILS);
          }).showSnackBar();
      isLoading.value = false;
      await getMyCartFromRemoteServer();

      Get.offAllNamed(Routes.HOME);
    } else {
      CustomSnackBar(msg: AppStrings.httpErrorMSG.value, isSuccess: false)
          .showSnackBar();
      isLoading.value = false;
    }
  }

  void addOrUpdateAddress() async{
    isLoading.value=true;
    Get.put(AddOrUpdateAddressController());
    Get.find<AddOrUpdateAddressController>()
        .selectedAddressType
        .value = AddressType.shipping.name;
   await Get.find<AddOrUpdateAddressController>().getAddresses().then((value){
     Get.find<AddOrUpdateAddressController>().getMySelectedAddress();
   });

    await Get.toNamed(Routes.ADD_OR_UPDATE_ADDRESS)?.then((value){
      getAddress();
    });
  }
}
