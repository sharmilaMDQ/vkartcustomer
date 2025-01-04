import 'package:get/get.dart';
import '../Controller/CartScreenController.dart';

class CartScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartScreenController>(() => CartScreenController());
  }
}
