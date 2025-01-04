import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import '../Controller/ChangePasswordScreenController.dart';

class ChangePasswordScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordScreenController>(
        () => ChangePasswordScreenController());
  }
}
