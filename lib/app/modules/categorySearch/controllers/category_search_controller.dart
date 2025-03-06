import 'package:cgp/app/modules/categorySearch/models/warehouse_by_category_model.dart';
import 'package:cgp/app/modules/warehouseSearch/models/warehouse_search_model.dart';
import 'package:cgp/models/categories_model.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../constraints/app_strings.dart';

class CategorySearchController extends GetxController {
  var wareHouseByCategoryModel=WareHousesByCategoryModel().obs;
  final dropDownController=TextEditingController();
  var categoryList=CategoriesModel().obs;
  var warehousesList=<SearchWarehouseModel>[].obs;
  ScrollController scrollController = ScrollController();

  var isLoading=true.obs;
  @override
  void onInit() {
    super.onInit();
    getCategory();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!isLoading.value && wareHouseByCategoryModel.value.currentPage!=wareHouseByCategoryModel.value.lastPage) {
          loadData(categoryId: wareHouseByCategoryModel.value.data?.category?.id??"");
        }
      }
    });
  }

  @override
  void onClose() {}

  void loadData({required String categoryId}) async{
    isLoading.value=true;
    var endPoint=APIEndPoints.getWareHousesByCategory.replaceAll("{categoryId}", categoryId);
    var parameter={
      "page":"${(wareHouseByCategoryModel.value.currentPage??0)+1}",
      "perPage":AppStrings.paginationCategoryWarehousePerPage
    };
   try {
     var response= await RemoteServices.getRequest(endPoint: endPoint,parameters: parameter);
        if(response!=null){
          wareHouseByCategoryModel.value=WareHousesByCategoryModel.fromJson(response);
          wareHouseByCategoryModel.value.data?.warehouses?.forEach((value){
            warehousesList.value.add(value);
          });
        }
   } finally {
    isLoading.value=false;
   }
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
