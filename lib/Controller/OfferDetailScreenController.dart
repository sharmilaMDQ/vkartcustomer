import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Apiconnect/ApiConnect.dart';
import '../Models/ParticularCustomerResponseModel.dart';
import '../Pojo/ProductHomeScreenResponse.dart';
import '../Provider/ProductProvider.dart';
import '../utility/AppPreference.dart';

class OfferDetailScreenController extends GetxController with WidgetsBindingObserver {
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
  late RxList<Data> searchproduct = RxList();
  RxBool initialLoading = RxBool(true);
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
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    getParticularCustomerApi();
  }

  @override
  void didChangeMetrics() {
    isSearch.value = WidgetsBinding.instance.window.viewInsets.bottom > 0;
    update();
    print('VISIBLE');
  }

  // HomeScreenApi() async {
  //
  //
  //   Map<String, dynamic> payload = {
  //     'latitude': "",//userDataProvider.getLatitude.toString(),
  //     'Longitude': ""//.getLongitude.toString(),
  //
  //   };    var response = await _connect.HomeScreen(payload);
  //   print('HomeScreen_Response${response.toJson()}');
  //
  //   if (!response.error!) {
  //     AppSnackBar.success(message: response.message!);
  //     product.value = response.data!;
  //     initialLoading.value = false;
  //     userDataProvider.SetProductList(response.data!);
  //     update();
  //   } else {
  //     AppSnackBar.error(message: response.message!);
  //   }
  // }

  // SearchProductApi() async {
  //   Map<String, dynamic> payload = {'searchKey': searchController.value.text};
  //   print(payload);
  //
  //   var response = await _connect.SearchProduct(payload);
  //   print('check!!!!!!!!!!!!!');
  //
  //   if (!response.error!) {
  //     searchproduct.value = response.data!;
  //     initialLoading.value = false;
  //
  //     update();
  //   } else {
  //     AppSnackBar.error(message: response.message!);
  //   }
  // }

  getParticularCustomerApi() async {
    print("SellerId ${AppPreference().UserId}");

    Map<String, dynamic> payload = {'customerId': AppPreference().UserId};
    print(" getParticularSeller_payload ${payload}");
    initialLoading.value = true;
    var response = await _connect.GetParticularCustomer(payload);

    print('getParticularSeller_Response${response.toJson()}');

    if (!response.error!) {
      // Fluttertoast.showToast(
      //   msg: response.message!,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      // );

      getParticularCustomer = response.data;
      customerName.value = response.data!.customerName!;
    } else {
      // Fluttertoast.showToast(
      //   msg: response.message!,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      // );
    }
    initialLoading.value = false;
  }
}
