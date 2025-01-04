import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import '../Apiconnect/ApiConnect.dart';
import '../Provider/ProductProvider.dart';
import '../UI/Addresses/addNewAddressScreen.dart';
import '../utility/AppPreference.dart';
import 'AddNewAddressController.dart';

class AddressViewController extends GetxController {
  AddNewAddressController addController = Get.put(AddNewAddressController());
  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  final searchResults = <AutocompletePrediction>[].obs;
  late GooglePlace googlePlace;

  final initialPosition2 = CameraPosition(target: LatLng(0.0, 0.0), zoom: 14.0);
  CameraPosition initialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  final ApiConnect _connect = Get.put(ApiConnect());
  LatLng? lastMapPosition;
  RxInt houseNo = 2.obs;
  RxInt otherTypeValidation = 2.obs;
  RxString houseNoErrorText = ''.obs;
  RxString otherTypeErrorText = ''.obs;
  RxString houseNoText = ''.obs;
  RxString otherTypeText = ''.obs;
  RxString directionText = ''.obs;
  RxString roadText = ''.obs;
  late ProductProvider userDataProvider;
  RxString addressType = "".obs;
  RxString otherText = ''.obs;
  RxBool isLoading = RxBool(false);
  RxBool isDefaultAddress = RxBool(false);
  String get defaultAddressPayload => isDefaultAddress.value ? "Yes" : "No";
  String get addressTypePayload => addressType.value == "Other" ? customAddressTypeController.text : addressType.value;
  final GlobalKey markerKey = GlobalKey();
  var customMarker = Rx<BitmapDescriptor?>(null);

  RxString street = "".obs;
  RxString fullAddress = "".obs;
  RxString postalCode = "".obs;
  RxString locality = "".obs;
  RxString country = "".obs;
  RxString name = "".obs;
  RxString subThoroughfare = "".obs;
  RxString thoroughfare = "".obs;
  RxString subLocality = "".obs;
  RxString administrativeArea = "".obs;

  TextEditingController otherController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController roadController = TextEditingController();
  TextEditingController directionController = TextEditingController();
  TextEditingController customerAddresscontroller = TextEditingController();
  TextEditingController customerCitycontroller = TextEditingController();
  TextEditingController customerStatecontroller = TextEditingController();
  TextEditingController customerPincodecontroller = TextEditingController();
  TextEditingController customerCountrycontroller = TextEditingController();
  TextEditingController addressTypeController = TextEditingController();
  TextEditingController customAddressTypeController = TextEditingController();
  TextEditingController customerHouseNocontroller = TextEditingController();
  TextEditingController customerApartmentcontroller = TextEditingController();
  TextEditingController customerLandmarkController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  Timer? _debounce;
  RxBool isOtherClicked = false.obs;

