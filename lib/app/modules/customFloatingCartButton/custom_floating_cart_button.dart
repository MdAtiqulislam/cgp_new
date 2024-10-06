import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constraints/app_colors.dart';
import '../../routes/app_pages.dart';
import 'custom_floating_cart_button_controller.dart';

class CustomFloatingCartButton extends GetView<CustomFloatingCartButtonController> {
  const CustomFloatingCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(()=>(controller.cartModel.value.data ?? []).isNotEmpty
        ? myFloatingButton()
        : Container());
  }

  Widget myFloatingButton() {
    return Stack(
      clipBehavior: Clip.none, // Allows the badge to overflow the button's boundary
      children: [
        FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: () {
            Get.toNamed(Routes.CART_DETAILS);
          },
        ),
        Positioned(
          right: 3,
          top: -3,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              (controller.cartModel.value.data?.length ?? 0).toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
