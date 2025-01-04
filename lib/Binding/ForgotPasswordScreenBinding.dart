import 'package:get/get.dart';
import '../Controller/ForgotPasswordScreenController.dart';

class ForgotPasswordScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordScreenController>(
        () => ForgotPasswordScreenController());
  }
}
