import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../models/single_product_model.dart';


class SingleSearchItem extends StatelessWidget {
  final int index;
  final bool isFavourite;
  final bool isCart;
  final SingleProductModel product;
  final Function() onTapFavourite;
  final Function() onTapCart;

  const SingleSearchItem({

    required this.product,
    required this.index,
    this.isCart=false,
    this.isFavourite=false,
   required this.onTapCart,
    required this.onTapFavourite,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          border: Border.all(width: 1, color: AppColors.shadowColor),
          boxShadow: [
            BoxShadow(color: AppColors.shadowColor, blurRadius: 5.r)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            //height: 100,
            clipBehavior: Clip.hardEdge,
            width: 120.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
            ),
            child: Image.asset(
              "assets/images/moc_image_${index % 10}.png",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: AppDimensions.contentPadding.w,
          ),
          Expanded(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(
                  text: product.productName??"",
                  align: TextAlign.start,
                  size: 14,
                ),
                BodyText(
                  text:product.shortDesc??"",
                  align: TextAlign.start,
                  size: 10,
                  maxLine: 2,
                ),
                Text.rich(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  TextSpan(
                      text: "Brand: ",
                      style: TextStyle(
                          color: AppColors.headerTextColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp),
                      children: [
                        TextSpan(
                          text: product.brandName,
                          style: TextStyle(
                              color: AppColors.bodyTextColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ]),
                ),
                Text.rich(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  TextSpan(
                      text: "Material: ",
                      style: TextStyle(
                          color: AppColors.headerTextColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp),
                      children: [
                        TextSpan(
                          text: product.materials,
                          style: TextStyle(
                              color: AppColors.bodyTextColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ]),
                ),


                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 3.0.h, right: 3.w),
                      child: Icon(
                        Icons.shopping_bag,
                        color: AppColors.headerTextColor,
                        size: 10.sp,
                      ),
                    ),
                    Expanded(
                      child: BodyText(
                        text:product.warehouses?[0].warehouseName??"",
                        align: TextAlign.start,
                        size: 10,
                      ),
                    ),
                  ],
                ),

                Text.rich(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  TextSpan(
                      text: "Price: ",
                      style: TextStyle(
                          color: AppColors.headerTextColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp),
                      children: [
                        TextSpan(
                          text: "\$${product.salesPrice}",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ]),
                ),


             /*   CommonDescription(
                  contentPadding: 70,
                  fontSize: 10,
                  price: double.parse(product.price??"0.0"),
                  size: "5*6 feet",
                  brand: product.brandName??"",
                  material: product.materials??"",
                  weight:
                  "${product.weight ?? ""}"
                      "${product.unit ?? ""}",
                )*/
               /* Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 3.0.h, right: 3.w),
                      child: Icon(
                        Icons.fire_truck,
                        color: AppColors.headerTextColor,
                        size: 10.sp,
                      ),
                    ),
                    Expanded(
                      child: BodyText(
                        text: "9.5 km away",
                        size: 10,
                        align: TextAlign.start,
                      ),
                    ),
                  ],
                ),*/
              ],
            ),
          ),
          SizedBox(
            width: AppDimensions.contentPadding.w,
          ),
          Column(
            children: [
              /*PopupMenuButton<int>(
                icon: Icon(Icons.more_horiz_outlined),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.favorite_outlined,
                          color: isFavourite
                              ? AppColors.primaryColor
                              : AppColors.inactiveColor,
                        ),
                        SizedBox(
                          width: AppDimensions.contentPadding.w,
                        ),
                        Expanded(
                            child: HeaderText(
                              text: "Add to Favourite",
                              fontWeight: FontWeight.w400,
                              size: 14,
                              align: TextAlign.start,
                            )),
                        SizedBox(
                          width: AppDimensions.contentPadding.w,
                        ),
                        IconButton(
                          onPressed: () {

                          },
                          icon: Icon(Icons.check_sharp,
                              color: isFavourite
                                  ? AppColors.primaryColor
                                  : AppColors.inactiveColor),
                        ),
                      ],
                    ),
                    value: 1,
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: isCart
                              ? AppColors.primaryColor
                              : AppColors.inactiveColor,
                        ),
                        SizedBox(
                          width: AppDimensions.contentPadding.w,
                        ),
                        Expanded(
                            child: HeaderText(
                              text: "Add to Cart",
                              fontWeight: FontWeight.w400,
                              size: 14,
                              align: TextAlign.start,
                            )),
                        SizedBox(
                          width: AppDimensions.contentPadding.w,
                        ),
                        IconButton(
                          onPressed: () {
                          },
                          icon: Icon(Icons.check_sharp,
                              color: isCart
                                  ? AppColors.primaryColor
                                  : AppColors.inactiveColor),
                        ),
                      ],
                    ),
                    value: 1,
                  ),
                ],
              ),*/
              IconButton(
                  icon: Icon(Icons.favorite_outline,color: AppColors.headerTextColor,size: 25.sp,),
              onPressed: (){
                    onTapFavourite();
              },
              ),
              IconButton(icon: Icon(Icons.shopping_cart,color: AppColors.headerTextColor,size: 25.sp,),
              onPressed: (){
                onTapCart();
              },
              ),

            ],

          ),

        ],
      ),
    );
  }
}
