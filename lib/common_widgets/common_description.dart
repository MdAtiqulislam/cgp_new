import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constraints/body_text.dart';
import '../constraints/header_text.dart';

class CommonDescription extends StatelessWidget {
  final double fontSize;
  final double price;
  final String brand;
  final String sizeHeight;
  final String sizeWidth;
  final String sizeLength;
  final String material;
  final String weight;
  final double contentPadding;
  final double? lineHeight;

  const CommonDescription(
      {super.key,
      this.fontSize = 12,
      required this.sizeHeight,
      required this.sizeWidth,
      required this.sizeLength,
      required this.brand,
      required this.material,
      required this.price,
      required this.weight,
      this.contentPadding=100,
        this.lineHeight
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //price
      if(price>0)  Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: contentPadding.w,
                child: HeaderText(
                  text: "Price:",
                  size: fontSize,
                  align: TextAlign.start,
                  lineHeight: lineHeight,
                ),),
            Expanded(
              child: BodyText(
                text: "$price\$",
                align: TextAlign.start,
                size: fontSize,
                lineHeight: lineHeight,
              ),
            ),
          ],
        ),
        //brand

       if(brand.isNotEmpty) Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: contentPadding.w,
                child: HeaderText(
                  text: "Brand:",
                  size: fontSize,
                  align: TextAlign.start,
                  lineHeight: lineHeight,
                )),
            Expanded(
              child: BodyText(
                text: brand,
                align: TextAlign.start,
                size: fontSize,
                lineHeight: lineHeight,
              ),
            ),
          ],
        ),

        //size
       if(sizeHeight.isNotEmpty||sizeWidth.isNotEmpty||sizeLength.isNotEmpty) Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: contentPadding.w,
              child: HeaderText(
                text: "Size:",
                size: fontSize,
                align: TextAlign.start,
                lineHeight: lineHeight,
              ),
            ),
            Expanded(
              child: BodyText(
                text: "${sizeLength.isNotEmpty?"Height-$sizeHeight,":""} ${sizeWidth.isNotEmpty?"Width-$sizeWidth,":""} ${sizeLength.isNotEmpty?"Length-$sizeLength":""}",
                align: TextAlign.start,
                size: fontSize,
                lineHeight: lineHeight,
              ),
            ),
          ],
        ),
        //Material
       if(material.isNotEmpty) Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: contentPadding.w,
                child: HeaderText(
                  text: "Material:",
                  size: fontSize,
                  align: TextAlign.start,
                  lineHeight: lineHeight,
                ),),
            Expanded(
              child: BodyText(
                text: material,
                align: TextAlign.start,
                size: fontSize,
                lineHeight: lineHeight,
              ),
            ),
          ],
        ),
        //weight
     if(weight.isNotEmpty)   Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: contentPadding.w,
                child: HeaderText(
                  text: "Weight:",
                  size: fontSize,
                  align: TextAlign.start,
                  lineHeight: lineHeight,
                )),
            Expanded(
              child: BodyText(
                text: weight,
                align: TextAlign.start,
                size: fontSize,
                lineHeight: lineHeight,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
