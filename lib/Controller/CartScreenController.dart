import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:vkartcustomer/Helper/Helper.dart';
import '../Apiconnect/ApiConnect.dart';
import '../Forms/AppSnackBar.dart';
import '../Models/PlaceOrdeItemResponse.dart';
import '../Pojo/GetCartProductResponse.dart';
import '../Provider/ProductProvider.dart';
import '../utility/AppPreference.dart';
import '../utility/BottomNavigationBar.dart';
import 'ProductHomeScreenController.dart';

class CartScreenController extends GetxController {
  final ProductHomeScreenController productHomeController = Get.put(ProductHomeScreenController());

  RxInt selectedTabIndex = 0.obs;
  RxList<CartData> CartProdct = RxList();
  RxList<GetCartResponse> CartProdcts = RxList();
  RxString total = "0".obs;
  RxString amountSaved = "0".obs;

  RxInt selectedButton = 1.obs; // 1 = first button, 2 = second button
  RxString checkOut = RxString("Checkout");
  RxString selectSlot = RxString("Select a Slot");
  RxString address = RxString("");

  RxString cartTotal = RxString("");
  late RxList<PlaceOrderItemsResponse> placeOrderItems = RxList();
  RxList<RxInt> productPriceDuplicate = RxList<RxInt>();
  // Rx<GetCartResponse?> cartResponse = Rx<GetCartResponse?>(null);
  // DeleteCartResponse deletecartResponse = DeleteCartResponse();

  RxList<String> updateProductIds = RxList<String>();
  RxList<String> updatePrices = RxList<String>();
  RxList<int> countersList = RxList<int>();
  TextEditingController pickUptimeController = TextEditingController();

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
  RxBool isRefreshing = RxBool(false);
  RxBool isAddressSelected = RxBool(false);
  RxList<bool> onClickCounterList = RxList();
  RxBool isLoading = RxBool(false);
  RxBool cartProductLoading = RxBool(false);
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

   Future<void> refreshData() async {
    GetCartApi();
    return Future.delayed(Duration(seconds: 0));
  }

  @override
  void onInit() {
    super.onInit();
    print("CART SCREEN ENTERED");
    userDataProvider = Provider.of<ProductProvider>(Get.context!, listen: false);
    address.value = userDataProvider.getLocation.toString();
    GetCartApi();
    userDataProvider.setGetItNow(selectedButton.value = 1);

    // initializeCartPrices();
  }

  // void updateCartTotal(int index) {
  //   if (index < CartProdcts.length) {
  //     cartTotal.value = CartProdcts[index].total.toString();
  //   } else {
  //     cartTotal.value = "0";
  //   }
  // }

  void refreshCartData() {
    if (isRefreshing.value) {
      print("API is already being called, skipping refresh.");
      return; // Skip if the API is already being refreshed
    }

    isRefreshing.value = true;
    // Trigger the refresh of the home screen API
    productHomeController.HomeScreenApi();
    // GetCartApi();

    // After calling the API, reset the refreshing state
    isRefreshing.value = false;
  }

  ///
  var isLoadingMap = <int, bool>{}.obs;

  void setLoading(int index, bool value) {
    isLoadingMap[index] = value;
  }

  bool getLoading(int index) {
    return isLoadingMap[index] ?? false;
  }

  ///

  // void initializeCartPrices() {
  //   for (int i = 0; i < CartProdct.length; i++) {
  //     int price = int.tryParse(CartProdct[i].productPriceDuplicate ?? '0') ?? 0;
  //     int quantity = CartProdct[i].cartQty ?? 1;
  //     int totalItemPrice = price * quantity;
  //
  //     CartProdct[i].productPrice = totalItemPrice.toString();
  //   }
  //
  //   // Optionally, calculate the total price for all items
  //   calculateTotalPrice();
  // }
  //
  // void calculateTotalPrice() {
  //   int total = 0;
  //
  //   for (int i = 0; i < CartProdct.length; i++) {
  //     int itemPrice = int.tryParse(CartProdct[i].productPriceDuplicate ?? '0') ?? 0;
  //     total += itemPrice;
  //   }
  //
  //   UpdateTotalPrice.value = total.toString();
  //   print("Total price for all items: ${UpdateTotalPrice.value}");
  // }

