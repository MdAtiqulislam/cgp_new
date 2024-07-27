import 'package:cgp/app/modules/cart/checkOut/models/address_model.dart';
import 'package:cgp/models/customer_model.dart';
import 'package:cgp/models/single_address_model.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/local_services.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {


  var isLoading=false.obs;

  var customer=CustomerModel().obs;
  var addressesModel=AddressListModel().obs;
  var defaultAddresses=<SingleAddressModel>[].obs;
  @override
  void onInit()async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getUserData();
  }

  @override
  void onClose() {}

 Future<void> getUserData() async{
    await LocalServices.getUser().then((value){
      if(value!=null){
        customer.value=value;
      }
    });
 }

Future<void>  getAddresses() async{
    isLoading.value=true;
    defaultAddresses.value=[];
    var endPoint=APIEndPoints.getAddress;
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint);
      if(response!=null){
        addressesModel.value=AddressListModel.fromJson(response);
        getDefaultAddresses();
      }
    } finally {
      isLoading.value=false;
    }
}

  void getDefaultAddresses() {
    addressesModel.value.data?.forEach((value){
      if(value.isDefault??false){
        defaultAddresses.add(value);
      }
    });
  }
}
