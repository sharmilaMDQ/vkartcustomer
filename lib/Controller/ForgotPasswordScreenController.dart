import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

import '../Apiconnect/ApiConnect.dart';
import '../Pageroutes/App_routes.dart';

class ForgotPasswordScreenController extends GetxController {
  RxBool isLoading = RxBool(false);
  TextEditingController olsPassController = TextEditingController();
  TextEditingController usercontroller = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  RxBool initialLoading = RxBool(false);
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isVisible = false.obs;
    var isResendButtonActive = true.obs;
  var timerSeconds = 30.obs;
  Timer? _timer;
  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

   void startResendTimer() {
  isResendButtonActive.value = false;
  timerSeconds.value = 30;
  _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    if (timerSeconds.value == 0) {
      _timer?.cancel();
      isResendButtonActive.value = true; // Enable the resend button after countdown
    } else {
      timerSeconds.value--;
    }
  });
}
  @override
  void onClose() {
       _timer?.cancel();
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
  }

  ForgotPasswordApi(context) async {
    Map<String, dynamic> payload = {'mobileNumber': usercontroller.text};
    print("FogotPassword_payload ${payload}");
    isLoading.value = true;
    var response = await _connect.forgotPassword(payload);
    isLoading.value = false;
    print('FogotPassword_Response${response.toJson()}');

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
      // Get.toNamed(AppRoutes.root.toName);

      //update();
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
}
