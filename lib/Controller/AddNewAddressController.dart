import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:vkartcustomer/UI/Addresses/addNewAddressScreen.dart';
import 'package:vkartcustomer/utility/AppPreference.dart';
import '../Apiconnect/ApiConnect.dart';
import '../Helper/Helper.dart';
import '../Models/GetCustomerAddressResponseModel.dart';
import '../Provider/ProductProvider.dart';

class AddNewAddressController extends GetxController  with WidgetsBindingObserver{
  var selectedRadioIndex = 0.obs; // Observable for the selected radio button index
  var selectedAddress = GetCustomerAddresses().obs; // Assuming AddressModel is your model class
  RxInt selectedTabIndex = 0.obs;
  late ProductProvider userDataProvider;
  RxString address = RxString("India");
  RxString productCategoryDropdown = RxString('Enter Product Category'.tr);
  final selectedCategory = ''.obs;
  final ApiConnect _connect = Get.put(ApiConnect());
  bool isSelectCall = false;
  bool isCall = false;
  RxInt count = RxInt(0); // Observable integer
  RxList<bool> onClickList = RxList();
  RxBool isClicked = RxBool(false);
  RxList<bool> onClickCounterList = RxList();

  RxBool isLoading = RxBool(false);
  int index = 0;
  RxString pickupMethods = RxString("");
  RxString UpdatePrice = RxString("");
  RxString UpdateTotalPrice = RxString("0");
  RxList<RxInt> counter = RxList<RxInt>([RxInt(1)]);
  int selectedIndex = 0;
  RxInt selectedIndexOne = RxInt(0);

  ///
  RxList<GetCustomerAddresses> getAddressesList = RxList();

  TextEditingController LongitudeController = TextEditingController();
  TextEditingController LatitudeController = TextEditingController();
  TextEditingController PostalCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void onInit() async {
    WidgetsBinding.instance.addObserver(this);
    userDataProvider = ProductProvider();
    super.onInit();

    addressController.text = userDataProvider.getLocation.toString();
    getCustomerAddress();
  }
  

  void initializeDefaultAddress() {
    for (int i = 0; i < getAddressesList.length; i++) {
      if (getAddressesList[i].isDefault == "yes") {
        selectedRadioIndex.value = i; // Set the default index
        selectedAddress.value = getAddressesList[i]; // Set the default address
        break;
      }
    }
  }

  Future<void> getCustomerAddress() async {
    isLoading.value = true;
    Map<String, dynamic> payload = {
      'customerId': AppPreference().UserId.toString(),
    };
    print(payload);

    var response = await _connect.getCustomerAddress(payload);

    print("Delete Api Called ${response.toJson()}");
    if (!response.error!) {
      getAddressesList.value = response.data!;
      Helper.customerAddress!.clear();

      for(int s = 0;s<response.data!.length;s++){
       Helper. customerAddress!.add(response.data![s]);
      }
      initializeDefaultAddress(); 
      update();// Initialize the default address
      for (var address in response.data!) {
        if (address.isDefault == "yes") {
          ProductProvider().setWholeAddress('${address.appartmentName ?? ''}, '
              '1 ${address.customerAddress ?? ''}, '
              '2 ${address.landmark ?? ''}, '
              '3 ${address.customerCity ?? ''}, '
              '4 ${address.customerState ?? ''}, '
              '5 ${address.customerPincode ?? ''}, '
              '6 ${address.customerCountry ?? ''}');
          break; // Exit the loop once the default address is found and set
        }

      }
Future.delayed(Duration(milliseconds: 500),(){
  isLoading.value = false;
});


     
    } else {}
  }

  Future<void> deleteCustomerAddress(int index,context) async {
    Map<String, dynamic> payload = {
      'customerAddressId': getAddressesList[index].customerAddressId,
    };
    print(payload);
    isLoading.value = true;

    try {
      var response = await _connect.deleteCustomerAddresses(payload);
      isLoading.value = false;

      print("Delete API Called ${response.toJson()}");

      if (!response.error!) {
        Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        print('Address deleted successfully');

        // Remove the deleted address
        getAddressesList.removeAt(index);
           getCustomerAddress();
        // Get.to(AddNewAddressScreen());
       
        update();

        // Automatically select the last remaining address, if any
        if (getAddressesList.isNotEmpty) {
          if (getAddressesList.length == 1) {
            // Automatically select the only remaining address
            selectedRadioIndex.value = 0;
            selectedAddress.value = getAddressesList[0];
          } else if (selectedRadioIndex.value == index) {
            // Reset selected index if the deleted address was selected
            selectedRadioIndex.value = 0; // Default to the first address
            selectedAddress.value = getAddressesList[0];
          }
        } else {
          // Reset when no addresses are left
          // selectedRadioIndex.value = -1; // No selection
          // selectedAddress.value = '';
        }

        // Refresh the address list
        getCustomerAddress();
      } else {
        Fluttertoast.showToast(
          msg: "Failed to delete address",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Fluttertoast.showToast(
        msg: "Error occurred: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      print("Error while deleting address: $e");
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;

      // Request high accuracy location
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 10),
      );

      LatitudeController.text = position.latitude.toString();
      LongitudeController.text = position.longitude.toString();

      // Retrieve address details based on coordinates
      List<Placemark> result = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (result.isNotEmpty) {
        Placemark place = result[0];
        address.value = '${place.name}${place.subThoroughfare} ${place.thoroughfare}, '
            '${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, '
            '${place.administrativeArea}, ${place.postalCode}, ${place.country}';
      }

      // Save data using the userDataProvider
      userDataProvider.setLatitude(position.latitude.toString());
      userDataProvider.setLongitude(position.longitude.toString());
      userDataProvider.SetSelectedLocation(address.value);

      // Update Postal Code field
      PostalCodeController.text = userDataProvider.getLocation.toString();
    } catch (e) {
      print("Failed to get location: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
