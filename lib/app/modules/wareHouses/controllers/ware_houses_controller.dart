
import 'package:cgp/app/modules/home/models/home_data_model.dart';
import 'package:cgp/app/modules/wareHouses/models/ware_houses_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../services/api_endpoints.dart';
import '../../../../services/remote_services.dart';
import '../../../../utils/utils.dart';

class WareHousesController extends GetxController {

  var isLoading=true.obs;

  var dropDownController=TextEditingController();

  var categoryList=<Category>[].obs;
  var wareHouses=WarehouseBranchesModel().obs;
  var currentLocation = Rx<LocationData?>(null);

  @override
  Future<void> onInit() async {
    super.onInit();
    currentLocation.value = await getCurrentLocation();
   await getWareHouses();
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


  Future<void> getWareHouses() async {
    var endPoint = APIEndPoints.getWareHousesBranches;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        wareHouses.value = WarehouseBranchesModel.fromJson(response);
        //   getProductsByCategory(categoryId: categoryList.value.data?[0].id??"");
      }
    } finally {
      isLoading.value=false;
    }
  }

  String calculateDistance({required double lat, required double lan}) {
    var distance = lat != 0 && lan != 0 && currentLocation.value?.latitude!=null && currentLocation.value?.longitude!=null
        ? formatDistance(
        distanceInMeter: calculateDistanceInMeter(
            LatLng(currentLocation.value?.latitude ?? 0,
                currentLocation.value?.longitude ?? 0),
            LatLng(lat, lan)))
        : "--";
    return distance;
  }


}
