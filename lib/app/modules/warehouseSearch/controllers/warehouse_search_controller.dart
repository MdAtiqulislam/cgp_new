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
  var warehouseSearchModel=WareHouseSearchModel();
  var searchWarehouses=<WarehouseSearchData>[].obs;

  final Debouncer debouncer = Debouncer(milliseconds: 1000);

  var searchKey="".obs;

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
  void loadData() async {
    isLoading.value = true;
    var endPoint=APIEndPoints.searchWarehouse;
    var parameter={
      "query":searchKey.value
    };
    await RemoteServices.getRequest(endPoint: endPoint,parameters: parameter).then((value){
      if(value!=null){
        isLoading.value=false;
        warehouseSearchModel=WareHouseSearchModel.fromJson(value);
        searchWarehouses.value=warehouseSearchModel.data??[];
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
