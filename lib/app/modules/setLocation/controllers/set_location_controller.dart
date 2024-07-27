import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SetLocationController extends GetxController {
  var firstNameController=TextEditingController();
  var lastNameController=TextEditingController();
  var countryController=TextEditingController();
  var stateController=TextEditingController();
  var cityController=TextEditingController();
  var roadController=TextEditingController();
  var blockController=TextEditingController();
  var houseController=TextEditingController();
  var zipController=TextEditingController();
  var phoneController=TextEditingController();
  var addressController=TextEditingController();


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

  void saveLocation()async{
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
      "country_id": countryController.text,
      "latitude": 0,
      "longitude": 0,
      "notes": "",
      "address_type": "shipping",
      "is_default": true
    };
   var response=await RemoteServices.postRequestWithJsonData(endPoint: endPoint,body: body);
   if(response!=null){
     CustomSnackBar(
       msg: response["message"],
       isSuccess: true
     ).showSnackBar();
   }else{
     CustomSnackBar(
         msg: AppStrings.httpErrorMSG.value,
         isSuccess: false
     ).showSnackBar();
   }
  }
}
