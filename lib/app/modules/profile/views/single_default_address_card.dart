import 'package:cgp/common_widgets/custom_check_box.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:cgp/models/single_address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleDefaultAddressCard extends StatelessWidget {
  final SingleAddressModel address;
  final Function? onTap;

  const SingleDefaultAddressCard(
      {
        this.onTap,
        required this.address, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BodyText(
                text: (address.addressType??"").toUpperCase(),
                color: AppColors.primaryColor,
              ),
              SizedBox(
                height: AppDimensions.contentPadding.h,
              ),
              HeaderText(
                text: "${address.firstName ?? ""} ${address.lastName ?? ""}",
                size: 12,
              ),
              HeaderText(
                text: "${address.address ?? ""}"
                    " ${address.city == null ? "" : "${address.city},"}"
                    " ${address.state == null ? "" : "${address.state},"}"
                    " ${address.countryId == null ? "" : "${address.countryId},"}",
                size: 12,
                maxLine: 5,
                align: TextAlign.start,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            if(onTap!=null){
              onTap!();
            }
          },
          icon: Image.asset(AppImagePath.editIcon,scale: 2,),
        ),
      ],
    );
  }
}