  /*void incrementCounter(int index) {
    isLoading.value = true;
    if (index >= 0 && index < CartProdct.length) {
      // Increment the quantity
      CartProdct[index].cartQty = (CartProdct[index].cartQty ?? 0) + 1;

      // Calculate the price for the updated quantity
      int price = int.tryParse(CartProdct[index].productPriceDuplicate ?? '0') ?? 0;
      num result = price * CartProdct[index].cartQty!;
      CartProdct[index].productPrice = result.toString();

      // Update the total price for all products
      calculateTotalPrice();
    }
    isLoading.value = false;
  }*/

  Future<void> incrementCounter(BuildContext outerContext, int index) async {
    // Ensure lists are large enough to hold values for each product
    while (updateProductIds.length <= index) {
      updateProductIds.add("");
      updatePrices.add("");
      countersList.add(0);
    }

    print("incrementCounter called for index $index with initial value: ${CartProdct[index].cartQty}");

    // Update the cart quantity and counter if valid index
    if (index >= 0 && index < counter.length) {
      int currentQty = CartProdct[index].cartQty ?? 0;
      currentQty++;
      CartProdct[index].cartQty = currentQty;
      counter[index].value = currentQty;
      countersList[index] = currentQty;
    }

    print("Counter updated for index $index, new value: ${counter[index].value}");

    // Fetch product price and update it
    double price = 0.0;
    String? discountPrice = CartProdct[index].productDiscountPrice;
    String? priceDuplicate = CartProdct[index].productPriceDuplicate.toString();

    if (discountPrice != null && discountPrice.isNotEmpty) {
      price = double.tryParse(discountPrice) ?? 0.0;
    } else {
      price = double.tryParse(priceDuplicate ?? '') ?? 0.0;
    }

    double updatedProductPrice = price * CartProdct[index].cartQty!;
    updatePrices[index] = updatedProductPrice.toStringAsFixed(2);
   // CartProdct[index].productPrice = double.parse(updatePrices[index]);
    updateProductIds[index] = CartProdct[index].productId.toString();

    // Recalculate the total price after increment
    calculateTotalPrice();

    // Update the cart
    await _updateCart(outerContext, index: index, showLoading: false, isIncrement: true);
  }

  _addPriceToTotal(int index, int price) {
    // Get the existing total price before any updates
    double currentTotalPrice = double.tryParse(UpdateTotalPrice.value) ?? 0.0;

    // Add the price of the product to the total price
    currentTotalPrice += price;

    // Update the total price value with the new total
    UpdateTotalPrice.value = currentTotalPrice.toString();

    print("Updated Total price: ${UpdateTotalPrice.value}");
  }

  Future<void> decrementCounter(BuildContext outerContext, int index) async {
    // Ensure lists are large enough to hold values for each product
    while (updateProductIds.length <= index) {
      updateProductIds.add("");
      updatePrices.add("");
      countersList.add(0);
    }

    if (index >= 0 && index < CartProdct.length && (CartProdct[index].cartQty ?? 1) > 1) {
      int currentQty = CartProdct[index].cartQty ?? 1;
      double price = 0.0;
      String? discountPrice = CartProdct[index].productDiscountPrice;
      String? priceDuplicate = CartProdct[index].productPriceDuplicate.toString();

      if (discountPrice != null && discountPrice.isNotEmpty) {
        price = double.tryParse(discountPrice) ?? 0.0;
      } else {
        price = double.tryParse(priceDuplicate ?? '') ?? 0.0;
      }

      CartProdct[index].cartQty = currentQty - 1;
      counter[index].value = CartProdct[index].cartQty!;
      countersList[index] = CartProdct[index].cartQty!;

      double updatedPrice = price * CartProdct[index].cartQty!;
      updatePrices[index] = updatedPrice.toStringAsFixed(2);
    //  CartProdct[index].productPrice = CartProdct[index].productPrice = double.tryParse(updatePrices[index]) ?? null;
      updateProductIds[index] = CartProdct[index].productId.toString();

      // Recalculate the total price after decrement
      calculateTotalPrice();

      await _updateCart(outerContext, index: index, showLoading: false, isIncrement: false);
    }
  }

