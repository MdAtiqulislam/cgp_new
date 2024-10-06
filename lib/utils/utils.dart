import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cgp/app/modules/cart/models/my_cart_model.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/local_services.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import '../../constraints/app_colors.dart';
import '../app/modules/wishList/models/wish_list_model.dart';
import '../constraints/dimensions.dart';
import 'custom_location.dart';

/*  ******Function to pic image***** */
Future<XFile?> picImage(ImageSource imageSource) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: imageSource);
  if (file != null) {
    return file;
  } else {
    return null;
  }
}

/*  ******Function to crop image***** */

Future<CroppedFile?> cropImage({required String filePath,  CropStyle? cropStyle}) async {
  return await ImageCropper().cropImage(
    cropStyle: cropStyle??CropStyle.circle,
    sourcePath: filePath,
    aspectRatioPresets: [
      // CropAspectRatioPreset.square,
      //CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      // CropAspectRatioPreset.ratio4x3,
      //CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Edit',
          toolbarColor: Colors.white,
          toolbarWidgetColor: AppColors.primaryColor,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Edit',
      ),
    ],
  );
}

/*  ******Function to format date***** */

String formatDate(String? date) {
  if (date != null && date.isNotEmpty) {
    DateTime dDate = DateFormat('y-M-d').parse(date);
    return DateFormat("MMM -yy").format(dDate);
  } else {
    return "";
  }
}

/*  ******Function to decoration input fields***** */
InputDecoration inputDecoration(
    {String? hintText,
    String? levelText,
    required bool isRequired,
    Widget? preFix,
    Widget? suffix}) {
  return InputDecoration(
    errorMaxLines: 5,
    counterText: "",
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      borderSide: const BorderSide(color: AppColors.inactiveColor),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      borderSide: const BorderSide(color: AppColors.inactiveColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      borderSide: const BorderSide(color: AppColors.bodyTextColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      borderSide: const BorderSide(color: AppColors.primaryColor),
    ),
    contentPadding: EdgeInsets.only(
        left: 24,
        bottom: AppDimensions.widgetPadding.h,
        top: AppDimensions.widgetPadding.h),
    hintText: hintText,
    labelText: isRequired ? "$levelText *" : levelText,
    floatingLabelStyle: const TextStyle(
      color: AppColors.bodyTextColor,
      fontWeight: FontWeight.bold,
    ),
    prefixIcon: preFix,
    suffixIcon: suffix,
    hintStyle: const TextStyle(color: AppColors.bodyTextColor, fontSize: 14),
    labelStyle: const TextStyle(color: AppColors.bodyTextColor, fontSize: 14),
  );
}

/*  ******Function to get http success status***** */
bool isHttpStatusSuccess(int statusCode) {
  if (kDebugMode) {
    print(statusCode);
  }

  return statusCode >= 200 && statusCode < 300;
}

/*  ******Function to generate http error message***** */
String generateHttpErrorMessage(int errorCode) {
  switch (errorCode) {
    case 400:
      return "400 Bad Request: The server cannot process the request due to a client error.";
    case 401:
      return "401 Unauthorized: The request has not been applied because it lacks valid authentication credentials for the target resource.";
    case 403:
      return "403 Forbidden: The server understood the request but refuses to authorize it.";
    case 404:
      return "404 Not Found: The server cannot find the requested resource.";
    case 405:
      return "405 Method Not Allowed: The method specified in the request is not allowed for the resource identified by the request.";
    case 406:
      return "406 Not Acceptable: The server cannot produce a response matching the list of acceptable values.";
    case 408:
      return "408 Request Timeout: The server did not receive a complete request message within the time that it was prepared to wait.";
    case 409:
      return "409 Conflict: The request could not be completed due to a conflict with the current state of the target resource.";
    case 410:
      return "410 Gone: The requested resource is no longer available and will not be available again.";
    case 500:
      return "500 Internal Server Error: The server encountered an unexpected condition that prevented it from fulfilling the request.";
    case 501:
      return "501 Not Implemented: The server does not support the functionality required to fulfill the request.";
    case 502:
      return "502 Bad Gateway: The server, while acting as a gateway or proxy, received an invalid response from an inbound server it accessed while attempting to fulfill the request.";
    case 503:
      return "503 Service Unavailable: The server is currently unable to handle the request due to temporary overloading or maintenance of the server.";
    case 504:
      return "504 Gateway Timeout: The server, while acting as a gateway or proxy, did not receive a timely response from an upstream server it needed to access in order to complete the request.";
    case 505:
      return "505 HTTP Version Not Supported: The server does not support, or refuses to support, the HTTP protocol version that was used in the request message.";
    default:
      return "$errorCode: Unknown Error";
  }
}



/*  ******Function to calculate distance using Haversine formula***** */
double calculateDistance(CustomLocation start, CustomLocation end) {
  const double earthRadius = 6371; // Radius of the earth in km

  // Convert degrees to radians
  double toRadians(double degree) {
    return degree * pi / 180;
  }

  // Haversine formula
  double dLat = toRadians(end.latitude - start.latitude);
  double dLon = toRadians(end.longitude - start.longitude);
  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(toRadians(start.latitude)) *
          cos(toRadians(end.latitude)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = earthRadius * c;

  return distance;
}


double calculateDistanceInMeter(LatLng start, LatLng end)
{

  print("$start  $end" );

  return   Geolocator.distanceBetween(
     start.latitude,
     start.longitude,
     end.latitude,
     end.longitude,
  );
}



/* ****Get current Location***** */
Future<LocationData?> getCurrentLocation() async {
  // Initialize the location plugin
  Location location = Location();

  // Check if location services are enabled
  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      if (kDebugMode) {
        print('Location services are disabled.');
      }
      return null;
    }
  }

  // Check for location permission
  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      if (kDebugMode) {
        print('Location permission is denied.');
      }
      return null;
    }
  }

  // Get the current location
  try {
    LocationData currentLocation = await location.getLocation();
    return currentLocation;
  } catch (e) {
    if (kDebugMode) {
      print('Error getting location: $e');
    }
    return null;
  }
}

