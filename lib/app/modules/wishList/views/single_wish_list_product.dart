import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common_widgets/common_description.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../constraints/header_text.dart';
import '../../../../models/single_product_model.dart';

class SingleWishListProduct extends StatelessWidget {
  final int index;
  final SingleProductModel product;
  final Function()? delete;
  final Function()? addToCart;

  const SingleWishListProduct({
    super.key,
    required this.index,
    required this.product,
    this.delete,
    this.addToCart
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              child: Image.asset(
                "assets/images/moc_image_${index % 10}.png",
                fit: BoxFit.fill,
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
                    text: product.productName??"",
                    size: 10,
                  ),
                  SizedBox(
                    height: AppDimensions.contentPadding.h,
                  ),
                  CommonDescription(
                    contentPadding: 60,
                    fontSize: 10,
                    lineHeight: 0.99,
                    price: double.parse(product.regularPrice??"0.0"),
                    sizeLength:product.sizeLength??"",
                    sizeWidth:product.sizeWidth??"",
                    sizeHeight:product.sizeHeight??"",
                    brand:product.brandName??"",
                    material:product.materials??"",
                    weight: product.weight??"",
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
                child: IconButton(
                  onPressed: (){
                    if(delete!=null){
                      delete!();
                    }
                  },
                  icon: Image.asset(
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
          child: InkWell(
            onTap: () {
              if(addToCart!=null){
                addToCart!();
              }
            },
            child: Center(
              child: HeaderText(
                text: "Add To Cart",
                color: AppColors.primaryColor,
                size: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