  void _subtractPriceFromTotal(int index, int price) {
    // Get the current total price before any updates, ensuring it is parsed as a double
    double currentTotalPrice = double.tryParse(UpdateTotalPrice.value) ?? 0.0;

    // Subtract the price of the product (as a double) from the total price
    currentTotalPrice -= price;

    // Update the total price value with the new total, formatted as a string
    UpdateTotalPrice.value = currentTotalPrice.toString();

    print("Updated Total price: ${UpdateTotalPrice.value}");
  }

  void calculateTotalPrice() {
    double total = 0.0;

    for (int index = 0; index < CartProdct.length; index++) {
      double unitPrice = 0.0;
      String? discountPrice = CartProdct[index].productDiscountPrice;
      String? priceDuplicate = CartProdct[index].productPriceDuplicate.toString();

      if (discountPrice != null && discountPrice.isNotEmpty) {
        unitPrice = double.tryParse(discountPrice) ?? 0.0;
      } else {
        unitPrice = double.tryParse(priceDuplicate ?? '') ?? 0.0;
      }

      int quantity = CartProdct[index].cartQty ?? 1;
      total += unitPrice * quantity;
      print("Product at index $index, Unit Price: $unitPrice, Quantity: $quantity, Total for this product: ${unitPrice * quantity}");
    }

    UpdateTotalPrice.value = total.toStringAsFixed(2);
    print("Total price for all products: ${UpdateTotalPrice.value}");
  }

//   Future<void> _updateCart(BuildContext outerContext,
//       {required int index, bool isConfirmed = false, bool showLoading = true, required bool isIncrement}) async {
//     Map<String, dynamic> payload = {
//       'customerId': AppPreference().UserId,
//       'productId': updateProductIds[index],
//       'qty': countersList[index],
//     };
//
//     /*if (isConfirmed) {
//       payload['isConfirmed'] = "Confirmed";
//     }
// */
//     if (showLoading) {
//       isLoading.value = true;
//     }
//     print("Payload: $payload");
//
//     var response = await _connect.AddCart(payload);
//     if (showLoading) {
//       isLoading.value = false;
//     }
//     print("Response: ${response}");
//     // No mismatch; item added to cart successfully
//     Fluttertoast.showToast(
//       msg: response.message ?? "Item added to cart",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.black,
//       textColor: Colors.white,
//     );
//     update(); // Update the UI after successful addition
//   }

  Future<void> _updateCart(BuildContext outerContext, {
    required int index, 
    bool isConfirmed = false, 
    bool showLoading = true, 
    required bool isIncrement,}) async {
    Map<String, dynamic> payload = {
      'customerId': AppPreference().UserId,
      'productId': updateProductIds[index],
      'qty': countersList[index],
    };

    if (showLoading) {
      isLoading.value = true;
    }
    print("Payload: $payload");

    var response = await _connect.AddCart(payload);

    if (showLoading) {
      isLoading.value = false;
    }

    if (response != null) {
      final updatedCart = CartProdct[index];
      var updatedCarts = total.value;
      var updatedCarts2 = amountSaved.value;

      updatedCart.actualPrice = double.tryParse(response.actualPrice) ?? updatedCart.actualPrice;
      updatedCarts = response.total.toString() ?? updatedCarts;
      updatedCarts2 = response.discount.toString() ?? updatedCarts2;

      CartProdct[index] = updatedCart;
      total.value = updatedCarts;
      amountSaved.value = updatedCarts2;

      // Fluttertoast.showToast(
      //   msg: response.message ?? "Item added to cart",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      // );
    } else {
      // Fluttertoast.showToast(
      //   msg: response.message ?? "Failed to update cart",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      // );
    }
  }

