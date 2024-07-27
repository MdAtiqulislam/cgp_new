
import 'package:cgp/app/modules/home/models/home_data_model.dart';
import 'package:cgp/app/modules/wareHouses/models/ware_houses_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../services/api_endpoints.dart';
import '../../../../services/remote_services.dart';

class WareHousesController extends GetxController {

  var isLoading=true.obs;

  var dropDownController=TextEditingController();

  var categoryList=<Category>[].obs;
  var wareHouses=WareHousesModel().obs;

  @override
  void onInit() {
    super.onInit();
    getWareHouses();
   // getCategory();
  }


  @override
  void onClose() {}

/*  void getCategory() async {
    var endPoint = APIEndPoints.getCategory;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        categoryList.value = CategoriesModel.fromJson(response);
        //   getProductsByCategory(categoryId: categoryList.value.data?[0].id??"");
      }
    } finally {}
  }*/


  void getWareHouses() async {
    var endPoint = APIEndPoints.getWareHouses;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        wareHouses.value = WareHousesModel.fromJson(response);
        //   getProductsByCategory(categoryId: categoryList.value.data?[0].id??"");
      }
    } finally {
      isLoading.value=false;
    }
  }
}
