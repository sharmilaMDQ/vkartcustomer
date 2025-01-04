import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PaymentDetailController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }

  TextEditingController totalAmountController = TextEditingController();
  TextEditingController paymentController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController securityCodeController = TextEditingController();
}
