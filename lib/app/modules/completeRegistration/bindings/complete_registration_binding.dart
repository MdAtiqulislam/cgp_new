import 'package:get/get.dart';

import '../controllers/complete_registration_controller.dart';

class CompleteRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteRegistrationController>(
      () => CompleteRegistrationController(),
    );
  }
}
