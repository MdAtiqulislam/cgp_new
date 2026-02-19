import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../cart/models/my_cart_model.dart';

class CustomFloatingCartButtonController extends GetxController{

  var cartModel=MyCartModel().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
   await getMyCartData();
  }



  Future<void> getMyCartData() async {
    await getMyCarFromLocal().then((value) {
      cartModel.value = value ?? MyCartModel();
    });
  }

}