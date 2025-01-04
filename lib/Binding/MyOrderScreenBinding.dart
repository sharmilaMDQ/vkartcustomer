import 'package:get/get.dart';
import '../Controller/MyOrderScreenController.dart';

class MyOrderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyOrderScreenController>(() => MyOrderScreenController());
  }
}
