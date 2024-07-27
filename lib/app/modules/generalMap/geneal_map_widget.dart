import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import 'general_map_controller.dart';

class GeneralMapWidget extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final BorderRadiusGeometry borderRadius;
  final Color borderColor;
  final double borderWidth;
  final bool myLocationEnabled;
  final MapType mapType;
  final double height;
  final bool showPolyLine;
  final bool showMarkers;
  final bool showNavigation;
  final Function()? startNavigation;

  const GeneralMapWidget({
    super.key,
    this.margin = const EdgeInsets.all(8.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.borderColor = Colors.grey,
    this.borderWidth = 1.0,
    this.myLocationEnabled = true,
    this.mapType = MapType.normal,
    this.height = 400.0,
    this.showMarkers = true,
    this.showPolyLine = true,
    this.showNavigation = false,
    this.startNavigation
  });

  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(MapController());

    return Obx(
      () => mapController.isLoading.value
          ? const CircularProgressIndicator()
          : Container(
              clipBehavior: Clip.hardEdge,
              margin: margin,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(color: borderColor, width: borderWidth),
              ),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                ),
                child: Obx(
                  () => mapController.isLoading.value
                      ? const CircularProgressIndicator()
                      : GoogleMap(
                          onMapCreated: mapController.onMapCreated,
                          myLocationEnabled: myLocationEnabled,
                          mapType: mapType,
                          initialCameraPosition:
                              mapController.initialCameraPosition,
                          onCameraMove: mapController.onCameraMove,
                          polylines: showPolyLine
                              ? mapController.polyLines.value
                              : {},
                          markers: showMarkers ? mapController.markers : {},
                        ),


                ),

              ),
            ),
    );
  }
}
