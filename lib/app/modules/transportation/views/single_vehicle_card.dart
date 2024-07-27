import 'package:cgp/app/modules/transportation/models/vehicles_model.dart';
import 'package:cgp/common_widgets/custom_network_image.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleVehicleCard extends StatelessWidget {
  final SingleVehicleModel vehicle;
  final bool isSelected;
  final Function() onTap;

  const SingleVehicleCard(
      {super.key,
      required this.vehicle,
      required this.onTap,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: isSelected
            ? const EdgeInsets.only(left: 2, right: 2, top: 0, bottom: 5)
            : const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: Colors.white,
          elevation: isSelected ? 5 : 2,
          shadowColor: isSelected ? Colors.green : Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPadding.w,
                  vertical: AppDimensions.contentPadding.h),
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: AppDimensions.widgetPadding.w),
                        width: 80.w,
                        child: CustomNetworkImage(
                          image: vehicle.mediaUrl ?? "",
                          localImage: "assets/images/vehicle_0.png",
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: HeaderText(
                                    text: (vehicle.name ?? "").toString(),
                                    size: 12,
                                    align: TextAlign.start,
                                    color: AppColors.primaryColor,
                                    maxLine: 3,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  child: HeaderText(
                                    text: "Capacity",
                                    size: 12,
                                    align: TextAlign.start,
                                  ),
                                ),
                                HeaderText(
                                  text: ": ",
                                  size: 12,
                                ),
                                Expanded(
                                  child: BodyText(
                                    text:
                                        ("${vehicle.vehicleCapacity ?? " "} Ton"),
                                    size: 12,
                                    align: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isSelected)
                    Positioned(
                        left: 0,
                        top: 0,
                        child: Icon(
                          Icons.circle,
                          color: AppColors.successColor,
                        ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
