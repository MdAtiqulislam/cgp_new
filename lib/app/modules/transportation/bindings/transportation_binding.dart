import 'package:get/get.dart';

import '../controllers/transportation_controller.dart';

class TransportationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransportationController>(
      () => TransportationController(),
    );
  }
}
