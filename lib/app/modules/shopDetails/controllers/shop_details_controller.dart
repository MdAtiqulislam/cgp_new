import 'package:cgp/app/modules/home/models/home_data_model.dart';
import 'package:cgp/app/modules/shopDetails/models/products_by_category_model.dart';
import 'package:cgp/app/modules/shopDetails/models/products_by_ware_house_model.dart';
import 'package:cgp/app/modules/shopDetails/models/ware_house_details_model.dart';
import 'package:cgp/models/single_address_model.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:cgp/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ShopDetailsController extends GetxController {
  var isLoading = false.obs;
  var isLoadingProduct = true.obs;
  var categoryList = <Category>[].obs;
  var dropDownController = TextEditingController();

  String shopName = "";

  var selectedIndex = 0.obs;
  var wareHouseDetails = WareHouseDetailsModel().obs;
  var productsByCategory = ProductsByCategoryModel().obs;
  var productsByWareHouse = ProductsByWareHouseModel().obs;
  var distance = "".obs;
  var selectedShippingAddress=SingleAddressModel().obs;
  var isSelfPickup=true.obs;

  @override
  void onInit() {
    super.onInit();
  }


  @override
  void onClose() {}

  void getDetails({required String id}) async {
    isLoading.value = true;
    var endPoint = "${APIEndPoints.wareHouseDetails}$id";
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        wareHouseDetails.value = WareHouseDetailsModel.fromJson(response);
        distance.value = await distanceFromMyLocation(
                latitude: wareHouseDetails.value.data?.mainBranch?.latitude,
                longitude:
                    wareHouseDetails.value.data?.mainBranch?.longitude) ??
            "";
      }
    } finally {
      isLoading.value = false;
    }
  }

/*  void getCategory() async {
    var endPoint = APIEndPoints.getCategory;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        categoryList.value = CategoriesModel.fromJson(response);
      //  getProductsByCategory(categoryId: categoryList.value.data?[0].id??"");
      }
    } finally {}
  }*/

  void getProductsByCategory({required String categoryId}) async {
    isLoadingProduct.value = true;
    var endPoint = APIEndPoints.getProductByCategory
        .replaceAll('{categoryId}', categoryId);
    await RemoteServices.getRequest(endPoint: endPoint).then((value) {
      productsByCategory.value = ProductsByCategoryModel.fromJson(value);
      isLoadingProduct.value = false;
    });
  }

  void getProductsByWareHouse({required String wareHouseId}) async {
    isLoadingProduct.value = true;
    var endPoint = APIEndPoints.getProductByWareHouse
        .replaceAll('{warehouseId}', wareHouseId);
    await RemoteServices.getRequest(endPoint: endPoint).then((value) {
      if (value!=null) {
        productsByWareHouse.value = ProductsByWareHouseModel.fromJson(value);
      }
      isLoadingProduct.value = false;
    });
  }
}
