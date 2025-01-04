import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:vkartcustomer/utility/AppPreference.dart';
import '../Apiconnect/ApiConnect.dart';
import '../Forms/AppSnackBar.dart';
import '../Pojo/DisplaySelectedProductScreenResponse.dart';
import '../Pojo/GetCartProductResponse.dart';
import '../Provider/ProductProvider.dart';

class DisplaySelectedProductController extends GetxController {
  late ProductProvider userDataProvider;
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool initialLoading = RxBool(true);
  RxBool isLoading = RxBool(false);
  late RxList<CartData> CartProdct = RxList();
  late RxList<SelectedProductData> Selectedproduct = RxList();
  bool isSelectCall = false;
  RxBool ProductName = RxBool(false);
  RxBool Category = RxBool(false);

  @override
  void onInit() async {
    super.onInit();
    userDataProvider = Provider.of<ProductProvider>(Get.context!, listen: false);
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

  SelectedScreenApi() async {
    Map<String, dynamic> payload = {
      'ProductName': userDataProvider.getWishListProducts!.productName,
      'productCategory': userDataProvider.getWishListProducts!.productCategory,
    };
    print(payload);

    var response = await _connect.DisplaySelectScreen(payload);
    print('SelectedScreenApiResponse ${response.toJson()}');
    if (!response.error!) {
      // AppSnackBar.success(message: response.message!);
      Selectedproduct.value = response.data!;
      isLoading.value = false;
      update();
    } else {
      AppSnackBar.error(message: response.message!);
    }
  }

  // DeleteAllCart() async {
  //   Map<String, dynamic> payload = {
  //     'customerId': AppPreference().UserId,
  //   };
  //   print(payload);
  //
  //   var response = await _connect.DeleteCartAll(payload);
  //   print('SelectedScreenApiResponse ${response.toJson()}');
  //   if (!response.error!) {
  //     initialLoading.value = false;
  //     update();
  //   } else {
  //
  //   }
  // }

  AddWishListApi() async {
    Map<String, dynamic> payload = {
      "customerId": AppPreference().UserId,
      "productId": userDataProvider.product!.productId.toString(),
    };
    print("AddWishListPayload${payload}");

    isLoading.value = true;
    var response = await _connect.AddWishList(payload);
    isLoading.value = false;

    if (!response.error!) {
      GetCartApi();
      SelectedScreenApi();
      update();
    } else {}
  }

  deleteWishListApi() async {
    Map<String, dynamic> payload = {
      "customerId": AppPreference().UserId,
      "productId": userDataProvider.product!.productId.toString(),
    };
    print("AddWishListPayload${payload}");
    isLoading.value = true;
    var response = await _connect.DeleteWishList(payload);
    isLoading.value = false;
    print(response.error);
    if (!response.error!) {
      GetCartApi();
      SelectedScreenApi();
      update();
    } else {}
  }

  CartApi(context) async {
    Map<String, dynamic> payload = {
      'userId': AppPreference().UserId,
      'productId': userDataProvider.wishListProducts!.productId,
      'qty': "3",
    };
    print("hukgu${payload}");
    isLoading.value = true;
    var response = await _connect.AddCart(payload);

    print('check!!the cart');
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      update();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => navigateBar()),
      // );
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
      //   msg: response.message!,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      // );
    }
    isLoading.value = false;
  }

  DeleteCartApi(context) async {
    Map<String, dynamic> payload = {'userId': AppPreference().UserId};
    print(payload);
    isLoading.value = true;
    var response = await _connect.DeleteCart(payload);
    isLoading.value = false;
    print("Delete Api Called ${response.toJson()}");
    if (!response.error!) {
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
      //   msg: response.message!,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      // );
      CartProdct.clear();
      GetCartApi();
      print('check Delete');
      // deletecartResponse = response;
      update();
    } else {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  DeleteAllCart() async {
    Map<String, dynamic> payload = {'userId': AppPreference().UserId};
    print(payload);
    isLoading.value = true;
    var response = await _connect.DeleteCart(payload);
    isLoading.value = false;
    print("Delete Api Called ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      GetCartApi();
      print('check Delete');
      // deletecartResponse = response;
      update();
    } else {}
  }
}
