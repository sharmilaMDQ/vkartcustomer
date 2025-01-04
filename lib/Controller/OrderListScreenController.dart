import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Apiconnect/ApiConnect.dart';
import '../Models/GetCustomerOrderLIstResponseModel.dart';
import '../Provider/ProductProvider.dart';
import '../utility/AppPreference.dart';

class OrderListScreenController extends GetxController {


  TextEditingController searchController = TextEditingController();
  RxBool initialLoading = RxBool(false);
  RxList<GetCustomerResponseModelData> getOrderList = RxList();
  late ProductProvider userDataProvider;
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isSearch = RxBool(false);
  RxBool isSearchVisible = RxBool(false);
  RxString sellerName = RxString("");
  RxBool isLoading = RxBool(false);
  
  @override
  void onInit() {
    super.onInit();
    userDataProvider = Provider.of<ProductProvider>(Get.context!, listen: false);
    getParticularSellerApi();
  }

  Future<void> refreshData() async {
    getParticularSellerApi();
    return Future.delayed(Duration(seconds: 0));
  }

  Future<void> getParticularSellerApi() async {
    Map<String, dynamic> payload = {
      'customerId': AppPreference().UserId,
    };
    print(" getParticularSeller_payload ${payload}");

    isLoading.value = true;
    var response = await _connect.GetCustomerOrderList(payload);
    isLoading.value = false;

    print('getOrderList_Response${response.toJson()}');
    log('LogResponse${response.toJson()}');
    if (!response.error!) {
      getOrderList.value = response.data!;
    } else {}
  }
}
