import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:motion_toast/motion_toast.dart';

import '../ApiConfig/service/offers/offers_clicked_api_service.dart';
import '../ApiConfig/service/offers/offers_list_api_service.dart';
import '../Apiconnect/ApiConnect.dart';
import '../Helper/Helper.dart';
import '../Models/ParticularCustomerResponseModel.dart';
import '../Models/SearchProductsResponse.dart';
import '../Models/offerslist_model/offers_click_model.dart';
import '../Models/offerslist_model/offers_list_model.dart';
import '../Pojo/ProductHomeScreenResponse.dart';
import '../Provider/ProductProvider.dart';
import '../utility/AppPreference.dart';
import 'offers_list_controller.dart';

class ProductHomeScreenController extends GetxController with WidgetsBindingObserver {
  RxBool isVisible = false.obs;
  RxBool arrowIsVisible = false.obs;
  late ProductProvider userDataProvider;
  RxString ImageUrl = RxString('');
  RxInt count = RxInt(0);

  RxList<RxInt> productPriceDuplicate = RxList<RxInt>();
  var actualPrice = 0.0.obs;

  int index = 0;
  int selectedIndex = 0;
  final ScrollController scrollController = ScrollController();

  ParticularCustomerResponseData? getParticularCustomer;
  RxString customerName = RxString("");
  RxList<bool> loadingStates = RxList<bool>.filled(10, false); // Assume 10 items for this example
  final ApiConnect _connect = Get.put(ApiConnect());
  bool ishomeCall = false;
  RxBool isVisible1 = false.obs;
  RxBool arrowIsVisible1 = false.obs;

  RxBool isVisible2 = false.obs;
  RxBool arrowIsVisible2 = false.obs;

  RxBool isVisible3 = false.obs;
  RxBool arrowIsVisible3 = false.obs;

  RxBool isVisible4 = false.obs;
  RxBool arrowIsVisible4 = false.obs;

  RxBool isVisible5 = false.obs;
  RxBool arrowIsVisible5 = false.obs;
  bool isCall = false;
  TextEditingController searchController = TextEditingController();
  RxString UpdatePrice = RxString("");
  RxString UpdateProductId = RxString("");
  RxString UpdateTotalPrice = RxString("0");
  RxString sameSeller = RxString("0");
  RxList<String> updateProductIds = RxList<String>();
  RxList<String> updatePrices = RxList<String>();
  RxList<int> countersList = RxList<int>();

  // RxString productPriceOriginal = RxString("0");
  RxList<Data> productPriceOriginal = RxList();
 RxList<RxInt> counter = RxList<RxInt>([RxInt(0)]);

  final offersController = Get.find<OffersListController>();
  // List<bool> isLoadings = List.filled(counter.length, false);

  RxInt selectedIndexx = RxInt(0);
  RxInt selectedIndexOne = RxInt(0);

  int selectedProduct = 0;

  late RxList<Data> product = RxList();
  late RxList<SearchProductsResponseData> searchproduct = RxList();

