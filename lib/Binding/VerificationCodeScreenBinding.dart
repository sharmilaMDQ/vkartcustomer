import 'package:get/get.dart';

import '../Controller/VerificationCodeScreenController.dart';

class VerificationCodeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationCodeScreenController>(
        () => VerificationCodeScreenController());
  }
}
