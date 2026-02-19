import 'package:get/get.dart';

class CompleteRegistrationController extends GetxController {
  var checkBoxValue = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ].obs;
  var checkBoxItems = [
    "Interior Equipments",
    "Exterior Equipment",
    "Building Supplies",
    "Architectural Equipment ",
    "Architectural Equipment ",
    "Architectural Equipment ",
    "Landscaping & Outdoors",
  ].obs;

  final count = 0.obs;

  var isLoading = false.obs;

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

  void increment() => count.value++;
}