  // late RxList<CartData> product = RxList();
  RxList<bool> onClickList = RxList();
  RxBool initialLoading = RxBool(false);
  RxBool isLoading = RxBool(true);
  RxBool isSearch = RxBool(false);
  RxBool isSearchVisible = RxBool(false);
  RxBool isClicked = RxBool(false);

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
    arrowIsVisible.value = !arrowIsVisible.value;
  }
  Future<void> refreshData() async {
    HomeScreenApi();
    return Future.delayed(Duration(seconds: 0));
  }

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    // if (isCall) {
    //   isCall = true;
    userDataProvider = ProductProvider();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      HomeScreenApi();
    });
    getParticularCustomerApi();
    resetCounter();
    toggleVisibility1();
    toggleVisibility2();
    toggleVisibility4();
    toggleVisibility5();
    toggleVisibilityColor();
    paymentProcess();
    _fetchPriceFromApi();
    SearchProductApi();

    update();
    // }
  }
  
  //  Future<void> refreshData() async {
  //   HomeScreenApi();
  //   return Future.delayed(Duration(seconds: 0));
  // }
 
  void resetCounter() {
    for (var i = 0; i < counter.length; i++) {
      counter[i].value = 0; // Reset each counter to 0
    }
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
  void toggleVisibility1() {
    isVisible1.value = !isVisible1.value;
    arrowIsVisible1.value = !arrowIsVisible1.value;
  }

  void toggleVisibility2() {
    isVisible2.value = !isVisible2.value;
    arrowIsVisible2.value = !arrowIsVisible2.value;
  }

  void toggleVisibility3() {
    isVisible3.value = !isVisible3.value;
    arrowIsVisible3.value = !arrowIsVisible3.value;
  }

  void toggleVisibility4() {
    isVisible4.value = !isVisible4.value;
    arrowIsVisible4.value = !arrowIsVisible4.value;
  }

  void toggleVisibility5() {
    isVisible5.value = !isVisible5.value;
    arrowIsVisible5.value = !arrowIsVisible5.value;
  }

  RxBool isVisibleColor = true.obs;

  void toggleVisibilityColor() {
    isVisibleColor.value = !isVisibleColor.value;
  }

  paymentProcess() async {
    for (int i = 0; i < onClickList.length; i++) {
      if (onClickList[i] == true) {
        isClicked.value = true;
        selectedIndex = i;
        break;
      }
    }

    if (isClicked.value == false) {
      
     
      return;
    }
  }

  @override
  void didChangeMetrics() {
    isSearch.value = WidgetsBinding.instance.window.viewInsets.bottom > 0;
    update();
    print('VISIBLE');
  }



HomeScreenApi() async {
  Map<String, dynamic> payload = {
    "customerId": AppPreference().UserId,
    'latitude': "", // userDataProvider.getLatitude.toString(),
    'longitude': "", // userDataProvider.getLongitude.toString(),
  };

  print("ProductPayload: $payload");
 // initialLoading.value = true;

  try {
    var response = await _connect.HomeScreen(payload);

    print('HomeScreen_Response: ${response.toJson()}');
    onClickList.clear();
    counter.clear();

    if (response.error == false || response.error == null) {
      // Assign product data
      product.value = response.data ?? [];
      selectedProduct = product.isNotEmpty ? product[index].productId ?? 0 : 0;
      print("Selected Product ID: $selectedProduct");

      // Update user data provider
      userDataProvider.SetProduct(product[index]);
      productPriceOriginal.value = response.data ?? [];
      productPriceDuplicate.clear();

      // Process product IDs and prices
      for (var item in product) {
        print("Product ID: ${item.productId}");
      }

      for (var data in response.data ?? []) {
        // Handle dynamic type for productPrice
        int parsedPrice = int.tryParse(data.productPrice?.toString() ?? "0") ?? 0;
        productPriceDuplicate.add(RxInt(parsedPrice));
      }

      print("Product Prices (Duplicate): $productPriceDuplicate");
      print("Original Product Price: ${response.data![index].productPrice?.toString() ?? "N/A"}");
      print("Index: $index, Product Price: ${response.data![index].productPrice}");

      // Set product list in the user data provider
      userDataProvider.SetProductList(response.data ?? []);

      // Initialize counters
      for (int i = 0; i < response.data!.length; i++) {
        counter.add(RxInt(0));
        update();
      }
    } else {
      print("Error in API response: ${response.message}");
    }
  } catch (e) {
    print("Exception in HomeScreenApi: $e");
  } finally {
   // initialLoading.value = false;
  }
}

Future<void> incrementCounter(BuildContext outerContext, int index) async {
    print("INDEX ==>${index}");
  if (index < 0 || index >= product.length) {
    print("Invalid product index: $index");
    return;
  }

  try {
    // Ensure lists can accommodate the index
    while (updateProductIds.length <= index) {
      updateProductIds.add("");
      updatePrices.add("");
      countersList.add(0);
    }
    update();

    print("IncrementCounter for product: ${product[index].productName}");

    // Update cart quantity
    int currentQty = Helper.offerState == true ? Helper.offerData![index].cartQuantity :product[index].cartQuantity ?? 0;
    currentQty++;
    if(Helper.offerState == true){
      Helper.offerData![index].cartQuantity = currentQty;
    }else{
      product[index].cartQuantity = currentQty;
    }

    counter[index].value = currentQty;

    if(Helper.offerState == true){

      Helper.offerData![index].actualPrice = (int.parse(double.parse(Helper.offerData![index].productPrice).round().toString()) * counter[index].value).toString();

    }
    countersList[index] = currentQty;
    update(["offer"]);

    // Calculate price

    if(Helper.offerState == true){
      double price = double.tryParse(Helper.offerData![index].productDiscountPrice  ?? '0') ?? 0.0;
      double updatedPrice = price * currentQty;
      updatePrices[index] = updatedPrice.toStringAsFixed(2);
      updateProductIds[index] = product[index].productId.toString();
    }else{
      double price = double.tryParse(product[index].productDiscountPrice ?? product[index].productPriceDuplicate ?? '0') ?? 0.0;
    double updatedPrice = price * currentQty;
    updatePrices[index] = updatedPrice.toStringAsFixed(2);
    updateProductIds[index] = product[index].productId.toString();
  }

    //double price = double.tryParse(product[index].productDiscountPrice ?? product[index].productPriceDuplicate ?? '0') ?? 0.0;

   // product[index].productPrice = updatePrices[index].toString();
    update();
    if(Helper.offerState == true){
      offersController.update();
    }



    // API call
    final response = await AddCart(outerContext, index: index, showLoading: false, isIncrement: true);
    // print("API Response: ${response.}");

    Fluttertoast.showToast(
      msg: "Item Updated...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  } catch (e) {
    print("Error in incrementCounter: ${e.toString()}");
  } finally {
    isLoading.value = false;
    update();
  }
}






Future<void> decrementCounter(BuildContext outerContext, int index) async {
  try {
    if (updateProductIds.length <= index) {
      updateProductIds.addAll(List.filled(index + 1 - updateProductIds.length, ""));
      updatePrices.addAll(List.filled(index + 1 - updatePrices.length, ""));
      countersList.addAll(List.filled(index + 1 - countersList.length, 0)); // Initialize to 0
    }

    if (index >= 0 && index < counter.length) {
      // Ensure cartQuantity is an integer

      dynamic currentQty = 0;

      if(Helper.offerState ==true){
        currentQty = (Helper.offerData![index].cartQuantity ?? 0).toInt();
        currentQty--;
      
      }else{
         currentQty = (product[index].cartQuantity ?? 0).toInt();
        currentQty--;
      }

      if(Helper.offerState == true){
        Helper.offerData![index].cartQuantity = currentQty;
      }else{
        product[index].cartQuantity = currentQty;
      }
      product[index].cartQuantity = currentQty; // Assign as int
      counter[index].value = currentQty;       // Ensure value is int
      countersList[index] = currentQty;        // Store as int
    }


    update(["offer"]);

    if(Helper.offerState == true){
      Helper.offerData![index].actualPrice = (int.parse(double.parse(Helper.offerData![index].productPrice).round().toString()) * counter[index].value).toString();
    }

    if(Helper.offerState ==true){
      dynamic price = int.tryParse(Helper.offerData![index].productDiscountPrice?.toString() ?? '0') ?? 0;
      dynamic result = (price * (counter[index].value ?? 0)).toInt(); // Cast to int
      updatePrices[index] = result.toString(); // Store as string
      // product[index].productPrice = updatePrices[index].toString();
      updateProductIds[index] = Helper.offerData![index].productId.toString();
    }else{
      dynamic price = int.tryParse(product[index].productPriceDuplicate?.toString() ?? '0') ?? 0;
      dynamic result = (price * (counter[index].value ?? 0)).toInt(); // Cast to int
      updatePrices[index] = result.toString(); // Store as string
      // product[index].productPrice = updatePrices[index].toString();

      updateProductIds[index] = product[index].productId.toString();
    }

    update();
    if(Helper.offerState == true){
      offersController.update();
    }



    isLoading.value = true;

    // Call the AddCart API without the dialog and with decrement flag
    await AddCart(outerContext, index: index, showLoading: false, isIncrement: false);

    isLoading.value = false;

    // Show a toast for item update (optional)
    // Fluttertoast.showToast(
    //   msg: "Item Updated...",
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   backgroundColor: Colors.black,
    //   textColor: Colors.white,
    // );
    update();
  } catch (e) {
    print("DECREMENT ISSUE ====> ${e}");
  }
}



  Future<void> AddCart(BuildContext outerContext,
      {required int index, bool isConfirmed = false, bool showLoading = true, required bool isIncrement}) async {
    Map<String, dynamic> payload = {
      'customerId': AppPreference().UserId,
      'productId': Helper.productID,
      'qty': countersList[index],
    };

    isLoading.value = true;
    print("Payload: $payload");
    var response = await _connect.AddCart(payload);
    isLoading.value = false;

    final updatedCart = product[index];
    updatedCart.actualPrice = response.actualPrice ?? updatedCart.actualPrice;
    product[index] = updatedCart;
    update();

    print("add cart Response: ${response.message}");
    // No mismatch; item added to cart successfully
    Fluttertoast.showToast(
      msg: response.message ?? "Item added to cart",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
    update(); // Update the UI after successful addition
  }

  

  Future<Map<String, dynamic>> _fetchPriceFromApi() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return {'newPrice': 100.0}; // Example new price
  }


  ///dont delete this commented code

  AddWishListApi() async {
    Map<String, dynamic> payload = {
      "customerId": AppPreference().UserId,
      "productId": userDataProvider.product!.productId.toString(),
    };
    print("AddWishListPayload${payload}");
    var response = await _connect.AddWishList(payload);
    if (!response.error!) {
      HomeScreenApi();
      update();
    } else {}
  }

  deleteWishListApi() async {
    Map<String, dynamic> payload = {
      "customerId": AppPreference().UserId,
      "productId": userDataProvider.product!.productId.toString(),
    };
    print("AddWishListPayload${payload}");

    var response = await _connect.DeleteWishList(payload);

    print(response.error);
    if (!response.error!) {
      HomeScreenApi();
      update();
    } else {}
  }

  void updatePrice(int index) {
    if (index >= 0 && index < product.length && index < counter.length) {}
  }

  SearchProductApi() async { 
    
    Map<String, dynamic> payload = {'customerId': AppPreference().UserId,'searchKey':searchController.text};
    print(payload);
    
    //initialLoading.value = true;
    // Call the API (replace with your actual API function)
    print("Search product:::::::::${searchController.text}");
    var response = await _connect.SearchProduct(payload);
   // initialLoading.value = false;

    if (!response.error!) {
      searchproduct.value = response.data!; // Set the search results
      print("search -->${response.data!.first.actualPrice}");
      print(":::::::::::::response for search ${response.data!.length}");
      update();
    } else {
      // Handle API error here
    }
  }


  getParticularCustomerApi() async {
    print("SellerId ${AppPreference().UserId}");
    Map<String, dynamic> payload = {'customerId': AppPreference().UserId};
    print(" getParticularSeller_payload ${payload}");
    isLoading.value = true;
    var response = await _connect.GetParticularCustomer(payload);
    isLoading.value = false;
    print('getParticularSeller_Response${response.toJson()}');

    if (!response.error!) {
      getParticularCustomer = response.data;
      customerName.value = response.data!.customerName!;
      update();
    } else {}
  }

  OffersClickedApiService offeresclickedapiservice = OffersClickedApiService();

  List<OffersClickData> offersclikeddata=[];

  getoffersclicked({required String type , required String sellerid, required String contentId, required String coustomerId,})async{

    isLoading(true);
    offersclikeddata.clear();
    dio.Response<dynamic> response = await offeresclickedapiservice.offersclickedApi(
        type: type, contentId: contentId, sellerId: sellerid, coustomerId: coustomerId);

    isLoading(false);
    if(response.statusCode==200){
      OffersClickModel offersclickedmodel = OffersClickModel.fromJson(response.data);
      offersclikeddata = offersclickedmodel.data;
      Helper.offerData = offersclikeddata;
      print(">>>>>>>>>>>>controller____${Helper.offerData!.length}");
      //Get.to(navigateBar(initialIndex: 1,));


    }
    update();
  }

  RxBool isLoading1 = false.obs;

  OffersData? offersdata;

  OffersListApiService offerslistapiservice = OffersListApiService();

  getslideroffers(context) async {

    isLoading(true);

    dio.Response<dynamic> response = await offerslistapiservice.offerslistAPi();

    isLoading(false);
    if (response.statusCode == 200) {
      OfferesSliderModel offerslidermodel = await OfferesSliderModel.fromJson(response.data);
      offersdata = offerslidermodel.data;
      //  Fluttertoast.showToast(
      //   msg: response.statusMessage!,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      // );
      update();
    } else {
      MotionToast.success(
        title: const Text("",
            style: TextStyle(color: Colors.black, fontSize: 14)),
        description: Text(response.statusMessage ?? "",
            style: TextStyle(color: Colors.white, fontSize: 12)),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60,
        borderRadius: 10,
        displaySideBar: false,
        enableAnimation: false,
      ).show(context);
      // Fluttertoast.showToast(
      //   msg: response.statusMessage!,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      // );
    }
  }

}