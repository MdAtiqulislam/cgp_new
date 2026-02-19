import 'package:get/get.dart';

import '../controllers/f_a_q_page_controller.dart';

class FAQPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FAQPageController>(
      () => FAQPageController(),
    );
  }
}