  @override
  void onInit() {
    super.onInit();
    _determinePosition(); // Get current location as the initial position
    userDataProvider = Provider.of<ProductProvider>(Get.context!, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      customMarker.value = await createCustomMarkerBitmap(markerKey);
    });
  }

  void updateAddressType(String type) {
    // Update addressType observable and text controller value
    addressType.value = type;
    addressTypeController.text = type;

    // Check if "Other" is selected, update isOtherClicked accordingly
    isOtherClicked.value = (type == 'Other');
  }

  void onCameraMove(CameraPosition position) {
    // if (_debounce?.isActive ?? false) _debounce?.cancel();
    // _debounce = Timer(const Duration(milliseconds: 500), () {
    lastMapPosition = position.target;
    print(lastMapPosition);
    // });
  }

  void onCameraIdle() {
    getAddressFromLatLng(lastMapPosition?.latitude, lastMapPosition?.longitude);
  }

  void setHouseNo(String value) {
    houseNoText.value = value;
  }

  void setOtherType(String value) {
    otherTypeText.value = value;
  }

  void setDirection(String value) {
    directionText.value = value;
  }

  void setRoad(String value) {
    roadText.value = value;
  }

  // Method to get the user's current location
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return; // Location services are not enabled
    }

    // Check for permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return; // Permissions are denied
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return; // Permissions are permanently denied
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition();
    lastMapPosition = LatLng(position.latitude, position.longitude);

    // Set initial position to the current location
    initialPosition = CameraPosition(
      target: lastMapPosition!,
      zoom: 14.4746,
    );

    // Move the map to the current location
    final GoogleMapController googleMapController = await mapController.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(initialPosition),
    );
  }

  // Fetch address based on latitude and longitude
  Future<void> getAddressFromLatLng(double? latitude, double? longitude) async {
    if (latitude == null || longitude == null) return;

    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    fullAddress.value = '${placemarks.first.subThoroughfare}'
        ' ${placemarks.first.subLocality},'
        ' ${placemarks.first.locality},'
        ' ${placemarks.first.administrativeArea} '
        '${placemarks.first.postalCode},'
        ' ${placemarks.first.country}';
    print("sgdhfhfjf${placemarks.first.thoroughfare}");
    street.value = placemarks.first.street ?? 'Unknown';
    postalCode.value = placemarks.first.postalCode ?? 'Unknown';
    locality.value = placemarks.first.locality ?? 'Unknown';
    country.value = placemarks.first.country ?? 'Unknown';
    name.value = placemarks.first.name ?? 'Unknown';
    subThoroughfare.value = placemarks.first.subThoroughfare ?? 'Unknown';
    thoroughfare.value = placemarks.first.thoroughfare ?? 'Unknown';
    subLocality.value = placemarks.first.subLocality ?? 'Unknown';
    administrativeArea.value = placemarks.first.administrativeArea ?? 'Unknown';
  }

  Future<BitmapDescriptor> createCustomMarkerBitmap(GlobalKey key) async {
    RenderRepaintBoundary boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(pngBytes);
  }

  Future<void> addAddresses(context) async {
    if (customerHouseNocontroller.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Your House No!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
    // if (customerCitycontroller.value.text.isEmpty) {
    //   Fluttertoast.showToast(
    //     msg: "Please enter  Mobile Number!",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.black,
    //     textColor: Colors.white,
    //   );
    //   return;
    // }
    // if (customerStatecontroller.value.text.isEmpty) {
    //   Fluttertoast.showToast(
    //     msg: "Please enter Your Address!",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.black,
    //     textColor: Colors.white,
    //   );
    //   return;
    // }
    // if (customerPincodecontroller.value.text.isEmpty) {
    //   Fluttertoast.showToast(
    //     msg: "Please enter Your City!",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.black,
    //     textColor: Colors.white,
    //   );
    //   return;
    // }
    // if (customerCountrycontroller.value.text.isEmpty) {
    //   Fluttertoast.showToast(
    //     msg: "Please enter Your State!",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.black,
    //     textColor: Colors.white,
    //   );
    //   return;
    // }

    Map<String, dynamic> payload = {
      "customerId": AppPreference().UserId.toString(),
      "customerAddress": "${customerHouseNocontroller.text}, ${thoroughfare.value} ,${subLocality.value}" ?? 'Unknown',
      "customerCity": locality.value,
      "customerState": administrativeArea.value,
      "customerPincode": postalCode.value,
      "customerCountry": country.value,
      "isDefault": defaultAddressPayload.toString(),
      "addressType": addressTypePayload.toString(),
      "landmark": customerLandmarkController.text,
      "appartmentName": customerApartmentcontroller.text,
      "mobileNumber": mobileNumberController.text,
    };
    print(payload);
    isLoading.value = true;

    var response = await _connect.addCustomerAddress(payload);

    isLoading.value = false;

    if (!response.error!) {
       MotionToast.success(
        title: const Text("",
            style: TextStyle(color: Colors.black, fontSize: 14)),
        description: Text(response.message ?? "",
            style: TextStyle(color: Colors.white, fontSize: 12)),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60,
        borderRadius: 10,
        displaySideBar: false,
        enableAnimation: false,
      ).show(context);
      // AppSnackBar.success(message: response.message!);
      addController.getCustomerAddress();
      userDataProvider.setAddressType(addressTypePayload);
      Get.to(() => AddNewAddressScreen());
      isDefaultAddress.value = false;
      customerLandmarkController.clear();
      customerHouseNocontroller.clear();
      customerApartmentcontroller.clear();
      mobileNumberController.clear();
    } else {
       MotionToast.success(
        title: const Text("Success",
            style: TextStyle(color: Colors.black, fontSize: 14)),
        description: Text(response.message ?? "",
            style: TextStyle(color: Colors.white, fontSize: 12)),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60,
        borderRadius: 10,
        displaySideBar: false,
        enableAnimation: false,
      ).show(context);
      // AppSnackBar.error(message: response.message!);
    }
  }

  void updateSearchResults(List<AutocompletePrediction> results) {
    searchResults.value = results;
  }

  void clearSearchResults() {
    searchResults.clear();
  }

  void moveToLocation(double lat, double lng) async {
    final controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
  }
}

// Future<void> saveAddress() async {
//   if (houseNoController.value.text.isEmpty) {
//     Fluttertoast.showToast(
//       msg: "Please enter your House/Flat/Block No!",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.black,
//       textColor: Colors.white,
//     );
//     return;
//   }
//   if (addressType.value.isEmpty) {
//     Fluttertoast.showToast(
//       msg: "Please enter your Address Type!",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.black,
//       textColor: Colors.white,
//     );
//     return;
//   }
//
//   var body = {
//     "address_type": addressType.value,
//     "house_no": houseNoText.value,
//     "user_id": "1",
//     "street": street.value,
//     "address_lat": lastMapPosition?.latitude,
//     "address_lng": lastMapPosition?.longitude,
//     "google_address_text": fullAddress.value
//   };
//   try {
//     var data = await _addresslistRepository.saveAddress(body);
//
//     print(data);
//     if (data.status != null && data.status!) {
//       Fluttertoast.showToast(
//         msg: data.message ?? 'Operation successful',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.black,
//         textColor: Colors.white,
//       );
//       if (data.status!) {
//         Get.back();
//         await addressType();
//       }
//     } else {}
//   } catch (e) {
//     Fluttertoast.showToast(
//       msg: "An error occurred: ${e.toString()}",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.black,
//       textColor: Colors.white,
//     );
//   }
// }