  void updatePrice(int index) {
    if (index >= 0 && index < CartProdct.length && index < counter.length) {}
  }

  void increment() {
    count++;
  }

 Future<void> GetCartApi() async {
  Map<String, dynamic> payload = {
    'customerId': AppPreference().UserId,
    'productId': "",
  };
  print(payload);
  cartProductLoading.value = true;
  var response = await _connect.GetCart(payload);

  print("CartScreen${response.toJson()}");
  onClickList.clear();
  counter.clear();
  
  if (!response.error!) {
    print('check cart api');
    CartProdct.value = response.data!;
    
    // Ensure the values are properly converted to strings
  total.value = (response.total != null)
    ? response.total!.toString() 
    : "0.00";
 //ormat the total value to 2 decimal places
    amountSaved.value = (response.discount != null) ? response.discount!.toString(): "0.00"; // Format the discount value to 2 decimal places
    
    productPriceDuplicate.clear();
    
    // Handle productPrice as double and add to productPriceDuplicate as an int
    for (var data in response.data!) {
      productPriceDuplicate.add(RxInt((data.productPrice?.toInt()) ?? 0)); // Convert double to int safely
    }
    
    debugPrint("getAttesrghrndanceList: ${response.toJson()}");
    
    for (int i = 0; i < response.data!.length; i++) {
      counter.add(RxInt(1)); // Initialize counter for each product
      calculateTotalPrice(); // Calculate the total price
      update(); // Update the UI
    }
  } else {
    print("ISSUE FACING IN CART API");
  }
  
  cartProductLoading.value = false;
}


  GetCartPlaceItemsApi(context) async {
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
      "deliveryFee": Helper.deliveryfees,
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
      //   msg: response.message!,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      // );
      pickUptimeController.text = "";
      UpdateTotalPrice.value.isEmpty;
      pickupMethods.value.isEmpty;
      mobileNumberController.text = "";
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => navigateBar(
                  initialIndex: 0,
                )),
      );
    }
  }

  DeleteCartApi(int index,context) async {
    // Ensure the index is valid before attempting to access CartProdct
    // if (index < 0 || index >= CartProdct.length) {
    //   Fluttertoast.showToast(
    //     msg: "Invalid product index.",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //   );
    //   return; // Exit early if the index is invalid
    // }

    // Prepare the payload for the delete API call
    Map<String, dynamic> payload = {
      'userId': AppPreference().UserId,
      'productId': CartProdct[index].productId, // Assuming id is the correct field
    };

    print("Deleting product: $payload");

    // Call the delete API
    var response = await _connect.DeleteCart(payload);
    print("Delete API Called: ${response.toJson()}");

    // Check for errors in the response
    if (response.error != true) {
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

      // Refresh the cart items after deletion
      GetCartApi(); // Call to refresh the cart
    } else {
      // Show error message if the deletion fails
      AppSnackBar.error(message: response.message ?? "Error deleting product.");
    }
  }

  updateCartQuantities() async {
    // Create payload after storing the response
    Map<String, dynamic> requestPayload = createPayload();

    if (requestPayload.isNotEmpty) {
      // Send the payload to updateCartQuantities only if it's not empty
      await _connect.updateCartQuantities(requestPayload);
    } else {
      print("Request Payload is empty, skipping API call.");
    }
  }

  Map<String, dynamic> createPayload() {
    Map<String, dynamic> payload = {"customerId": int.parse(AppPreference().UserId), "quantities": {}};

    // Check if CartProdct has data
    if (CartProdct.value != null) {
      for (CartData item in CartProdct.value!) {
        if (item.cartId != null && item.cartQty != null) {
          // Add each cart item to the cartItems map with cartId as key and cartQty as value
          payload["quantities"][item.cartId.toString()] = item.cartQty as int;
        } else {
          print("Skipped item with null cartId or cartQty: ${item.toJson()}");
        }
      }
    } else {
      print("CartProdct is null or empty");
    }
    print("Final payload: ${jsonEncode(payload)}");
    return payload;
  }
}
