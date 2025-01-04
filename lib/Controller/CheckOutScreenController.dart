import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import '../Apiconnect/ApiConnect.dart';
import '../Helper/Helper.dart';
import '../Models/GetCartInfoResponseModel.dart';
import '../Models/PlaceOrdeItemResponse.dart';
import '../Models/couponCodeModel/couponCodeResponseModel.dart';
import '../Pojo/GetCartProductResponse.dart';
import '../Provider/ProductProvider.dart';
import '../utility/AppPreference.dart';
import '../utility/BottomNavigationBar.dart';
import 'CartScreenController.dart';
import 'ProductHomeScreenController.dart';

class CheckOutScreenController extends GetxController {
  final ProductHomeScreenController productHomeController = Get.put(ProductHomeScreenController());
  final CartScreenController cartScreenController = Get.put(CartScreenController());

  RxInt selectedTabIndex = 0.obs;
  late RxList<CartData> CartProdct = RxList();
  late RxList<CartData> CartProdctList = RxList();
  late RxList<PlaceOrderItemsResponse> placeOrderItems = RxList();
  TextEditingController LongitudeController = TextEditingController();
  TextEditingController LatitudeController = TextEditingController();
  TextEditingController PostalCodeController = TextEditingController();
  RxString address = RxString("India");
  // DeleteCartResponse deletecartResponse = DeleteCartResponse();
  TextEditingController pickUptimeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController productCategoryController = TextEditingController();
  TextEditingController additionalInputController = TextEditingController();
  TextEditingController couponCodeController = TextEditingController();
  RxString productCategoryDropdown = RxString('Select Payment Method'.tr);
  final selectedCategory = ''.obs;
  final ApiConnect _connect = Get.put(ApiConnect());
  bool isSelectCall = false;
  bool isCall = false;
  RxBool isAdditionalInputEnabled = RxBool(false);
  Data getCartInfos = Data();
  CouponData applyCoupon = CouponData();
  RxInt count = RxInt(0); // Observable integer 
  late ProductProvider userDataProvider;
  RxList<bool> onClickList = RxList();
  RxBool isClicked = RxBool(false);
  RxList<bool> onClickCounterList = RxList();
  RxBool isLoading = RxBool(false);
  RxBool orderType = RxBool(false);
  int index = 0;
  RxString UpdatePrice = RxString("");
  RxString UpdateTotalPrice = RxString("0");

  RxString subTotal = "0".obs;
  RxString totalDiscount = "0".obs;
  RxString deliveryCh = "0".obs;
  RxString orderTotal = "0".obs;

