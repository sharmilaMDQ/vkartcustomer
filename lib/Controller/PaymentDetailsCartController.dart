import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

import '../Apiconnect/ApiConnect.dart';
import '../Models/PaymentDetailsCartModel.dart';
import '../Provider/ProductProvider.dart';
import '../utility/AppPreference.dart';

class PaymentDetailsCartController extends GetxController {
  PaymentCart? paymentDetails;
  RxBool isLoading = RxBool(false);
  // DeleteCartResponse deletecartResponse = DeleteCartResponse();
  TextEditingController pickUptimeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController productCategoryController = TextEditingController();
  RxString productCategoryDropdown = RxString('Enter Product Category'.tr);
  final selectedCategory = ''.obs;
  final ApiConnect _connect = Get.put(ApiConnect());
  bool isSelectCall = false;
  bool isCall = false;
  RxInt count = RxInt(0); // Observable integer
  late ProductProvider userDataProvider;
  RxList<bool> onClickList = RxList();
  RxBool isClicked = RxBool(false);
  RxList<bool> onClickCounterList = RxList();
  int index = 0;
  RxString pickupMethods = RxString("");
  RxString UpdatePrice = RxString("");
  RxString UpdateTotalPrice = RxString("0");
  RxList<RxInt> counter = RxList<RxInt>([RxInt(1)]);
  int selectedIndex = 0;
  RxInt selectedIndexOne = RxInt(0);
  final List<String> categories = [
    'Cash On Delivery',
    'Net Banking',
    'UPI Payment',
  ];

// RxList <RxString> UpdatePrice =  RxList<RxString> ([RxString("")]);
  paymentProcess(context) async {
    for (int i = 0; i < onClickList.length; i++) {
      if (onClickList[i] == true) {
        isClicked.value = true;
        selectedIndex = i;
        break;
      }
    }

    if (isClicked.value == false) {
       MotionToast.success(
        title: const Text("",
            style: TextStyle(color: Colors.black, fontSize: 14)),
        description: Text('Select the Time Slot' ?? "",
            style: TextStyle(color: Colors.white, fontSize: 12)),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60,
        borderRadius: 10,
        displaySideBar: false,
        enableAnimation: false,
      ).show(context);
      // Fluttertoast.showToast(
      //   msg: "Select the Time Slot",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      // );
      return;
    }
  }

  getPaymentDetailsCart(context) async {
    Map<String, dynamic> payload = {
      'userId': AppPreference().UserId,
    };

    print("Deleting product: $payload");

    // Call the delete API
    isLoading.value = true;
    var response = await _connect.DeleteCart(payload);
    isLoading.value = false;
    print(" API Called: ${response.toJson()}");

    // Check for errors in the response
    if (response.error != true) {
      
    }
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
    // Fluttertoast.showToast(
    //   msg: response.message ?? "Product deleted successfully.",
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   backgroundColor: Colors.black,
    //   textColor: Colors.white,
    // );
    print('Product deleted successfully. Checking cart again.');
  }

  @override
  void onInit() async {
    super.onInit();
    userDataProvider = Provider.of<ProductProvider>(Get.context!, listen: false);
    addressController.text = userDataProvider.getLocation.toString();
  }

  void increment() {
    count++;
  }
}