Future<String?> distanceFromMyLocation(
    {required String? latitude, required String? longitude}) async {
  if (latitude != null && longitude != null) {
    var currentLocation = await getCurrentLocation();
    if (currentLocation != null) {
      CustomLocation start = CustomLocation(
          currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0);
      CustomLocation end =
      CustomLocation(double.parse(latitude), double.parse(longitude));

      // Calculate distance in miles and convert to kilometers
      var distanceInMiles = calculateDistance(start, end);
      var distanceInKm = distanceInMiles * 1.60934;

      var dis = "${distanceInKm.toStringAsFixed(2)} KM away";

      return dis;
    } else {
      return null;
    }
  } else {
    return null;
  }
}


Future<WishListModel?> getWishListFromLocal()async{
  var token=await LocalServices.getToken();
  WishListModel? wishListModel=WishListModel();
  wishListModel=await LocalServices.getWishList();
  if(wishListModel==null && token!=null ){
    wishListModel=  await  getWishListFromRemoteServer();
  }
  return wishListModel;

}

Future<WishListModel?> getWishListFromRemoteServer()async {
  WishListModel wishListModel=WishListModel();
  var endPoint=APIEndPoints.getWishList;
  var response=await RemoteServices.getRequest(endPoint: endPoint);
  if(response!=null){
    wishListModel=WishListModel.fromJson(response);
    await LocalServices().storeWishList(wishListModel);
    return wishListModel;
  }else{
    return null;
  }

}



Future<MyCartModel?> getMyCarFromLocal()async{
  var token=await LocalServices.getToken();

  MyCartModel? myCartModel=MyCartModel();
  myCartModel=await LocalServices.getMyCart();
  if(myCartModel==null && token!=null ){
    myCartModel=  await  getMyCartFromRemoteServer();
  }
  return myCartModel;

}

Future<MyCartModel?> getMyCartFromRemoteServer()async {
  MyCartModel myCartModel=MyCartModel();
  var endPoint=APIEndPoints.getMyCart;
  var response=await RemoteServices.getRequest(endPoint: endPoint);
  if(response!=null){
    myCartModel=MyCartModel.fromJson(response);
    await LocalServices().storeMyCart(myCartModel);
    return myCartModel;
  }else{
    return null;
  }
}
int calculateAge(String dateOfBirth) {

  DateTime dob=DateFormat("yyyy-mm-dd").parse(dateOfBirth);

  DateTime today = DateTime.now();
  int age = today.year - dob.year;
  if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
    age--;
  }
  return age;
}

Future<String> getImageAsBase64(CroppedFile imageFile) async {
  List<int> imageBytes = await imageFile.readAsBytes();
  String base64Image = base64Encode(imageBytes);
  return base64Image;
}

String formatDateTime({String? dateTimeToConvert}) {
  if (dateTimeToConvert != null && dateTimeToConvert.isNotEmpty) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeToConvert);

      // Format the DateTime object to the desired format
      DateFormat dateFormat = DateFormat("d MMM y, h:mm a");

      // Convert to the desired time zone (local time zone in this case)
      dateTime = dateTime.toLocal();

      String formattedDate = dateFormat.format(dateTime);

      return formattedDate;
    } catch (e) {
      // Handle parsing error
      return "--";
    }
  } else {
    return "--";
  }
}

String formatDistance({required double distanceInMeter}) {

  if (kDebugMode) {
    print(distanceInMeter);
  }
  if (distanceInMeter<0) {
    return "0 meter ";
  }else if (distanceInMeter < 1000) {
    return  "${distanceInMeter.toStringAsFixed(1)} meter";
  }
  else {
    final distanceInKilometers = distanceInMeter / 1000;
    return "${distanceInKilometers.toStringAsFixed(1)} km";
  }
}

