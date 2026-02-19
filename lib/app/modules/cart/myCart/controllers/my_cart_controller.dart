import 'package:cgp/app/modules/cart/models/my_cart_model.dart';
import 'package:cgp/app/modules/customFloatingCartButton/custom_floating_cart_button_controller.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:cgp/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../constraints/app_strings.dart';
import '../../../../../models/allproductsModel.dart';
import '../../../../../models/single_product_model.dart';

class MyCartController extends GetxController {
  var isLoading = true.obs;
  var isLoadingProduct = false.obs;
  var selectAll = true.obs;
  var total = 0.0.obs;

  var selectedCartItems = <SingleCartModel>[].obs;
  var cartModel = MyCartModel().obs;

  var productsModel=AllProductsModel().obs;
  var products=<SingleProductModel>[].obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getMyCartData();
    getProducts();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!isLoadingProduct.value && productsModel.value.currentPage!=productsModel.value.lastPage) {
          getProducts();
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

  Future<void> getMyCartData() async {
    isLoading.value = true;
    await getMyCarFromLocal().then((value) {
      cartModel.value = value ?? MyCartModel();
      selectedCartItems.value = [];
      selectedCartItems.addAll(cartModel.value.data ?? []);
      changeListen();
      isLoading.value = false;
    });
  }

  void changeListen() {
    if (selectedCartItems.length != (cartModel.value.data?.length ?? 0)) {
      selectAll.value = false;
      // print();
    } else {
      selectAll.value = true;
    }
    calculateTotal();
  }

  void calculateTotal() {
    total.value = 0.0;
    for (var value in selectedCartItems) {
      var quantity = value.quantity ?? 0;
      var price = double.parse(value.product?.regularPrice ?? "0.0");
      total.value += quantity * price;
    }
  }

  void removeCart({required SingleCartModel singleCartModel}) async {
    isLoading.value = true;

    var endPoint = APIEndPoints.removeCartItem
        .replaceAll("{cartId}", (singleCartModel.id ?? 0).toString());
    var response = await RemoteServices.deleteRequest(endPoint: endPoint);
    if (response != null) {
      await getMyCartFromRemoteServer().then((value) {
        cartModel.value = value ?? MyCartModel();
        selectedCartItems.value = cartModel.value.data ?? [];
        changeListen();
        isLoading.value = false;
        Get.put(CustomFloatingCartButtonController());
        Get.find<CustomFloatingCartButtonController>().getMyCartData();
      });
    }
  }

  void updateCart(
      {required int currentValue,
      required String cartId,
      required String type}) async {
    isLoading.value=true;
    var quantity = type == "+" ? ++currentValue : --currentValue;
    var endPoint = APIEndPoints.updateSingleItemToCart
        .replaceAll("{cartId}", cartId)
        .replaceAll("{quantity}", quantity.toString());

    var response=await RemoteServices.patchRequest(endPoint: endPoint);
    if(response!=null){
      CustomSnackBar(
        msg: response["message"],
        isSuccess: true
      ).showSnackBar();
      await getMyCartFromRemoteServer().then((value){
        cartModel.value=value??MyCartModel();
        getMyCartData();
        isLoading.value=false;
      });


    }else{
      isLoading.value=false;
    }

  }

  Future<void> getProducts() async {
    isLoadingProduct.value = true;
    const endPoint = APIEndPoints.getAllProducts;
    var parameters={
      "page":"${(productsModel.value.currentPage??0)+1}",
      "perPage":AppStrings.paginationProductsPerPage
    };
    try {
      final response = await RemoteServices.getRequest(endPoint: endPoint,parameters: parameters);
      if (response != null) {
        productsModel.value = AllProductsModel.fromJson(response);
        productsModel.value.data?.forEach((value){
          products.value.add(value);
        });
      }
    } finally {
      isLoadingProduct.value=false;
    }
  }
}
