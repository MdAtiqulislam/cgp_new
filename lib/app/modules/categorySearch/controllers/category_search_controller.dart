import 'package:cgp/app/modules/categorySearch/models/warehouse_by_category_model.dart';
import 'package:cgp/models/categories_model.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategorySearchController extends GetxController {
  var wareHouseByCategoryModel=WareHousesByCategoryModel().obs;
  final dropDownController=TextEditingController();
  var categoryList=CategoriesModel().obs;

  var isLoading=true.obs;
  @override
  void onInit() {
    super.onInit();
    getCategory();
  }



  @override
  void onClose() {}

  void loadData({required String categoryId}) async{
    isLoading.value=true;
    var endPoint=APIEndPoints.getWareHousesByCategory.replaceAll("{categoryId}", categoryId);
    await RemoteServices.getRequest(endPoint: endPoint).then((value){
      if(value!=null){
        wareHouseByCategoryModel.value=WareHousesByCategoryModel.fromJson(value);
        isLoading.value=false;
      }else{
        isLoading.value=false;
      }
    });
  }

  void getCategory() async {
    var endPoint = APIEndPoints.getCategory;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        categoryList.value = CategoriesModel.fromJson(response);
        //   getProductsByCategory(categoryId: categoryList.value.data?[0].id??"");
      }
    } finally {}
  }
}
