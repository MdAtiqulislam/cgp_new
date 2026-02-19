import 'package:get/get.dart';

import '../controllers/add_or_update_address_controller.dart';

class AddOrUpdateAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddOrUpdateAddressController>(
      () => AddOrUpdateAddressController(),
    );
  }
}
