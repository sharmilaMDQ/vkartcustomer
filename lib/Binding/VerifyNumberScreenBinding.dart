import 'package:get/get.dart';

import '../Controller/VerifyNumberScreenController.dart';

class VerifyNumberScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyNumberScreenController>(
        () => VerifyNumberScreenController());
  }
}
