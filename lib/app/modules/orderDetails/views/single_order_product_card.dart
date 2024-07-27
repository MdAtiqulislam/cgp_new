import 'package:cgp/common_widgets/custom_network_image.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/order_details_model.dart';
class SingleOrderProductCard extends StatelessWidget {
  final OrderDetailsLineItem product;
  const SingleOrderProductCard({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomNetworkImage(image: "",localImage: "assets/images/moc_image_1.png",),
        SizedBox(width: AppDimensions.widgetPadding.w,),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderText(text:"${product.name??"Name: "}"),
            BodyText(text: "Brand: ${product.brandName??""}"),
            BodyText(text: "Weight: ${product.weight}"),
            BodyText(text: "Quantity: ${product.quantity}"),
          ],
        ),),
        Column(
          children: [
            const BodyText(text: "Total"),
            HeaderText(text: product.salesPrice??"0")
          ],
        )
      ],
    );
  }
}
