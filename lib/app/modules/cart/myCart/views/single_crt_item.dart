import 'package:cgp/app/modules/cart/models/my_cart_model.dart';
import 'package:cgp/app/modules/cart/myCart/controllers/my_cart_controller.dart';
import 'package:cgp/common_widgets/custom_check_box.dart';
import 'package:cgp/common_widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common_widgets/common_description.dart';
import '../../../../../constraints/app_colors.dart';
import '../../../../../constraints/app_strings.dart';
import '../../../../../constraints/dimensions.dart';
import '../../../../../constraints/header_text.dart';

class SingleCartItem extends GetView<MyCartController> {
  final int index;
  final SingleCartModel cartItem;

  const SingleCartItem(
      {required this.index, super.key,required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomCheckBox(
        alignment: CrossAxisAlignment.start,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        value: controller.selectedCartItems.contains(cartItem),
       onChanged: (value) async {
          if(value) {
            controller.selectedCartItems.add(cartItem);
            //controller.getMyCartData();
            controller.changeListen();

          }
          else{
            controller.selectedCartItems.remove(cartItem);
            controller.changeListen();
          }

       },
        title: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.borderRadius.r),
                  ),
                  child: CustomNetworkImage(
                      image: (cartItem.product?.imgUrls??[]).isNotEmpty?cartItem.product?.imgUrls?.first??"":"",
                  localImage: AppImagePath.noImage,
                  ),
                ),
                SizedBox(
                  width: AppDimensions.contentPadding.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HeaderText(
                        text: "${cartItem.product?.productName??""} (Qty ${cartItem.quantity})",
                        size: 10,
                      ),
                      SizedBox(
                        height: AppDimensions.contentPadding.h,
                      ),
                      CommonDescription(
                        contentPadding: 60,
                        fontSize: 10,
                        lineHeight: 0.99,
                        price: double.parse(cartItem.product?.regularPrice??"0"),
                        sizeHeight: cartItem.product?.sizeHeight??"",
                        sizeWidth: cartItem.product?.sizeWidth??"",
                        sizeLength: cartItem.product?.sizeLength??"",
                        brand: cartItem.product?.brandName??"",
                        material: cartItem.product?.materials??"",
                        weight: "${cartItem.product?.weight??""} ${cartItem.product?.unit??""}",
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: AppDimensions.contentPadding.w,
                ),
                SizedBox(
                  width: 80.w,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        controller.removeCart(singleCartModel: cartItem);
                      },
                      child: Image.asset(
                        AppImagePath.deleteIcon,
                        height: 20.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Row(
                children: [
                  IgnorePointer(
                    ignoring: (cartItem.quantity??0)<=1,
                    child: InkWell(
                      onTap: () {
                        controller.updateCart(currentValue:cartItem.quantity??0, cartId: cartItem.id.toString(), type: '-');
                      },
                      child: Icon(
                        Icons.remove_circle,
                        color: (cartItem.quantity??0)<=1
                            ?AppColors.inactiveColor
                            :AppColors.secondaryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.contentPadding.w),
                    child: HeaderText(
                      text: (cartItem.quantity??0).toString(),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        controller.updateCart(currentValue:cartItem.quantity??0, cartId: cartItem.id.toString(), type: '+');
                      },
                      child: Icon(
                        Icons.add_circle,
                        color: AppColors.secondaryColor,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
