import 'package:get/get.dart';

import '../controllers/group_cart_controller.dart';

class GroupCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupCartController>(
      () => GroupCartController(),
    );
  }
}
