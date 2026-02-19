import 'package:cgp/app/modules/home/models/home_data_model.dart';
import 'package:cgp/app/modules/shopDetails/models/products_by_branch_model.dart';
import 'package:cgp/app/modules/shopDetails/models/ware_house_details_model.dart';
import 'package:cgp/app/modules/shopDetails/models/warehouse_branch_details_model.dart';
import 'package:cgp/models/single_address_model.dart';
import 'package:cgp/models/single_product_model.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:cgp/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../constraints/app_strings.dart';

class ShopDetailsController extends GetxController {
  var isLoading = false.obs;
  var branchType="".obs;
  var wareHouseId="".obs;
  var branchId="".obs;

  var isLoadingProduct = true.obs;
  var categoryList = <Category>[].obs;
  var dropDownController = TextEditingController();
  String shopName = "";

  var wareHouseDetails = WareHouseDetailsModel().obs;
  var wareHouseBranchDetails = WareHouseBranchDetailsModel().obs;

 // var productsByCategoryf = ProductsByCategoryModel().obs;
 // var productsByWareHouse = ProductsByWareHouseModel().obs;
  var productByWarehouseBranchModel = ProductByWarehouseBranchModel().obs;
  var products=<SingleProductModel>[].obs;

  var distance = "".obs;
  var selectedShippingAddress=SingleAddressModel().obs;
  var isSelfPickup=true.obs;

  ScrollController scrollController = ScrollController();

  var showLoadingAnimation=true.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!isLoadingProduct.value && productByWarehouseBranchModel.value.currentPage!=productByWarehouseBranchModel.value.lastPage) {
          getProducts();
        }
      }
    });
  }


  @override
  void onClose() {}

  void getWarehouseDetails() async {
    isLoading.value = true;
    showLoadingAnimation.value=true;
    var endPoint ="${APIEndPoints.wareHouseDetails}${wareHouseId.value}";
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        wareHouseDetails.value = WareHouseDetailsModel.fromJson(response);
      }
    } finally {
      isLoading.value = false;
      showLoadingAnimation.value=false;
    }
  }

  void getBranchDetails() async {
    isLoading.value = true;
    var endPoint ="${APIEndPoints.wareHouseBranchDetails}${branchId.value}";
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        wareHouseBranchDetails.value = WareHouseBranchDetailsModel.fromJson(response);
        distance.value = await distanceFromMyLocation(
                latitude: wareHouseBranchDetails.value.data?.latitude,
                longitude: wareHouseBranchDetails.value.data?.longitude) ?? "";
      }
    } finally {
      isLoading.value = false;
    }
  }


  /*void getProductsByCategory({required String categoryId}) async {
    isLoadingProduct.value = true;
    var endPoint = APIEndPoints.getProductByCategory
        .replaceAll('{categoryId}', categoryId);
    await RemoteServices.getRequest(endPoint: endPoint).then((value) {
      productsByCategory.value = ProductsByCategoryModel.fromJson(value);
      isLoadingProduct.value = false;
    });
  }
*/


  void getProducts() async {
    isLoadingProduct.value = true;
/*    var endPoint =branchType.value==BranchType.headOffice.name
        ?APIEndPoints.getProductByWareHouse
        .replaceAll('{warehouseId}', branchId.value)
        :APIEndPoints.getProductByWareHouseBranch
        .replaceAll('{branchId}', branchId.value);*/

    var endPoint=APIEndPoints.getProductByWareHouseBranch
        .replaceAll('{branchId}', branchId.value);
    var parameters={
      "page":"${(productByWarehouseBranchModel.value.currentPage??0)+1}",
      "perPage":AppStrings.paginationProductsPerPage
    };
    await RemoteServices.getRequest(endPoint: endPoint,parameters: parameters).then((value) {
      if (value!=null) {
        productByWarehouseBranchModel.value = ProductByWarehouseBranchModel.fromJson(value);
        productByWarehouseBranchModel.value.data?.products?.forEach((value){
          products.value.add(value);
        });
      }
      isLoadingProduct.value = false;
    });
  }
}
