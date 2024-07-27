/*
import 'package:cgp/app/modules/home/models/home_data_model.dart';
import 'package:cgp/app/modules/wishList/models/wish_list_model.dart';
import 'package:cgp/models/allproductsModel.dart';
import 'package:cgp/utils/utils.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_snackbar.dart';
import '../../../../services/api_endpoints.dart';
import '../../../../services/remote_services.dart';
import '../../cart/models/my_cart_model.dart';
import '../../cart/myCart/controllers/my_cart_controller.dart';

class WishListController extends GetxController {
  var wishListModel = WishListModel().obs;
  var isLoading = true.obs;
  var isCartItem = false.obs;
  var cartId="";
  var myCartModel = MyCartModel();
  var quantity = 1.obs;
  var isLoadingRecommended=true.obs;
  var recommendedProducts=<SingleProduct>[].obs;


  @override
  void onInit() {
    super.onInit();
    getWishListProducts();
    getRecommendedProducts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> getWishListProducts() async {
    await getWishListFromLocal().then((value) {
      wishListModel.value = value ?? WishListModel();
      isLoading.value = false;
    });
  }

  void handelWishList({required String id})async {
    isLoading.value=true;
    var endPoint=APIEndPoints.addOrRemoveWishList.replaceAll("{productId}", id);
    var response=await RemoteServices.patchRequest(endPoint: endPoint);
    if(response!=null){

      await getWishListFromRemoteServer().then((value){
        wishListModel.value=value??WishListModel();
        isLoading.value=false;
        CustomSnackBar(
            msg: response["message"],
            isSuccess: true
        ).showSnackBar();
      });
    }
  }

  void getRecommendedProducts()async {
    isLoadingRecommended.value=true;
    var endPoint=APIEndPoints.getAllProducts;
    var allProductsModel=AllProductsModel();
    var response=await RemoteServices.getRequest(endPoint: endPoint);
    if(response!=null){
      allProductsModel=AllProductsModel.fromJson(response);
      recommendedProducts.value=allProductsModel.data??[];
      isLoadingRecommended.value=false;
    }
  }

  void handelMyCart({required String id})async {
    await checkMyCart(id: id).then((value){
      if (isCartItem.value) {
        updateCartItem(id: id).then((value){
          handelWishList(id: id);
        });
      } else {
        addToCart(id: id).then((value){
          handelWishList(id: id);
        });
      }

    });
  }

  Future<void> checkMyCart({required String id}) async {
    isCartItem.value = false;
    cartId="";
    myCartModel = await getMyCarFromLocal() ?? MyCartModel();

    for (var data in (myCartModel.data??[])) {
      if (data.product?.id.toString() == id) {
        isCartItem.value = true;
        cartId=data.id.toString();
        quantity.value=data.quantity??0;
        break;
      }
    }
  }

  Future<void> addToCart({required String id}) async {
    isLoading.value=true;
    var endPoint = APIEndPoints.addSingleItemToCart
        .replaceAll("{productId}", id)
        .replaceAll("{quantity}", quantity.value.toString());
    var response=await RemoteServices.postRequest(endPoint: endPoint);
    if(response!=null){
      await getMyCartFromRemoteServer().then((value) {
        checkMyCart(id: id);
        isLoading.value = false;
        Get.put(MyCartController());
        Get.find<MyCartController>().getMyCartData();
        CustomSnackBar(msg: response["message"], isSuccess: true)
            .showSnackBar();
      });
    }
  }

  Future<void> updateCartItem({required String id}) async{
    isLoading.value=true;
    var endPoint = APIEndPoints.updateSingleItemToCart
        .replaceAll("{cartId}", cartId)
        .replaceAll("{quantity}", quantity.value.toString());
    var response=await RemoteServices.patchRequest(endPoint: endPoint);
    if(response!=null){
      await getMyCartFromRemoteServer().then((value) {
        checkMyCart(id: id);
        isLoading.value = false;
        Get.put(MyCartController());
        Get.find<MyCartController>().getMyCartData();
        CustomSnackBar(msg: response["message"], isSuccess: true)
            .showSnackBar();
      });
    }
  }
}
*/
import 'package:cgp/app/modules/wishList/models/wish_list_model.dart';
import 'package:cgp/models/allproductsModel.dart';
import 'package:cgp/utils/utils.dart';
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
  var isLoadingRecommended = true.obs;
  var recommendedProducts = <SingleProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getWishListProducts();
    getRecommendedProducts();
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

  Future<void> getRecommendedProducts() async {
    isLoadingRecommended.value = true;
    const endPoint = APIEndPoints.getAllProducts;
    final response = await RemoteServices.getRequest(endPoint: endPoint);

    if (response != null) {
      final allProductsModel = AllProductsModel.fromJson(response);
      recommendedProducts.value = allProductsModel.data ?? [];
      isLoadingRecommended.value = false;
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
