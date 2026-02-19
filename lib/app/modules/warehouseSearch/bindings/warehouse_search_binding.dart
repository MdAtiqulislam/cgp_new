import 'package:get/get.dart';

import '../controllers/warehouse_search_controller.dart';

class WarehouseSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WarehouseSearchController>(
      () => WarehouseSearchController(),
    );
  }
}
