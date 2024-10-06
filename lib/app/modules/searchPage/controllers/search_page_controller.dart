
import 'package:cgp/app/modules/searchPage/models/search_product_moddel.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:cgp/utils/debouncer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../models/single_product_model.dart';
import '../../../../utils/utils.dart';
import '../../cart/models/my_cart_model.dart';
import '../../cart/myCart/controllers/my_cart_controller.dart';
import '../../customFloatingCartButton/custom_floating_cart_button_controller.dart';
import '../../wishList/controllers/wish_list_controller.dart';

class SearchPageController extends GetxController {
  var isLoading = false.obs;
  var isCartItem = false.obs;
  var cartId="";
  var myCartModel = MyCartModel();
  var quantity=1.obs;

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



/*  void checkWishList({required String id}) async {
    isFavourite.value = false;
    wishListModel = await getWishListFromLocal() ?? WishListModel();
    for (var data in (wishListModel.data??[])) {
      if (data.product?.id.toString() == id) {
        isFavourite.value = true;

        break;
      }
    }
  }*/

  void handelWishList({required String id}) async {
    isLoading.value = true;
    var endPoint =
    APIEndPoints.addOrRemoveWishList.replaceAll("{productId}", id);
    var response = await RemoteServices.patchRequest(endPoint: endPoint);
    if (response != null) {
      await getWishListFromRemoteServer().then((value) {
      //  checkWishList(id: id);
        isLoading.value = false;
        Get.put(WishListController());
        Get.find<WishListController>().getWishListProducts();
        CustomSnackBar(msg: response["message"], isSuccess: true)
            .showSnackBar();
      });
    }
  }

/*  void increment() {
    quantity.value++;
  }

  void decrement() {
    if (quantity.value > 0) {
      quantity.value--;
      if (quantity.value < 0) {
        quantity.value = 0;
      }
    }
  }*/

  void checkMyCart({required String id}) async {
    isCartItem.value = false;
    quantity.value=1;
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

  void handelMyCart({required String id}) {
    if (isCartItem.value) {
      updateCartItem(id: id);
    } else {
      addToCart(id: id);
    }
  }

  void addToCart({required String id}) async {
    isLoading.value=true;
    var endPoint = APIEndPoints.addSingleItemToCart
        .replaceAll("{productId}", id)
        .replaceAll("{quantity}", quantity.value.toString());
    var response=await RemoteServices.postRequest(endPoint: endPoint);
    if(response!=null){
      await getMyCartFromRemoteServer().then((value) {
        checkMyCart(id:id);
        isLoading.value = false;
        Get.put(MyCartController());
        Get.find<MyCartController>().getMyCartData();
        CustomSnackBar(msg: response["message"], isSuccess: true)
            .showSnackBar();
      });
      Get.put(CustomFloatingCartButtonController());
      Get.find<CustomFloatingCartButtonController>().getMyCartData();
    }
  }

  void updateCartItem({required String id}) async{
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
        Get.put(CustomFloatingCartButtonController());
        Get.find<CustomFloatingCartButtonController>().getMyCartData();
      });
    }
  }


}
