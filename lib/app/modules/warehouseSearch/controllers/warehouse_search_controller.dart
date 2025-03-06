import 'package:cgp/app/modules/warehouseSearch/models/warehouse_search_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_snackbar.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../services/api_endpoints.dart';
import '../../../../services/remote_services.dart';
import '../../../../utils/debouncer.dart';

class WarehouseSearchController extends GetxController {
  var isLoading=false.obs;

  var searchController = TextEditingController();
  var warehouseSearchModel=WareHouseSearchModel().obs;
  var searchWarehouses=<SearchWarehouseModel>[].obs;

  final Debouncer debouncer = Debouncer(milliseconds: 1000);

  var searchKey="".obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!isLoading.value && warehouseSearchModel.value.currentPage!=warehouseSearchModel.value.lastPage) {
          loadMore();
        }
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void loadData() async {
    isLoading.value = true;
    var endPoint=APIEndPoints.searchWarehouse;
    var parameter={
      "query":searchKey.value,
      "page":"1",
      "perPage":AppStrings.paginationSearchWarehousePerPage
    };
    await RemoteServices.getRequest(endPoint: endPoint,parameters: parameter).then((value){
      if(value!=null){
        isLoading.value=false;
        warehouseSearchModel.value=WareHouseSearchModel.fromJson(value);
        searchWarehouses.value=warehouseSearchModel.value.data??[];
      }else{
        CustomSnackBar(
          isSuccess: false,
          msg: AppStrings.httpErrorMSG.value,
        ).showSnackBar();
        isLoading.value=false;
      }
    });

  }


  void loadMore() async {
    isLoading.value = true;
    var endPoint=APIEndPoints.searchWarehouse;
    var parameter={
      "query":searchKey.value,
      "page":"${(warehouseSearchModel.value.currentPage??0)+1}",
      "perPage":AppStrings.paginationSearchWarehousePerPage
    };
    await RemoteServices.getRequest(endPoint: endPoint,parameters: parameter).then((value){
      if(value!=null){
        isLoading.value=false;
        warehouseSearchModel.value=WareHouseSearchModel.fromJson(value);
        warehouseSearchModel.value.data?.forEach((value){
          searchWarehouses.value.add(value);
        });
      }else{
        CustomSnackBar(
          isSuccess: false,
          msg: AppStrings.httpErrorMSG.value,
        ).showSnackBar();
        isLoading.value=false;
      }
    });

  }

  void fetchData() async => debouncer.run(() async => loadData());

}
