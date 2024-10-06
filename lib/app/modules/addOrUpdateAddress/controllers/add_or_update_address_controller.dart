import 'package:cgp/app/modules/profile/controllers/profile_controller.dart';
import 'package:cgp/models/single_address_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_snackbar.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../services/api_endpoints.dart';
import '../../../../services/remote_services.dart';
import '../../../../utils/enams.dart';
import '../../cart/checkOut/models/address_model.dart';

class AddOrUpdateAddressController extends GetxController {
  var isLoading=false.obs;
  var isActiveSelectButton=false;

  var firstNameController=TextEditingController();
  var lastNameController=TextEditingController();
  var phoneController=TextEditingController();
  var countryController=TextEditingController();
  var stateController=TextEditingController();
  var cityController=TextEditingController();
  var roadController=TextEditingController();
  var blockController=TextEditingController();
  var houseController=TextEditingController();
  var zipController=TextEditingController();
  var addressController=TextEditingController();

  var selectedAddressType="".obs;
  var selectedAddresses=<SingleAddressModel>[].obs;

  var selectedAddress=SingleAddressModel().obs;
  var addressesModel=AddressListModel().obs;

  var isDefault=false.obs;
  final addressTypeList = AddressType.values.map((e) => e.name).toList();


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


  Future<void> getAddresses()async{
    isLoading.value=true;
    var endPoint=APIEndPoints.getAddress;
    try {
      var data=await RemoteServices.getRequest(endPoint: endPoint);
      if(data!=null){
        addressesModel.value=AddressListModel.fromJson(data);
      }
    } finally {
      isLoading.value=false;
    }
  }

  void saveAddress()async{
    isLoading.value=true;
    var endPoint=APIEndPoints.saveAddress;
    var body={
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "phone_number_1": phoneController.text,
      "phone_number_2": null,
      "address": addressController.text,
      "city": cityController.text,
      "state": stateController.text,
      "postal_code": zipController.text,
      "country_id": "AU",
      "latitude": 0,
      "longitude": 0,
      "notes": "",
      "address_type": selectedAddressType.value,
      "is_default": isDefault.value
    };
    try {
      var response=await RemoteServices.postRequestWithJsonData(endPoint: endPoint,body: body);
      if(response!=null){
        await getAddresses().then((value){
          getMySelectedAddress();
        });
        Get.back();
        CustomSnackBar(
            msg: response["message"],
            isSuccess: true
        ).showSnackBar();
      }
      else{
        CustomSnackBar(
            msg: AppStrings.httpErrorMSG.value,
            isSuccess: false
        ).showSnackBar();
      }
    } finally {
      isLoading.value=false;
    }
  }

  Future<void> getMySelectedAddress()async{
    selectedAddresses.value=[];
    addressesModel.value.data?.forEach((value){

      if(value.addressType==selectedAddressType.value){
        selectedAddresses.add(value);
        if(value.isDefault??false){
          selectedAddress.value=value;
        }
      }
    });
  }

  void setAddressData({required SingleAddressModel address}){
    firstNameController.text=address.firstName??"";
    lastNameController.text=address.lastName??"";
     phoneController.text=address.phoneNumber1??"";
     countryController.text=address.countryId??"";
     stateController.text=address.state??"";
    cityController.text=address.city??"";
    roadController.text=address.state??"";
   // blockController.text=address.??"";
     zipController.text=address.postalCode??"";
     addressController.text=address.address??"";
     isDefault.value=address.isDefault??false;
  }

  Future<void> updateAddress({String? id,String? lat,String? lan}) async {
    isLoading.value=true;
    var endPoint=APIEndPoints.updateAddress.replaceAll("{id}", id??"");
    var body={
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "phone_number_1": phoneController.text,
      "phone_number_2": "",
      "address": addressController.text,
      "city": cityController.text,
      "state": stateController.text,
      "postal_code": zipController.text,
      "country_id": "AU",
      "latitude": lat??"",
      "longitude": lan??"",
      "notes": "",
      "address_type": selectedAddressType.value,
      "is_default": isDefault.value
    };

    try {
      var data=await RemoteServices.putRequestWithJson(endPoint: endPoint,body: body);
      
      if(data!=null){
        await getAddresses().then((value){
          getMySelectedAddress();
        });
        Get.put(ProfileController());
        Get.find<ProfileController>().addressesModel.value=addressesModel.value;
        Get.find<ProfileController>().getDefaultAddresses();
        Get.back();
        CustomSnackBar(
          msg: data["message"],
          isSuccess: true
        ).showSnackBar();
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
  Future<void> makeDefault({required String id}) async {
    isLoading.value=true;
    var endPoint=APIEndPoints.setDefaultAddress.replaceAll("{id}", id);
    try {
      var response=await RemoteServices.putRequest(endPoint: endPoint);
      if(response!=null){
       await getAddresses().then((value){
         getMySelectedAddress();
       });
       CustomSnackBar(
         isSuccess: true,
         msg: response["message"]
       ).showSnackBar();
      }
    } finally {
      isLoading.value=false;
    }
  }

  void selectLocationAndBack() {
    SingleAddressModel value=selectedAddress.value;
    Get.back(result: value);
  }
}
