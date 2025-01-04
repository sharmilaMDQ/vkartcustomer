import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

import '../Provider/ProductProvider.dart';

class MapController extends GetxController {
  late ProductProvider userDataProvider;
  var initialPosition = const LatLng(11.127123, 78.656891).obs;
  var infoWindowText = 'Click the map to get Lat/Lng!'.obs;
  RxString address= RxString("India");
  late GoogleMapController googleMapController;
  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    userDataProvider =
        Provider.of<ProductProvider>(Get.context!, listen: false);
  }
  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
   // googleMapController.animateCamera(CameraUpdate.newLatLng(initialPosition.value));

  }
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, show error message
      return Future.error('Location services are disabled.');
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, show error message
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, show error message
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    initialPosition.value = LatLng(position.latitude, position.longitude);
    // googleMapController.animateCamera(CameraUpdate.newLatLng(initialPosition.value));

  }


  void onMapClicked(LatLng latLng) async {
    infoWindowText.value = 'Lat: ${latLng.latitude}, Lng: ${latLng.longitude}';
    List<Placemark> result  = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (result.isNotEmpty){
      address.value ='${result[0].name}, ${result[0].locality} ${result[0].administrativeArea}';
    }
    initialPosition.value = latLng;
  }

  Future<void> setMarker(LatLng value, context) async {
    initialPosition.value = value;
    List<Placemark> result = await placemarkFromCoordinates(value.latitude, value.longitude);

    if (result.isNotEmpty) {
      address.value = '${result[0].name}, ${result[0].locality} ${result[0].administrativeArea} , ${result[0].postalCode}';
      userDataProvider.setLatitude(value.latitude.toString());
      userDataProvider.setLongitude(value.longitude.toString());
      userDataProvider.SetSelectedLocation(address.value);
      print("Address ${address.value}");
    }
     MotionToast.success(
        title: const Text("",
            style: TextStyle(color: Colors.black, fontSize: 14)),
        description: Text('📍' + address.value ?? "",
            style: TextStyle(color: Colors.white, fontSize: 12)),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60,
        borderRadius: 10,
        displaySideBar: false,
        enableAnimation: false,
      ).show(context);
    // Fluttertoast.showToast(msg: '📍' + address.value);
  }
}
