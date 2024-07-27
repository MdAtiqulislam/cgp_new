import 'package:get/get.dart';

import '../controllers/ware_houses_controller.dart';

class WareHousesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WareHousesController>(
      () => WareHousesController(),
    );
  }
}
