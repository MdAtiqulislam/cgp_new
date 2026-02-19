

/*class MapController extends GetxController {
  final Completer<GoogleMapController> mapController = Completer();
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

   CameraPosition initialCameraPosition =const CameraPosition(
    target: LatLng(23.911522, 90.388962),
   // zoom: 16.4746,
    zoom: 14.4746,
  );

   @override
  void onInit() async{
    super.onInit();
   await getCurrentLocation();
  }

  void onMapCreated(GoogleMapController controller) {
    if (!mapController.isCompleted) {
      mapController.complete(controller);
    }
  }


  void onCameraMove(CameraPosition position) {
    if (position.target.latitude != latitude.value ||
        position.target.longitude != longitude.value) {
      latitude.value = position.target.latitude;
      longitude.value = position.target.longitude;
    }
  }

 Future<void> getCurrentLocation()async{
    LocationServices.getCurrentLocation().then(
          (value) {
        latitude.value=value.latitude;
        longitude.value=value.longitude;
        setCameraPosition();
        return LocationServices.getAddress(
          LatLng(value.latitude, value.longitude),
        );
      },
    );
  }
  void setCameraPosition() async {
    CameraPosition newCameraPosition = CameraPosition(
        target: LatLng(latitude.value, longitude.value),
        //zoom: 16.4746
        zoom: 14.4746
    );
    initialCameraPosition = newCameraPosition;
    final GoogleMapController googleMapController = await mapController.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }
}*/

import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../constraints/app_colors.dart';
import '../../../constraints/app_strings.dart';
import '../../../services/location_services.dart';


class MapController extends GetxController {
  final Completer<GoogleMapController> mapController = Completer();
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading=false.obs;
  var directionsSteps = <String>[].obs;
  //var isButtonEnabled=false.obs;
  var closerToDestination=false.obs;
  var moveToCurrentLocation=true;
  StreamSubscription<Position>? positionStreamSubscription;

  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(23.911522, 90.388962),
    zoom: 14.4746,
  );

  var polyLines = <Polyline>{}.obs;
  final Set<Marker> _markers = <Marker>{}.obs;
  BitmapDescriptor? destinationIcon;

  var pickupPointName="Pickup Point".obs;

  var destinationPointName="Destination Point".obs;
  @override
  void onInit() async {
    super.onInit();
    await getCurrentLocation();
   await loadCustomMarker();

  }

  void onMapCreated(GoogleMapController controller) {
    if (!mapController.isCompleted) {
      mapController.complete(controller);
    }
  }

  void onCameraMove(CameraPosition position) {
    if (position.target.latitude != latitude.value ||
        position.target.longitude != longitude.value) {
      latitude.value = position.target.latitude;
      longitude.value = position.target.longitude;
    }
  }

  Future<void> getCurrentLocation() async {
    LocationServices.getCurrentLocation().then(
          (value) {
        latitude.value = value.latitude;
        longitude.value = value.longitude;
        if(moveToCurrentLocation)setCameraPosition();
        return LocationServices.getAddress(
          LatLng(value.latitude, value.longitude),
        );
      },
    );
  }

  void setCameraPosition({LatLng? target}) async {
    CameraPosition newCameraPosition = CameraPosition(
      target:target?? LatLng(latitude.value, longitude.value),
      zoom: 14.4746,
    );
    initialCameraPosition = newCameraPosition;
    final GoogleMapController googleMapController = await mapController.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future<void> generateRoute({required LatLng origin,required LatLng destination}) async {
    polyLines.value={};

    const String apiKey = 'AIzaSyBprY90fvqn9LQqEhe4mSIyDf1UekyT2Po';
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<LatLng> polylinePoints = [];
      directionsSteps.clear();


      if ((data['routes'] as List).isNotEmpty) {
        var points = data['routes'][0]['overview_polyline']['points'];
        polylinePoints = decodePolyline(points);
        addPolyline(polylinePoints);

        var steps = data['routes'][0]['legs'][0]['steps'];
        for (var step in steps) {
          directionsSteps.add(step['html_instructions']);
        }

        addMarkers(origin, destination);
      }
    } else {
      throw Exception('Failed to load route');
    }
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polyline.add(LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble()));
    }

    return polyline;
  }

  void addPolyline(List<LatLng> points) {
    final String polylineIdVal = 'polyline_${DateTime.now().millisecondsSinceEpoch}';
    final PolylineId polylineId = PolylineId(polylineIdVal);

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      color: AppColors.primaryColor,
      points: points,
      width: 5,
    );

    polyLines.add(polyline);
  }

  void addMarkers(LatLng origin, LatLng destination) {
    _markers.clear();
    final Marker originMarker = Marker(
      markerId: const MarkerId('origin'),
      position: origin,
      infoWindow:  InfoWindow(title: pickupPointName.value),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    final Marker destinationMarker = Marker(
      markerId: const MarkerId('destination'),
      position: destination,
      infoWindow:  InfoWindow(title:destinationPointName.value ),
      icon: destinationIcon??BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    _markers.addAll([originMarker, destinationMarker]);
  }

  Set<Marker> get markers => _markers;



  Future<void> loadCustomMarker() async {
    destinationIcon = await _getBitmapDescriptorFromAssetBytes(
      AppImagePath.deliveryVanMarker,
      50, // Width in pixels
    );
  }

  Future<BitmapDescriptor> _getBitmapDescriptorFromAssetBytes(String path, int width) async {
    final ByteData data = await rootBundle.load(path);
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(
      bytes,
      targetWidth: width,
    );
    final ui.FrameInfo fi = await codec.getNextFrame();
    final Uint8List resizedBytes = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(resizedBytes);
  }

  Future<void> startNavigation({required LatLng destination}) async {

    pickupPointName.value="My Location";
    destinationPointName.value="Pickup Point";
    final currentLocation = LatLng(latitude.value, longitude.value);
    await generateRoute(origin: currentLocation, destination: destination);
  }
/*
  void startLocationUpdates({required LatLng destination}) {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,//10
    );

    positionStreamSubscription=  Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      double distanceInMeters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        destination.latitude, // Define pickupLat and pickupLng as the latitude and longitude of the pickup point
        destination.longitude,
      );

      if (distanceInMeters <= 100) {
        print("Calling.......");
        print(Get.find<StartTripController>().isButtonEnabled.value);
        Get.put(StartTripController());

        if(!Get.find<StartTripController>().reachedToDestination.value){
          Get.find<StartTripController>().status.value=TripStatus.closerToDestination;
        }
        Get.find<StartTripController>().isButtonEnabled.value=true;
        Get.find<StartTripController>().controlButtonStatus();

      } else {
      //  isButtonEnabled.value = false;
        Get.find<StartTripController>().isButtonEnabled.value=false;
        closerToDestination.value=false;
      }
    });
  }

  void stopLocationUpdates() {
    print("Stop Location update is called.");
    positionStreamSubscription?.cancel();
    positionStreamSubscription = null;
  }*/

}