  RxList<RxInt> counter = RxList<RxInt>([RxInt(1)]);
  int selectedIndex = 0;
  RxInt selectedIndexOne = RxInt(0);
  final List<String> categories = [
    'Cash On Delivery',
    'UPI Payment',
  ];
  RxBool isRefreshing = RxBool(false);

// RxList <RxString> UpdatePrice =  RxList<RxString> ([RxString("")]);
  paymentProcess() async {
    for (int i = 0; i < onClickList.length; i++) {
      if (onClickList[i] == true) {
        isClicked.value = true;
        selectedIndex = i;
        break;
      }
    }

    if (isClicked.value == false) {
      Fluttertoast.showToast(
        msg: "Select the Time Slot",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
  }

  void submitOrder() {
    // Add order submission logic here
    print("Order submitted");
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

  @override
  void onInit() async {
    super.onInit();
    userDataProvider = Provider.of<ProductProvider>(Get.context!, listen: false);

    addressController.text = userDataProvider.getLocation.toString();
    GetCartInfo();
/* GetCartApi();*/
  }

  void increment() {
    count++;
  }

  Future<void> GetCartInfo() async {
    Map<String, dynamic> payload = {
      "customerId": AppPreference().UserId,
    };
    print("GetCartInfopayload: ${payload}");

    isLoading.value = true; // Show the loading spinner at the start

    try {
      var response = await _connect.getCartInfo(payload);
      getCartInfos = response.data!;
      Helper.deliveryfees = response.data!.deliveryFee;
      orderTotal.value = ((response.data?.total != null) ? response.data?.total.toString() : "0")!;
      subTotal.value = ((response.data?.subtotal != null) ? response.data?.subtotal.toString() : "0")!;

      print("billing info Response: ${response.toJson()}");
      if (!response.error!) {
        // Fluttertoast.showToast(
        //   msg: response.message!,
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   backgroundColor: Colors.black,
        //   textColor: Colors.white,
        // );
      } else {}
    } catch (e) {
      print("Error occurred: $e");
      Fluttertoast.showToast(
        msg: "An error occurred. Please try again later.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  GetCartPlaceItemsApi(context) async {
    if (productCategoryController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Select a Payment Method",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    if (mobileNumberController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Mobile Number",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    Map<String, dynamic> payload = {
      "customerId": AppPreference().UserId.toString(),
      "paymentGateway": productCategoryController.text,
      "deliveryOption": !isAdditionalInputEnabled.value ? "instant" : "scheduled",
      "orderType": Helper.orderMode,
      "pickupTime": Helper.pickUPTime,
      "contactNumber": mobileNumberController.text,
      "deliveryAddress": Helper.location,
      "promoCode": couponCodeController.text,
    };
    print("${productCategoryController.text}????paymentGateway");
    print("${isAdditionalInputEnabled.value}????deliveryOption");
    print("${Helper.orderMode}????orderType");
     print("${ Helper.pickUPTime}????pickupTime");
      print("${ Helper.location}????deliveryAddress");
        print("${couponCodeController.text}????promoCode");
    print("place order ===>${payload}");

    print("isAdditionalInputEnabled: ${isAdditionalInputEnabled.value}");
    print("userDataProvider.getItNow: ${userDataProvider.getItNow}");
    print("pickUptimeController.text: ${pickUptimeController.text}");

    if (!isAdditionalInputEnabled.value && userDataProvider.getItNow == 1) {
      // Only send pickupTime if orderType is "Instant" and deliveryOption is "pickUp"
      payload["pickupTime"] = pickUptimeController.text;
    }
    print("Payload: $payload");

    isLoading.value = true;
    var response = await _connect.PlaceOrderList(payload);
    isLoading.value = false;

    print("Response: ${response.toJson()}");

    if (!response.error!) {
      // Fluttertoast.showToast(
      //   msg: response.message ?? "Order placed successfully!", // Show response message or default message
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      // );
      pickUptimeController.text = "";
      UpdateTotalPrice.value = "";
      mobileNumberController.text = "";
      couponCodeController.text = "";
      refreshCartData();
      Get.off(() => const navigateBar(initialIndex: 2));
      return false;
    } else {
       MotionToast.error(
        title: const Text("Error",
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
      //   msg: response.message ?? "Something went wrong.",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      // );
    }
  }

  void refreshCartData() {
    if (isRefreshing.value) {
      print("API is already being called, skipping refresh.");
      return; // Skip if the API is already being refreshed
    }

    isRefreshing.value = true;
    // Trigger the refresh of the home screen API
    productHomeController.HomeScreenApi();
    cartScreenController.GetCartApi();

    // After calling the API, reset the refreshing state
    isRefreshing.value = false;
  }

  Future<void> ApplyCouponCode() async {
    if (couponCodeController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Promo Code!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    Map<String, dynamic> payload = {
      "customerId": AppPreference().UserId,
      "promoCode": couponCodeController.text,
    };
    print("GetCartInfopayload: $payload");

    isLoading.value = true;
    try {
      var response = await _connect.ApplyCouponCode(payload);
      applyCoupon = response.data!;

      final updatedOrderPrices = getCartInfos;
      var updatedOrderTotal = orderTotal.value;
      var updatedSubTotal = subTotal.value;

      updatedOrderPrices.total = response.data?.total ?? updatedOrderTotal;
      updatedOrderPrices.subtotal = response.data?.subtotal ?? updatedSubTotal;

      getCartInfos = updatedOrderPrices;
      orderTotal.value = updatedOrderTotal;
      subTotal.value = updatedSubTotal;

      print("Response: ${response.toJson()}");
      Fluttertoast.showToast(
        msg: response.message ?? "Unknown response message.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } catch (e) {
      print("Error occurred: $e");
      Fluttertoast.showToast(
        msg: "The given code is already used.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } finally {
      isLoading.value = false; // Hide the loading spinner at the end
    }
  }

/*GetCartPlaceItemsApi(context) async {
    List<Map<String, dynamic>> ballonMakingJsonList = placeOrderItems.map((item) => item.toJson()).toList();
    String BallonMarking = jsonEncode(ballonMakingJsonList);

    placeOrderItems.clear();
    for (int i = 0; i < CartProdct.length; i++) {
      PlaceOrderItemsResponse placeItems = PlaceOrderItemsResponse();
      placeItems.productName = CartProdct[index].productName.toString();
      placeItems.productId = CartProdct[index].productId.toString();
      placeItems.productPrice = CartProdct[index].productPrice.toString();
      placeItems.productQty = CartProdct[index].productQty.toString();
      placeItems.orderedQty = counter[index].toString();
      placeOrderItems.add(placeItems);

      String productPrice = CartProdct[i].productPrice.toString();
      String updatePrice = UpdateTotalPrice.value;
      int num1 = int.parse(productPrice);
      int num2 = int.parse(updatePrice);
      int result = num1 + num2;
      UpdateTotalPrice.value = result.toString();
      print(" Total price : ${UpdateTotalPrice.value}");
    }
    print("placeOrderItems ${json.encode(placeOrderItems)}");

    Map<String, dynamic> payload = {
      "items": json.encode(placeOrderItems),
      "sellerId": CartProdct[0].sellerId,
      "customerId": AppPreference().UserId.toString(),
      "firstPromoOffer": "",
      "totalOrderCost": UpdateTotalPrice.value,
      "paymentOption": productCategoryController.text,
      "pickupTime": AppPreference().pickup == "PickUp" ? pickUptimeController.text : "0",
      "deliveryFee": "30",
      "deliveryOption": pickupMethods.value,
      "deliveryTime": "",
      "deliveryMobileNo": mobileNumberController.text
    };
    print("PlaceOrderpayload${payload}");
    isLoading.value = true;
    var response = await _connect.PlaceOrderList(payload);
    isLoading.value = false;

    print("Response${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      pickUptimeController.text = "";
      UpdateTotalPrice.value.isEmpty;
      pickupMethods.value.isEmpty;
      mobileNumberController.text = "";
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => navigateBar()),
      // );
    }
  }*/

/*  GetCartApi() async {
    Map<String, dynamic> payload = {
      'userId': AppPreference().UserId,
      'productId': "",
    };
    print(payload);
    isLoading.value = true;
    var response = await _connect.GetCart(payload);

    print("CartScreen${response.toJson()}");
    onClickList.clear();
    counter.clear();
    if (!response.error!) {
      print('check cart api');
      CartProdct.value = response.data!;
      debugPrint("getAttendanceList: ${response.toJson()}");
      for (int i = 0; i < response.data!.length; i++) {
        counter.add(RxInt(1));
        update();
      }
    } else {}
    isLoading.value = false;
  }



  DeleteCartApi() async {
    Map<String, dynamic> payload = {
      'userId': AppPreference().UserId,
      'productId': CartProdct.value[index].productId, // Assuming id is the correct field
    };
    print("Deleting product: $payload");
    var response = await _connect.DeleteCart(payload);
    print("Delete API Called: ${response.toJson()}");
    if (response.error != true) {
      Fluttertoast.showToast(
        msg: response.message ?? "Product deleted successfully.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      print('Product deleted successfully. Checking cart again.');
      // Refresh the cart items after deletion
      GetCartApi(); // Call to refresh the cart
    } else {
      // Show error message if the deletion fails
      AppSnackBar.error(message: response.message ?? "Error deleting product.");
    }
  }*/

  /*void incrementCounter(int index) {
    isLoading.value = true;
    if (index >= 0 && index < counter.length) {
      counter[index].value++;
    }
    int price = int.tryParse(CartProdct[index].actualPrice ?? '0') ?? 0;
    print("gkg${CartProdct[index].actualPrice}");
    int result = price * counter[index].value;
    UpdatePrice.value = result.toString();
    CartProdct[index].productPrice = UpdatePrice.value;

    log(json.encode(CartProdct));

    isLoading.value = false;
  }

  void updatePrice(int index) {
    if (index >= 0 && index < CartProdct.length && index < counter.length) {}
  }

  void decrementCounter(int index) {
    isLoading.value = true;

    if (index >= 0 && index < counter.length && counter[index].value > 1) {
      counter[index].value--;
    }
    int price = int.tryParse(CartProdct[index].actualPrice ?? '0') ?? 0;
    int result = price * counter[index].value;
    UpdatePrice.value = result.toString();
    CartProdct[index].productPrice = UpdatePrice.value;

    log(json.encode(CartProdct));

    isLoading.value = false;
  }
*/
}
