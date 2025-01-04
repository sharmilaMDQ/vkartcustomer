import 'package:get/get.dart';
import '../Controller/DisplaySelectedScreenController.dart';

class DisplaySelectedScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DisplaySelectedProductController>(
        () => DisplaySelectedProductController());
  }
}
