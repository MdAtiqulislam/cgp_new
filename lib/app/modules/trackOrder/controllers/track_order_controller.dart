import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/app_strings.dart';
import '../../orderDetails/models/order_details_model.dart';

class TrackOrderController extends GetxController {
  final Completer<GoogleMapController> mapController = Completer();
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(23.911522, 90.388962),
    zoom: 14.4746,
  );

  var polyLines = <Polyline>{}.obs;
  var directionsSteps = <String>[].obs;
  var _markers = <Marker>{}.obs; // Changed to RxSet
  BitmapDescriptor? destinationIcon;

  var pickupPointName = "Pickup Point".obs;
  var destinationPointName = "Destination Point".obs;
  var isLoading = false.obs;
  var orderDetails = OrderDetailsModel().obs;

  late IO.Socket socket;

  @override
  void onInit() {
    super.onInit();
    loadCustomMarker();
    initializeSocket();
  }

  @override
  void onClose() {
    socket.disconnect();
    socket.close();
    super.onClose();
  }

  void initializeSocket() {
    socket = IO.io('https://cgp-rider-api.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.on('connect', (_) {
      print('Connected to socket server');
    });

    socket.on('locationUpdated', (data) {
      if (data['riderId'] == (orderDetails.value.data?.deliveryInfo?.rider?.id ?? "")) {
        LatLng newLocation = LatLng(
          data['location']['coordinates'][1], // Latitude
          data['location']['coordinates'][0], // Longitude
        );
        print("newLocation: $newLocation");
        updateRiderLocation(newLocation);
      }
    });

    socket.on('disconnect', (_) {
      print('Disconnected from socket server');
    });
  }



  void updateRiderLocation(LatLng newLocation) async {
    if (_markers.isNotEmpty) {
      _markers.removeWhere((marker) => marker.markerId.value == 'currentLocationMarker');
    }
    final Marker currentLocationMarker = Marker(
      markerId: const MarkerId('currentLocationMarker'),
      position: newLocation,
      infoWindow: const InfoWindow(title: "Current Location"),
      icon: destinationIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    _markers.add(currentLocationMarker);

    final GoogleMapController googleMapController = await mapController.future;
    try {
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: newLocation, zoom: 14.4746),
      ));
    } catch (e) {
      if (e is MissingPluginException) {
        print("MissingPluginException: ${e.message}");
      } else {
        rethrow;
      }
    }
  }

  void onMapCreated(GoogleMapController controller) {
    if (!mapController.isCompleted) {
      mapController.complete(controller);
    }
  }

  void setCameraPosition({required LatLng target}) async {
    CameraPosition newCameraPosition = CameraPosition(
      target: target,
      zoom: 14.4746,
    );
    initialCameraPosition = newCameraPosition;
    final GoogleMapController googleMapController = await mapController.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future<void> generateRoute({
    required LatLng origin,
    required LatLng destination,
    required LatLng currentLocation,
  }) async {
    polyLines.value = {};

    const String apiKey = 'AIzaSyCUqRnsyjWiluojL3z2-9VRoZ7ABubgbpE';
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

        addMarkers(origin, destination, currentLocation);
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

  void addMarkers(LatLng origin, LatLng destination, LatLng currentLocation) {
    _markers.clear();
    final Marker originMarker = Marker(
      markerId: const MarkerId('origin'),
      position: origin,
      infoWindow: InfoWindow(title: pickupPointName.value),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    final Marker destinationMarker = Marker(
      markerId: const MarkerId('destination'),
      position: destination,
      infoWindow: InfoWindow(title: destinationPointName.value),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    final Marker currentLocationMarker = Marker(
      markerId: const MarkerId('currentLocationMarker'),
      position: currentLocation,
      infoWindow: const InfoWindow(title: "Current Location"),
      icon: destinationIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    if (currentLocation.longitude != 0.0 || currentLocation.latitude != 0.0) {
      _markers.addAll([originMarker, currentLocationMarker, destinationMarker]);
    } else {
      _markers.addAll([originMarker, destinationMarker]);
    }
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

  Future<void> startNavigation({
    required LatLng destination,
    required LatLng pickup,
    required LatLng currentLocation,
  }) async {
    pickupPointName.value = "My Location";
    destinationPointName.value = "Pickup Point";
    await generateRoute(origin: pickup, destination: destination, currentLocation: currentLocation);
    setCameraPosition(target: pickup);
  }
}
