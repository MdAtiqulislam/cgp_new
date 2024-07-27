
import 'package:cgp/app/modules/searchPage/models/search_product_moddel.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:cgp/utils/debouncer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../models/single_product_model.dart';

class SearchPageController extends GetxController {
  var isLoading = false.obs;
  var otpOptions = ["Lowest to Highest", "Highest to Lowest"];
  var selectedOTPOption = ''.obs;
  var searchController = TextEditingController();
  final Debouncer debouncer = Debouncer(milliseconds: 1000);

  var searchKey="".obs;
  var searchProductModel=SearchProductModel();
  var searchProducts=<SingleProductModel>[].obs;

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
    var endPoint=APIEndPoints.searchProduct;
    var parameter={
      "query":searchKey.value
    };
    await RemoteServices.getRequest(endPoint: endPoint,parameters: parameter).then((value){
      if(value!=null){
        isLoading.value=false;
        searchProductModel=SearchProductModel.fromJson(value);
        searchProducts.value=searchProductModel.data?.products??[];
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

/*  void fetchData() async => debounce(() async {
    {
      print(searchController.text);
    }
  });*/
}
