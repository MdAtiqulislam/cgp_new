import 'package:cgp/app/modules/cart/models/my_cart_model.dart';
import 'package:cgp/app/modules/cart/myCart/controllers/my_cart_controller.dart';
import 'package:cgp/app/modules/home/models/home_data_model.dart';
import 'package:cgp/app/modules/productDetails/models/product_details_model.dart';
import 'package:cgp/app/modules/productDetails/models/similar_products_model.dart';
import 'package:cgp/app/modules/wishList/controllers/wish_list_controller.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:cgp/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../wishList/models/wish_list_model.dart';

class ProductDetailsController extends GetxController {
  var isLoading = true.obs;
  var isFavourite = false.obs;
  var isCartItem = false.obs;
  var cartId="";
  var similarProductsModel = SimilarProductsModel().obs;
  final dropDownController = TextEditingController();
  var details = ProductDetailsModel().obs;
  var quantity = 1.obs;

  var wishListModel = WishListModel();
  var myCartModel = MyCartModel();
  var categoryList = <Category>[].obs;
  final dataList = ["Overview", "Specifications", "Size & Materials"];
  final selectedIndex = 0.obs;
  var dynamicText = "".obs;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {}

  void getDetails({required String id}) async {
    quantity.value=1;
    checkWishList(id: id);
    checkMyCart(id: id);

    isLoading.value = true;
    var endPoint = "${APIEndPoints.productDetails}$id";
    await RemoteServices.getRequest(endPoint: endPoint).then((value) {
      if (value != null) {
        details.value = ProductDetailsModel.fromJson(value);
        dynamicText.value = details.value.data?.detailsOverview ?? "";

        //this is for related product
       // getRelatedProduct(productId: details.value.data?.id ?? "");
        isLoading.value = false;
      } else {
        isLoading.value = false;
        CustomSnackBar(isSuccess: false, msg: AppStrings.httpErrorMSG.value)
            .showSnackBar();
      }
    });
  }

  void getRelatedProduct({required String productId}) async {
    //  isLoadingProduct.value=true;
    var endPoint =
        APIEndPoints.getSimilarProducts.replaceAll('{productId}', productId);
    await RemoteServices.getRequest(endPoint: endPoint).then((value) {
      similarProductsModel.value = SimilarProductsModel.fromJson(value);
    });
  }

  void checkWishList({required String id}) async {
    isFavourite.value = false;
    wishListModel = await getWishListFromLocal() ?? WishListModel();
    for (var data in (wishListModel.data??[])) {
      if (data.product?.id.toString() == id) {
        isFavourite.value = true;

        break;
      }
    }
  }

  void handelWishList({required String id}) async {
    isLoading.value = true;
    var endPoint =
        APIEndPoints.addOrRemoveWishList.replaceAll("{productId}", id);
    var response = await RemoteServices.patchRequest(endPoint: endPoint);
    if (response != null) {
      await getWishListFromRemoteServer().then((value) {
        checkWishList(id: id);
        isLoading.value = false;

        Get.put(WishListController());
        Get.find<WishListController>().getWishListProducts();
        CustomSnackBar(msg: response["message"], isSuccess: true)
            .showSnackBar();
      });
    }
  }

  void increment() {
    quantity.value++;
  }

  void decrement() {
    if (quantity.value > 0) {
      quantity.value--;
      if (quantity.value < 0) {
        quantity.value = 0;
      }
    }
  }

  void checkMyCart({required String id}) async {
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

  void handelMyCart() {
    if (isCartItem.value) {
      updateCartItem();
    } else {
      addToCart();
    }
  }

  void addToCart() async {
    isLoading.value=true;
    var endPoint = APIEndPoints.addSingleItemToCart
        .replaceAll("{productId}", details.value.data?.id ?? "")
        .replaceAll("{quantity}", quantity.value.toString());
    var response=await RemoteServices.postRequest(endPoint: endPoint);
    if(response!=null){
      await getMyCartFromRemoteServer().then((value) {
        checkMyCart(id: details.value.data?.id??"");
        isLoading.value = false;
        Get.put(MyCartController());
        Get.find<MyCartController>().getMyCartData();
        CustomSnackBar(msg: response["message"], isSuccess: true)
            .showSnackBar();
      });
    }
  }

  void updateCartItem() async{
    isLoading.value=true;
    var endPoint = APIEndPoints.updateSingleItemToCart
        .replaceAll("{cartId}", cartId)
        .replaceAll("{quantity}", quantity.value.toString());
    var response=await RemoteServices.patchRequest(endPoint: endPoint);
    if(response!=null){
      await getMyCartFromRemoteServer().then((value) {
        checkMyCart(id: details.value.data?.id??"");
        isLoading.value = false;
        Get.put(MyCartController());
        Get.find<MyCartController>().getMyCartData();
        CustomSnackBar(msg: response["message"], isSuccess: true)
            .showSnackBar();
      });
    }
  }
}
