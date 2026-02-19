
import 'package:cgp/app/modules/wishList/models/wish_list_model.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/models/allproductsModel.dart';
import 'package:cgp/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_snackbar.dart';
import '../../../../models/single_product_model.dart';
import '../../../../services/api_endpoints.dart';
import '../../../../services/remote_services.dart';
import '../../cart/models/my_cart_model.dart';
import '../../cart/myCart/controllers/my_cart_controller.dart';

class WishListController extends GetxController {
  var wishListModel = WishListModel().obs;
  var isLoading = true.obs;
  var isCartItem = false.obs;
  var cartId = "";
  var myCartModel = MyCartModel();
  var quantity = 1.obs;
  var isLoadingProduct = true.obs;
  var productsModel=AllProductsModel().obs;
  var products = <SingleProductModel>[].obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getWishListProducts();
    getProducts();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!isLoadingProduct.value && productsModel.value.currentPage!=productsModel.value.lastPage) {
          getProducts();
        }
      }
    });
  }

  Future<void> getWishListProducts() async {
    isLoading.value = true;
    final value = await getWishListFromLocal();
    wishListModel.value = value ?? WishListModel();
    isLoading.value = false;
  }

  Future<void> handleWishList({required String id}) async {
    isLoading.value = true;
    final endPoint = APIEndPoints.addOrRemoveWishList.replaceAll("{productId}", id);
    final response = await RemoteServices.patchRequest(endPoint: endPoint);

    if (response != null) {
      final value = await getWishListFromRemoteServer();
      wishListModel.value = value ?? WishListModel();
      isLoading.value = false;
      CustomSnackBar(
        msg: response["message"],
        isSuccess: true,
      ).showSnackBar();
    }
  }

  Future<void> getProducts() async {
    isLoadingProduct.value = true;
    const endPoint = APIEndPoints.getAllProducts;
    var parameters={
      "page":"${(productsModel.value.currentPage??0)+1}",
      "perPage":AppStrings.paginationProductsPerPage,
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

  Future<void> handleMyCart({required String id}) async {
    await checkMyCart(id: id);
    if (isCartItem.value) {
      await updateCartItem(id: id);
    } else {
      await addToCart(id: id);
    }
    await handleWishList(id: id);
  }

  Future<void> checkMyCart({required String id}) async {
    isCartItem.value = false;
    cartId = "";
    myCartModel = await getMyCarFromLocal() ?? MyCartModel();

    for (var data in (myCartModel.data ?? [])) {
      if (data.product?.id.toString() == id) {
        isCartItem.value = true;
        cartId = data.id.toString();
        quantity.value = data.quantity ?? 0;
        break;
      }
    }
  }

  Future<void> addToCart({required String id}) async {
    isLoading.value = true;
    final endPoint = APIEndPoints.addSingleItemToCart
        .replaceAll("{productId}", id)
        .replaceAll("{quantity}", quantity.value.toString());
    final response = await RemoteServices.postRequest(endPoint: endPoint);

    if (response != null) {
      await getMyCartFromRemoteServer();
      await checkMyCart(id: id);
      isLoading.value = false;
      Get.put(MyCartController());
      Get.find<MyCartController>().getMyCartData();
      CustomSnackBar(msg: response["message"], isSuccess: true).showSnackBar();
    }
  }

  Future<void> updateCartItem({required String id}) async {
    isLoading.value = true;
    final endPoint = APIEndPoints.updateSingleItemToCart
        .replaceAll("{cartId}", cartId)
        .replaceAll("{quantity}", quantity.value.toString());
    final response = await RemoteServices.patchRequest(endPoint: endPoint);

    if (response != null) {
      await getMyCartFromRemoteServer();
      await checkMyCart(id: id);
      isLoading.value = false;
      Get.put(MyCartController());
      Get.find<MyCartController>().getMyCartData();
      CustomSnackBar(msg: response["message"], isSuccess: true).showSnackBar();
    }
  }
}
