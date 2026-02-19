

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../../../../services/location_services.dart';

class LocationSearchController extends GetxController {

  var isLoading = false.obs;

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  final TextEditingController searchController = TextEditingController();
  final Set<Marker> markers = {};
  final Set<Polyline> polylines = {};
  Completer<GoogleMapController> mapController = Completer();
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(23.911522, 90.388962),
    zoom: 16.4746,
  );

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

@override
  void onInit() {
  LocationServices.getCurrentLocation().then(
        (value) {
      latitude.value=value.latitude;
      longitude.value=value.longitude;
      setCameraPosition();
      return LocationServices.getAddress(
        LatLng(value.latitude, value.longitude),
      ).then((value) => searchController.text = value);
    },
  );

  //setCameraPosition();
  isLoading.value = false;
  super.onInit();
  }

  void selectAddressFromMap(LatLng value) async {
    await LocationServices.getAddressFromMap(value)
        .then((value) => searchController.text = value);
  }

  void selectLocation() {

    var value=[searchController.text,latitude.value,longitude.value];
    Get.back(result: value);
  }

  void setCameraPosition() async {
    CameraPosition newCameraPosition = CameraPosition(
        target: LatLng(latitude.value, longitude.value), zoom: 16.4746);
    cameraPosition = newCameraPosition;
    final GoogleMapController googleMapController = await mapController.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }



/*  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  Completer<GoogleMapController> mapController = Completer();
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(23.911522, 90.388962),
    zoom: 16.4746,
  );

  final TextEditingController searchLocationController =
  TextEditingController();

  @override
  void onInit() async {
    LocationServices.getCurrentLocation().then(
          (value) {
        latitude.value=value.latitude;
        longitude.value=value.longitude;
        setCameraPosition();
        return LocationServices.getAddress(
          LatLng(value.latitude, value.longitude),
        ).then((value) => searchLocationController.text = value);
      },
    );

    //setCameraPosition();
    isLoading.value = false;
    super.onInit();
  }

  void selectAddressFromMap(LatLng value) async {
    await LocationServices.getAddressFromMap(value)
        .then((value) => searchLocationController.text = value);
  }

  void selectLocation() {

    var value=[searchLocationController.text,latitude.value,longitude.value];
    Get.back(result: value);

    print(value);
  }

  void setCameraPosition() async {
    CameraPosition newCameraPosition = CameraPosition(
        target: LatLng(latitude.value, longitude.value), zoom: 16.4746);
    cameraPosition = newCameraPosition;
    final GoogleMapController googleMapController = await mapController.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }*/
}
