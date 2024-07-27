import 'package:get/get.dart';

import '../controllers/set_location_controller.dart';

class SetLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetLocationController>(
      () => SetLocationController(),
    );
  }
}
