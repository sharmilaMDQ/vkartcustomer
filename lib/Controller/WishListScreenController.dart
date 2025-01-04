import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Apiconnect/ApiConnect.dart';
import '../Models/ParticularCustomerResponseModel.dart';
import '../Models/SearchProductsResponse.dart';
import '../Models/wishListResponseModel.dart';
import '../Pojo/GetCartProductResponse.dart';
import '../Pojo/ProductHomeScreenResponse.dart';
import '../Provider/ProductProvider.dart';
import '../utility/AppPreference.dart';

class WishListScreenController extends GetxController with WidgetsBindingObserver {
  RxBool isVisible = false.obs;
  RxBool arrowIsVisible = false.obs;
  late ProductProvider userDataProvider;
  RxString ImageUrl = RxString('');
  ParticularCustomerResponseData? getParticularCustomer;
  RxString customerName = RxString("");
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

  TextEditingController searchController = TextEditingController();

  late RxList<Data> product = RxList();
  RxList<WishlistData> wishListProducts = RxList();
  late RxList<SearchProductsResponseData> searchproduct = RxList();
  late RxList<CartData> CartProdct = RxList();
  RxList<bool> onClickList = RxList();
  RxBool initialLoading = RxBool(false);
  RxBool isLoading = RxBool(true);
  RxBool isSearch = RxBool(false);
  RxBool isSearchVisible = RxBool(false);

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
    arrowIsVisible.value = !arrowIsVisible.value;
  }

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

  @override
  void onClose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance!.addObserver(this);
    getParticularCustomerApi();
    // HomeScreenApi()
  }

  @override
  void didChangeMetrics() {
    isSearch.value = WidgetsBinding.instance!.window.viewInsets.bottom > 0;
    update();
    print('VISIBLE');
  }

  GetCartApi() async {
    Map<String, dynamic> payload = {
      'userId': AppPreference().UserId,
      'productId': "",
    };
    print(payload);
    isLoading.value = true;
    var response = await _connect.GetCart(payload);

    print("CartScreen${response.toJson()}");

    if (!response.error!) {
      print('check cart api');
      CartProdct.value = response.data!;
      debugPrint("getAttendanceList: ${response.toJson()}");
      AppPreference().updateSellerId(response.data![0].sellerId.toString());
      // for (int i = 0; i < response.data!.length; i++) {
      //   onClickList.add(false);
      //   counter.add(RxInt(1));
      //   update();
      // }
    } else {
      // CartProdct = RxList();
    }
    isLoading.value = false;
  }

  wishListApi() async {
    Map<String, dynamic> payload = {
      "customerId": AppPreference().UserId.toString().trim(),
    };
    print("ProductPayloading${payload}");
    initialLoading.value = true;
    var response = await _connect.wishListApiCall(payload);
    initialLoading.value = false;
    print('HomeScreen_Response${response.toJson()}');
    if (!response.error!) {
      wishListProducts.value = response.data!;
      // userDataProvider.SetProductList(response.data!);
      // for (int i = 0; i < response.data!.length; i++) {
      //   onClickList.add(false);
      //   update();
      // }
      // update();
    } else {}
  }

  AddWishListApi() async {
    Map<String, dynamic> payload = {
      "customerId": AppPreference().UserId,
      "productId": userDataProvider.product!.productId.toString(),
    };
    print("AddWishListPayload${payload}");

    initialLoading.value = true;
    var response = await _connect.AddWishList(payload);
    initialLoading.value = false;

    if (!response.error!) {
      wishListApi();
      update();
    } else {}
  }

  deleteWishListApi() async {
    Map<String, dynamic> payload = {
      "customerId": AppPreference().UserId,
      "productId": userDataProvider.product!.productId.toString(),
    };
    print("AddWishListPayload${payload}");
    initialLoading.value = true;
    var response = await _connect.DeleteWishList(payload);
    initialLoading.value = false;
    print(response.error);
    if (!response.error!) {
      wishListApi();
      update();
    } else {}
  }

  SearchProductApi() async {
    Map<String, dynamic> payload = {'searchKey': searchController.value.text};
    print(payload);
    initialLoading.value = true;
    var response = await _connect.SearchProduct(payload);
    initialLoading.value = false;

    if (!response.error!) {
      searchproduct.value = response.data!;

      update();
    } else {}
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
    } else {}
  }
}
