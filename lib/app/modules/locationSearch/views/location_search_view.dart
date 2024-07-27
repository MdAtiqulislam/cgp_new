import 'package:cgp/constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import '../../../../common_widgets/app_button.dart';
import '../../../../constraints/app_colors.dart';
import '../controllers/location_search_controller.dart';

class LocationSearchView extends GetView<LocationSearchController> {
  const LocationSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  Container(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w,vertical: AppDimensions.contentPadding.h),
        height: 70.h,
        child: AppButton(
          text: "select",
          bgColor: AppColors.primaryColor,
          onTap: () {
            controller.selectLocation();
          },
        ),
      ),
        body: Obx(
          () => SafeArea(
            child: controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      GoogleMap(
                        // padding: EdgeInsets.only(top: Get.height - 200.h),
                        onMapCreated: (mapController) {
                          if (!controller.mapController.isCompleted) {
                            controller.mapController.complete(mapController);
                          } else {
                            controller.mapController.future;
                          }
                        },
                        myLocationEnabled: true,
                        //myLocationButtonEnabled: false,
                        mapType: MapType.normal,
                        initialCameraPosition: controller.cameraPosition,
                        onCameraMove: (CameraPosition position) {
                          if (position.target.longitude !=
                                  controller.latitude.value ||
                              position.target.longitude !=
                                  controller.longitude.value) {
                            controller.latitude.value =
                                position.target.latitude;
                            controller.longitude.value =
                                position.target.longitude;
                          }
                        },
                        onCameraIdle: () {
                          controller.selectAddressFromMap(
                            LatLng(controller.latitude.value,
                                controller.longitude.value),
                          );
                        },
                      ),
                      Positioned(
                        left: AppDimensions.sectionPadding.w,
                        right: AppDimensions.widgetPadding * 4.w,
                        top: 10,
                        child: placesAutoCompleteTextField(),
                      ),
                      const Center(
                        child: Icon(
                          Icons.add_location,
                          size: 45,
                        ),
                      ),
                      // Container(height: Get.height,width: Get.width,color: Colors.black12,)
                    ],
                  ),
          ),
        ),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r)
      ),
      
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller.searchController,
        googleAPIKey: "AIzaSyCUqRnsyjWiluojL3z2-9VRoZ7ABubgbpE",
        inputDecoration: InputDecoration(
          hintText: "Search your location",
          border: InputBorder.none,
          enabledBorder: InputBorder.none,

        ),
        debounceTime: 400,
        //  countries: ["in", "fr"],
        isLatLngRequired: true,

        getPlaceDetailWithLatLng: (Prediction prediction) {
          controller.latitude.value = double.parse(prediction.lat.toString());
          controller.longitude.value = double.parse(prediction.lng.toString());
          controller.setCameraPosition();
        },

        itemClick: (Prediction prediction) {
          controller.searchController.text = prediction.description ?? "";
          controller.searchController.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));

          print("prediction.lng: ${prediction.lng.toString()}");
          /*controller.latitude.value=double.parse(prediction.lat??"0.0");
          controller.longitude.value=double.parse(prediction.lng??"0.0");
          */
          // controller.setCameraPosition();
        },
        seperatedBuilder: Divider(),
        containerHorizontalPadding: 10,

        // OPTIONAL// If you want to customize list view item builder
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(
                  width: 7,
                ),
                Expanded(child: Text("${prediction.description ?? ""}"))
              ],
            ),
          );
        },

        isCrossBtnShown: true,

        // default 600 ms ,
      ),
    );
  }
}
